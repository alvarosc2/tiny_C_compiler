#include <stdio.h>
#include <stdlib.h>
#include "token_dump.h"

static char *read_file(const char *path) {
    FILE *f = fopen(path, "rb");
    if (!f) {
        perror(path);
        return NULL;
    }
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);

    char *buf = malloc(size + 1);
    if (!buf) {
        fclose(f);
        return NULL;
    }
    size_t n = fread(buf, 1, size, f);
    buf[n] = 0;
    fclose(f);
    return buf;
}

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "uso: %s archivo.c\n", argv[0]);
        return 2;
    }

    char *source = read_file(argv[1]);
    if (!source) return 1;

    tokens_dump(stdout, source);
    free(source);
    return 0;
}
