#ifndef PARSER_H
#define PARSER_H

/* Analiza el texto y devuelve un nodo N_PROGRAM (nunca nulo).
   Los errores se reportan con report_error(); consultar parse_error_count(). */
void *parse(char *source);
int parse_error_count();

#endif
