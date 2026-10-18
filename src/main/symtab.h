#ifndef SYMTAB_H
#define SYMTAB_H

/* Tabla de símbolos con ámbitos anidados. Pila de símbolos: el más reciente
   primero. El ámbito global tiene profundidad 0. */

#define SYM_VAR  1
#define SYM_FUNC 2

/* Layout del símbolo (LP64), 40 bytes:
   name@0 type@8 kind@12 depth@16 defined@20 next@24 decl@32 */
#define SYM_SIZE        40
#define SYM_TYPE_OFF    8
#define SYM_KIND_OFF    12
#define SYM_DEPTH_OFF   16
#define SYM_DEFINED_OFF 20
#define SYM_NEXT_OFF    24
#define SYM_DECL_OFF    32

void st_reset();
void st_push();
void st_pop();
int st_depth_now();

/* Declara en el ámbito actual. decl es el nodo N_DECL, N_PARAM o N_FUNC */
void *sym_declare(char *name, int type, int kind, void *decl);

/* Busca desde el ámbito más interno hacia afuera; nulo si no existe */
void *sym_lookup(char *name);

/* Busca solo en el ámbito actual */
void *sym_lookup_local(char *name);

char *sym_name(void *s);
int sym_type(void *s);
int sym_kind(void *s);
int sym_depth(void *s);
int sym_defined(void *s);
void *sym_next(void *s);
void *sym_decl(void *s);
void sym_set_defined(void *s, int v);

#endif
