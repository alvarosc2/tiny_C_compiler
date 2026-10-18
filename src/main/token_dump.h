#ifndef TOKEN_DUMP_H
#define TOKEN_DUMP_H

#include <stdio.h>

/* Herramienta de depuración (solo gcc, fuera del subconjunto de bootstrap). */

/* Categoría legible: "Identificador", "PalabraClave", "Numero", ... */
const char *token_category(int kind);

/* Escribe una línea: L:C: <Categoria> texto */
void token_print(FILE *out, void *token);

/* Lexea todo el texto y escribe un token por línea hasta T_EOF. */
void tokens_dump(FILE *out, char *source);

#endif
