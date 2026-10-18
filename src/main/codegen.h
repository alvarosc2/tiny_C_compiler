#ifndef CODEGEN_H
#define CODEGEN_H

/* Generador de código: AST ya analizado (sin errores) -> ensamblador NASM,
   sintaxis Intel, x86-64 Linux (System V). Devuelve el texto completo.
   Los símbolos de C se emiten con el prefijo '_' para no chocar con
   registros ni instrucciones (la función main es _main). */
char *generate(void *program);

#endif
