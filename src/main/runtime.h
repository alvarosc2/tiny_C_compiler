#ifndef RUNTIME_H
#define RUNTIME_H

/* Servicios externos mínimos. Los implementa runtime.c (compilado con gcc),
   para que el código del compilador no dependa de la libc ni de sus headers. */
void *alloc(int n);
void copy_mem(char *dst, char *src, int n);
int str_eq(char *a, char *b);
char *str_cat(char *a, char *b);

/* Reporte de errores: escribe "archivo:linea:col: error: mensaje" en stderr
   y lo acumula en un registro consultable (útil para las pruebas). */
void set_source_name(char *name);
void report_error(int line, int col, char *msg);
char *error_log();
void error_log_reset();
void error_quiet(int quiet);

/* Búfer de salida de texto (para el generador de código) */
void emit_reset();
void emit(char *s);
void emit_char(int c);
void emit_int(int n);
char *emit_text();

#endif
