#ifndef SEMA_H
#define SEMA_H

/* Análisis semántico sobre el AST producido por parse().
   - Resuelve identificadores y llamadas (node_decl).
   - Calcula el tipo de cada expresión (node_type).
   - Marca N_DECL con value = 1 si es global.
   Reporta con report_error() y devuelve el número de errores. */
int analyze(void *program);

/* Nombre legible de un tipo: "int", "char*", "void**", "<error>" */
char *type_name(int t);

#endif
