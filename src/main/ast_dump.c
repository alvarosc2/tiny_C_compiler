#include "ast.h"
#include "ast_dump.h"
#include "token_dump.h"
#include "tokens.h"

static void print_type(FILE *out, int type) {
    int base = type_base(type);
    fputs(base == T_INT ? "int" : base == T_CHAR ? "char" : "void", out);
    for (int i = 0; i < type_ptrs(type); i++) fputc('*', out);
}

void ast_print_label(FILE *out, void *n) {
    switch (node_kind(n)) {
    case N_PROGRAM: fputs("Program", out); break;
    case N_FUNC:
        fputs(node_b(n) ? "Func " : "Proto ", out);
        print_type(out, node_type(n));
        fprintf(out, " %s", node_text(n));
        break;
    case N_PARAM:
    case N_DECL:
        fputs(node_kind(n) == N_PARAM ? "Param " : "Decl ", out);
        print_type(out, node_type(n));
        fprintf(out, " %s", node_text(n));
        break;
    case N_BLOCK: fputs("Block", out); break;
    case N_IF: fputs("If", out); break;
    case N_WHILE: fputs("While", out); break;
    case N_RETURN: fputs("Return", out); break;
    case N_EXPR_STMT: fputs("ExprStmt", out); break;
    case N_BINOP: fprintf(out, "Binop %s", token_spelling(node_value(n))); break;
    case N_UNOP: fprintf(out, "Unop %s", token_spelling(node_value(n))); break;
    case N_CAST:
        fputs("Cast ", out);
        print_type(out, node_type(n));
        break;
    case N_INDEX: fputs("Index", out); break;
    case N_POSTFIX: fprintf(out, "Postfix %s", token_spelling(node_value(n))); break;
    case N_CALL: fprintf(out, "Call %s", node_text(n)); break;
    case N_ID: fprintf(out, "Id %s", node_text(n)); break;
    case N_STR: fprintf(out, "Str \"%s\"", node_text(n)); break;
    case N_NUM: fprintf(out, "Num %d", node_value(n)); break;
    case N_CHR: fprintf(out, "Chr %d", node_value(n)); break;
    default: fprintf(out, "?%d", node_kind(n)); break;
    }
}

/* Los hijos están en a, b y c; cada uno puede ser una lista enlazada por next */
static void dump_rec(FILE *out, void *n, int depth) {
    for (int i = 0; i < depth; i++) fputs("  ", out);
    ast_print_label(out, n);
    fprintf(out, "  (%d:%d)\n", node_line(n), node_col(n));
    void *slots[3] = {node_a(n), node_b(n), node_c(n)};
    for (int s = 0; s < 3; s++)
        for (void *c = slots[s]; c; c = node_next(c)) dump_rec(out, c, depth + 1);
}

void ast_dump(FILE *out, void *n) {
    dump_rec(out, n, 0);
}

void ast_sexpr(FILE *out, void *n) {
    fputc('(', out);
    ast_print_label(out, n);
    void *slots[3] = {node_a(n), node_b(n), node_c(n)};
    for (int s = 0; s < 3; s++)
        for (void *c = slots[s]; c; c = node_next(c)) {
            fputc(' ', out);
            ast_sexpr(out, c);
        }
    fputc(')', out);
}
