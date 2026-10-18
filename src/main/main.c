#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast_dump.h"
#include "codegen.h"
#include "parser.h"
#include "runtime.h"
#include "sema.h"
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

static int has_flag(const char *s) {
    return s[0] == '-' && s[1] == '-';
}

int main(int argc, char **argv) {
    const char *mode = "--check";
    const char *path = NULL;

    for (int i = 1; i < argc; i++) {
        if (has_flag(argv[i])) mode = argv[i];
        else if (!path) path = argv[i];
        else path = NULL, i = argc;
    }
    int mode_ok = strcmp(mode, "--check") == 0 || strcmp(mode, "--tokens") == 0 ||
                  strcmp(mode, "--ast") == 0 ||
                  strcmp(mode, "--types") == 0 || strcmp(mode, "--asm") == 0;
    if (!path || !mode_ok) {
        fprintf(stderr, "uso: %s [--tokens | --ast | --types | --asm] archivo.c\n", argv[0]);
        return 2;
    }

    char *source = read_file(path);
    if (!source) return 1;

    int status = 0;
    if (strcmp(mode, "--tokens") == 0) {
        tokens_dump(stdout, source);
    } else {
        set_source_name((char *)path);
        void *program = parse(source);
        if (parse_error_count() > 0) status = 1;
        else if (strcmp(mode, "--ast") == 0) ast_dump(stdout, program);
        else {
            if (analyze(program) > 0) status = 1;
            else if (strcmp(mode, "--asm") == 0) fputs(generate(program), stdout);
            else if (strcmp(mode, "--types") == 0) {
                ast_show_types(1);
                ast_dump(stdout, program);
            }
        }
    }
    free(source);
    return status;
}
