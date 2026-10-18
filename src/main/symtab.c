#include "symtab.h"
#include "runtime.h"

void *st_top;   // símbolo más reciente
int st_depth;   // profundidad del ámbito actual

char *sym_name(void *s) { return *(char **)((char *)s + 0); }
int sym_type(void *s) { return *(int *)((char *)s + SYM_TYPE_OFF); }
int sym_kind(void *s) { return *(int *)((char *)s + SYM_KIND_OFF); }
int sym_depth(void *s) { return *(int *)((char *)s + SYM_DEPTH_OFF); }
int sym_defined(void *s) { return *(int *)((char *)s + SYM_DEFINED_OFF); }
void *sym_next(void *s) { return *(void **)((char *)s + SYM_NEXT_OFF); }
void *sym_decl(void *s) { return *(void **)((char *)s + SYM_DECL_OFF); }
void sym_set_defined(void *s, int v) { *(int *)((char *)s + SYM_DEFINED_OFF) = v; }

void st_reset() {
    st_top = 0;
    st_depth = 0;
}

int st_depth_now() {
    return st_depth;
}

void st_push() {
    st_depth = st_depth + 1;
}

// Al salir de un ámbito se descartan sus símbolos
void st_pop() {
    while (st_top != 0 && sym_depth(st_top) == st_depth) {
        st_top = sym_next(st_top);
    }
    st_depth = st_depth - 1;
}

void *sym_declare(char *name, int type, int kind, void *decl) {
    char *s = alloc(SYM_SIZE);
    *(char **)(s + 0) = name;
    *(int *)(s + SYM_TYPE_OFF) = type;
    *(int *)(s + SYM_KIND_OFF) = kind;
    *(int *)(s + SYM_DEPTH_OFF) = st_depth;
    *(void **)(s + SYM_NEXT_OFF) = st_top;
    *(void **)(s + SYM_DECL_OFF) = decl;
    st_top = s;
    return s;
}

void *sym_lookup(char *name) {
    void *s = st_top;
    while (s != 0) {
        if (str_eq(sym_name(s), name)) return s;
        s = sym_next(s);
    }
    return 0;
}

void *sym_lookup_local(char *name) {
    void *s = st_top;
    while (s != 0 && sym_depth(s) == st_depth) {
        if (str_eq(sym_name(s), name)) return s;
        s = sym_next(s);
    }
    return 0;
}
