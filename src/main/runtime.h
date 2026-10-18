#ifndef RUNTIME_H
#define RUNTIME_H

/* Servicios externos mínimos. Los implementa runtime.c (compilado con gcc),
   para que el código del compilador no dependa de la libc ni de sus headers. */
void *alloc(int n);
void copy_mem(char *dst, char *src, int n);
int str_eq(char *a, char *b);

#endif
