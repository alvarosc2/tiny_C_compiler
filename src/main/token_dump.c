#include <string.h>
#include "lexer.h"
#include "token_dump.h"

static const char *two_char_spelling(int kind) {
    switch (kind) {
    case T_EQ: return "==";
    case T_NE: return "!=";
    case T_LE: return "<=";
    case T_GE: return ">=";
    case T_AND: return "&&";
    case T_OR: return "||";
    }
    return NULL;
}

static const char *keyword_spelling(int kind) {
    switch (kind) {
    case T_INT: return "int";
    case T_CHAR: return "char";
    case T_VOID: return "void";
    case T_RETURN: return "return";
    case T_IF: return "if";
    case T_ELSE: return "else";
    case T_WHILE: return "while";
    }
    return NULL;
}

static int is_single_char_operator(int kind) {
    return kind < 256 && kind != 0 && strchr("+-*/%=!<>(){}[],;", kind) != NULL;
}

const char *token_spelling(int kind) {
    static char single[2];
    const char *s = keyword_spelling(kind);
    if (s) return s;
    s = two_char_spelling(kind);
    if (s) return s;
    if (is_single_char_operator(kind)) {
        single[0] = (char)kind;
        single[1] = 0;
        return single;
    }
    return NULL;
}

const char *token_category(int kind) {
    if (kind == T_EOF) return "Fin";
    if (kind == T_ID) return "Identificador";
    if (kind == T_NUM) return "Numero";
    if (kind == T_STR) return "Cadena";
    if (kind == T_CHRLIT) return "Caracter";
    if (kind == T_ERROR) return "Error";
    if (keyword_spelling(kind)) return "PalabraClave";
    if (two_char_spelling(kind) || is_single_char_operator(kind)) return "Operador";
    return "Desconocido";
}

void token_print(FILE *out, void *token) {
    int kind = token_kind(token);
    fprintf(out, "%d:%d: <%s>", token_line(token), token_col(token), token_category(kind));

    if (kind == T_ID || kind == T_ERROR) {
        fprintf(out, " %s", token_text(token));
    } else if (kind == T_STR) {
        fprintf(out, " \"%s\"", token_text(token));
    } else if (kind == T_NUM) {
        fprintf(out, " %d", token_value(token));
    } else if (kind == T_CHRLIT) {
        int v = token_value(token);
        if (v >= 32 && v < 127) fprintf(out, " '%c' (%d)", v, v);
        else fprintf(out, " (%d)", v);
    } else if (keyword_spelling(kind)) {
        fprintf(out, " %s", keyword_spelling(kind));
    } else if (two_char_spelling(kind)) {
        fprintf(out, " %s", two_char_spelling(kind));
    } else if (kind != T_EOF) {
        fprintf(out, " %c", kind);
    }
    fputc('\n', out);
}

void tokens_dump(FILE *out, char *source) {
    lexer_init(source);
    for (;;) {
        void *t = next_token();
        token_print(out, t);
        if (token_kind(t) == T_EOF) break;
    }
}
