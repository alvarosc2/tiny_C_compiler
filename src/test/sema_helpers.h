#ifndef SEMA_HELPERS_H
#define SEMA_HELPERS_H

#include <criterion/criterion.h>
#include <stdio.h>
#include <string.h>
#include "../main/ast.h"
#include "../main/parser.h"
#include "../main/runtime.h"
#include "../main/sema.h"
#include "../main/tokens.h"

/* Parsea (exigiendo 0 errores sintacticos) y analiza en silencio.
   Devuelve el numero de errores semanticos; el texto queda en error_log(). */
static inline int check(char *src) {
    error_quiet(1);
    void *program = parse(src);
    cr_assert_eq(parse_error_count(), 0, "error de sintaxis en la prueba: %s", error_log());
    error_log_reset();
    return analyze(program);
}

#define PRELUDE \
    "int i; char c; char *s; int *ip; void *vp; int **pp; " \
    "int fi(int a); void fv(void); char *fs(char *p, int n);\n"

/* Tipo de una expresion dentro de un contexto con PRELUDE */
static inline char *type_of(char *expr) {
    static char src[2048];
    snprintf(src, sizeof(src), PRELUDE "void f(void) { %s; }", expr);
    error_quiet(1);
    void *program = parse(src);
    cr_assert_eq(parse_error_count(), 0);
    int errs = analyze(program);
    cr_assert_eq(errs, 0, "error semantico inesperado: %s", error_log());
    void *fn = node_a(program);
    while (node_next(fn)) fn = node_next(fn);
    void *stmt = node_a(node_b(fn));
    return type_name(node_type(node_a(stmt)));
}

/* Analiza una sentencia con PRELUDE; los errores quedan en error_log() */
static inline int check_stmt(char *stmt) {
    char src[2048];
    snprintf(src, sizeof(src), PRELUDE "void f(void) { %s }", stmt);
    return check(src);
}

#endif
