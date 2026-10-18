#include "lexer.h"
#include "runtime.h"

char *src;      // código fuente
int pos;        // posición actual

int is_alpha(int c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

int is_digit(int c) {
    return c >= '0' && c <= '9';
}

void lexer_init(char *source) {
    src = source;
    pos = 0;
}

int next_char() {
    return src[pos];
}

int advance() {
    return src[pos++];
}

void skip_spaces() {
    while (next_char() == ' ' || next_char() == '\n' ||
           next_char() == '\t' || next_char() == '\r') {
        advance();
    }
}

char *read_identifier() {
    int start = pos;
    while (is_alpha(next_char()) || is_digit(next_char()) || next_char() == '_') {
        advance();
    }
    int len = pos - start;
    char *p = alloc(len + 1);
    copy_mem(p, src + start, len);
    p[len] = 0;
    return p;
}

int read_number() {
    int n = 0;
    while (is_digit(next_char())) {
        n = n * 10 + (advance() - '0');
    }
    return n;
}

char *read_string() {
    advance(); // skip "
    int start = pos;
    while (next_char() != '"' && next_char() != 0) {
        advance();
    }
    int len = pos - start;
    char *p = alloc(len + 1);
    copy_mem(p, src + start, len);
    p[len] = 0;
    advance(); // skip closing "
    return p;
}

int read_char_literal() {
    advance(); // skip '
    int v = advance();
    if (v == '\\') {
        int e = advance();
        v = e;
        if (e == 'n') v = '\n';
        if (e == 'r') v = '\r';
        if (e == 't') v = '\t';
        if (e == '0') v = 0;
    }
    if (next_char() == '\'') advance(); // skip closing '
    return v;
}

void *make_token(int kind, char *text, int value) {
    char *p = alloc(TOKEN_SIZE);
    *(int *)(p + 0) = kind;
    *(char **)(p + TOKEN_TEXT_OFF) = text;
    *(int *)(p + TOKEN_VALUE_OFF) = value;
    return p;
}

int token_kind(void *t) { return *(int *)((char *)t + 0); }
char *token_text(void *t) { return *(char **)((char *)t + TOKEN_TEXT_OFF); }
int token_value(void *t) { return *(int *)((char *)t + TOKEN_VALUE_OFF); }

int keyword_kind(char *id) {
    if (str_eq(id, "int")) return T_INT;
    if (str_eq(id, "char")) return T_CHAR;
    if (str_eq(id, "void")) return T_VOID;
    if (str_eq(id, "return")) return T_RETURN;
    if (str_eq(id, "if")) return T_IF;
    if (str_eq(id, "else")) return T_ELSE;
    if (str_eq(id, "while")) return T_WHILE;
    return T_ID;
}

void *next_token() {
    skip_spaces();

    int c = next_char();
    if (c == 0) return make_token(T_EOF, 0, 0);

    // Identificador o palabra clave
    if (is_alpha(c) || c == '_') {
        char *id = read_identifier();
        return make_token(keyword_kind(id), id, 0);
    }

    // Número
    if (is_digit(c)) {
        int n = read_number();
        return make_token(T_NUM, 0, n);
    }

    // String
    if (c == '"') {
        char *s = read_string();
        return make_token(T_STR, s, 0);
    }

    // Literal de carácter
    if (c == '\'') {
        int v = read_char_literal();
        return make_token(T_CHRLIT, 0, v);
    }

    // Operadores de dos caracteres
    advance();
    int d = next_char();
    if (c == '=' && d == '=') { advance(); return make_token(T_EQ, 0, 0); }
    if (c == '!' && d == '=') { advance(); return make_token(T_NE, 0, 0); }
    if (c == '<' && d == '=') { advance(); return make_token(T_LE, 0, 0); }
    if (c == '>' && d == '=') { advance(); return make_token(T_GE, 0, 0); }
    if (c == '&' && d == '&') { advance(); return make_token(T_AND, 0, 0); }
    if (c == '|' && d == '|') { advance(); return make_token(T_OR, 0, 0); }
    if (c == '+' && d == '+') { advance(); return make_token(T_INC, 0, 0); }
    if (c == '-' && d == '-') { advance(); return make_token(T_DEC, 0, 0); }

    // Operadores simples
    return make_token(c, 0, 0);
}