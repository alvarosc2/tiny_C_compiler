#ifndef AST_DUMP_H
#define AST_DUMP_H

#include <stdio.h>

/* Herramientas de depuración (solo gcc, fuera del subconjunto de bootstrap). */

/* Si on != 0, las expresiones muestran " : tipo" (requiere analyze) */
void ast_show_types(int on);

/* Etiqueta de un nodo: "Binop +", "Decl char* s", "Num 5", ... */
void ast_print_label(FILE *out, void *node);

/* Árbol con sangría y posición (línea:columna), una línea por nodo */
void ast_dump(FILE *out, void *node);

/* Forma compacta (Etiqueta hijo hijo ...), pensada para las pruebas */
void ast_sexpr(FILE *out, void *node);

#endif
