#ifndef PARSER_HELPERS_H
#define PARSER_HELPERS_H

#include <criterion/criterion.h>
#include <stdio.h>
#include <string.h>
#include "../main/ast.h"
#include "../main/ast_dump.h"
#include "../main/parser.h"
#include "../main/runtime.h"
#include "../main/tokens.h"

/* Analiza el texto (sin imprimir errores) y devuelve el AST en forma compacta */
static inline char *sexpr(char *src) {
    static char buf[16384];
    memset(buf, 0, sizeof(buf));
    error_quiet(1);
    void *program = parse(src);
    FILE *f = fmemopen(buf, sizeof(buf) - 1, "w");
    ast_sexpr(f, program);
    fclose(f);
    return buf;
}

/* Quita el envoltorio "(Program (Func void f (Block " ... ")))" de una sentencia */
static inline char *unwrap(char *s, const char *prefix, const char *suffix) {
    size_t lp = strlen(prefix), ls = strlen(suffix), len = strlen(s);
    if (len < lp + ls || strncmp(s, prefix, lp) != 0 || strcmp(s + len - ls, suffix) != 0)
        return s;
    s[len - ls] = 0;
    return s + lp;
}

static inline char *stmt_sexpr(char *stmts) {
    char src[1024];
    snprintf(src, sizeof(src), "void f() { %s }", stmts);
    return unwrap(sexpr(src), "(Program (Func void f (Block ", ")))");
}

static inline char *expr_sexpr(char *expr) {
    char src[1024];
    snprintf(src, sizeof(src), "void f() { %s; }", expr);
    return unwrap(sexpr(src), "(Program (Func void f (Block (ExprStmt ", "))))");
}

#endif
