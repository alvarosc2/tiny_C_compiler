#ifndef TOKENS_H
#define TOKENS_H

/* Tipos de token. Solo #define (sin enum) para que el compilador
   pueda procesar este archivo tras un preprocesado simple. */
#define T_EOF    256
#define T_ID     257
#define T_NUM    258
#define T_STR    259

#define T_INT    260
#define T_CHAR   261
#define T_VOID   262
#define T_RETURN 263
#define T_IF     264
#define T_ELSE   265
#define T_WHILE  266

#define T_EQ     267
#define T_NE     268
#define T_LE     269
#define T_GE     270
#define T_AND    271
#define T_OR     272
#define T_CHRLIT 273
#define T_ERROR  274

/* Layout del token (LP64): kind@0, line@4, text@8, value@16, col@20 */
#define TOKEN_SIZE       24
#define TOKEN_LINE_OFF   4
#define TOKEN_TEXT_OFF   8
#define TOKEN_VALUE_OFF  16
#define TOKEN_COL_OFF    20

#endif
