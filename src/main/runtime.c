#include <stdlib.h>
#include <string.h>
#include "runtime.h"

void *alloc(int n) {
    return calloc(1, n);
}

void copy_mem(char *dst, char *src, int n) {
    memcpy(dst, src, n);
}

int str_eq(char *a, char *b) {
    return strcmp(a, b) == 0;
}
