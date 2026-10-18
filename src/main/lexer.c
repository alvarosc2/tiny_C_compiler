#include "lexer.h"
#include "runtime.h"

char *src;      // código fuente
int pos;        // posición actual
int line;       // línea actual (desde 1)
int col;        // columna actual (desde 1)
int tok_line;   // línea donde empieza el token en curso
int tok_col;    // columna donde empieza el token en curso
int lex_ok;     // 0 si el último literal es inválido (sin cerrar o fuera de rango)

int is_alpha(int c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

int is_digit(int c) {
    return c >= '0' && c <= '9';
}

void lexer_init(char *source) {
    src = source;
    pos = 0;
    line = 1;
    col = 1;
    tok_line = 1;
    tok_col = 1;
}

int next_char() {
    return *(src + pos);
}

int advance() {
    int c = *(src + pos);
    if (c == 0) return 0; // nunca avanzar más allá del fin
    pos = pos + 1;
    if (c == '\n') {
        line = line + 1;
        col = 1;
    } else {
        col = col + 1;
    }
    return c;
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
    *(p + len) = 0;
    return p;
}

int read_number() {
    int n = 0;
    lex_ok = 1;
    while (is_digit(next_char())) {
        int d = advance() - '0';
        // n * 10 + d > 2147483647, sin desbordar al comprobarlo
        if (n > (2147483647 - d) / 10) lex_ok = 0;
        else n = n * 10 + d;
    }
    return n;
}

char *read_string() {
    advance(); // skip "
    int start = pos;
    while (next_char() != '"' && next_char() != 0) {
        if (advance() == '\\' && next_char() != 0) advance();
    }
    lex_ok = next_char() == '"';
    int len = pos - start;
    char *p = alloc(len + 1);
    int i = 0;
    int j = 0;
    while (i < len) {
        int c = *(src + start + i);
        i = i + 1;
        // Escapes: \n \t \r \\ \" ; cualquier otro \x produce x
        if (c == '\\' && i < len) {
            c = *(src + start + i);
            i = i + 1;
            if (c == 'n') c = '\n';
            if (c == 't') c = '\t';
            if (c == 'r') c = '\r';
        }
        *(p + j) = c;
        j = j + 1;
    }
    *(p + j) = 0;
    advance(); // skip closing "
    return p;
}

int read_char_literal() {
    advance(); // skip '
    int v = advance();
    if (v == 0) {
        lex_ok = 0;
        return 0;
    }
    if (v == '\\') {
        int e = advance();
        v = e;
        if (e == 'n') v = '\n';
        if (e == 'r') v = '\r';
        if (e == 't') v = '\t';
        if (e == '0') v = 0;
    }
    lex_ok = next_char() == '\'';
    if (lex_ok) advance(); // skip closing '
    return v;
}

void *make_token(int kind, char *text, int value) {
    char *p = alloc(TOKEN_SIZE);
    *(int *)(p + 0) = kind;
    *(int *)(p + TOKEN_LINE_OFF) = tok_line;
    *(int *)(p + TOKEN_COL_OFF) = tok_col;
    *(char **)(p + TOKEN_TEXT_OFF) = text;
    *(int *)(p + TOKEN_VALUE_OFF) = value;
    return p;
}

int token_kind(void *t) { return *(int *)((char *)t + 0); }
char *token_text(void *t) { return *(char **)((char *)t + TOKEN_TEXT_OFF); }
int token_value(void *t) { return *(int *)((char *)t + TOKEN_VALUE_OFF); }
int token_line(void *t) { return *(int *)((char *)t + TOKEN_LINE_OFF); }
int token_col(void *t) { return *(int *)((char *)t + TOKEN_COL_OFF); }

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
    tok_line = line;
    tok_col = col;

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
        if (!lex_ok) return make_token(T_ERROR, "numero demasiado grande", 0);
        return make_token(T_NUM, 0, n);
    }

    // String
    if (c == '"') {
        char *s = read_string();
        if (!lex_ok) return make_token(T_ERROR, "cadena sin cerrar", 0);
        return make_token(T_STR, s, 0);
    }

    // Literal de carácter
    if (c == '\'') {
        int v = read_char_literal();
        if (!lex_ok) return make_token(T_ERROR, "caracter sin cerrar", 0);
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

    // Operadores simples
    return make_token(c, 0, 0);
}