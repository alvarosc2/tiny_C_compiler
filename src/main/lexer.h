#ifndef LEXER_H
#define LEXER_H

#include "tokens.h"

void lexer_init(char *source);
int token_kind(void *t);
char *token_text(void *t);
int token_value(void *t);

int next_char();
int advance();
void skip_spaces();
char *read_identifier();
int read_number();
char *read_string();
int read_char_literal();
void *make_token(int kind, char *text, int value);
void *next_token();

#endif