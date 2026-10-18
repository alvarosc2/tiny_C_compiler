#ifndef CODEGEN_HELPERS_H
#define CODEGEN_HELPERS_H

#include <criterion/criterion.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

/* Compila 'src' con el pipeline real (scripts/cc.sh: cpp, tcc, nasm, ld),
   lo ejecuta y devuelve su codigo de salida. La salida estandar queda en out. */
static inline int run_c(const char *src, char *out, size_t out_size) {
    char dir[] = "/tmp/tcc_test_XXXXXX";
    cr_assert_not_null(mkdtemp(dir));
    char cmd[512];
    snprintf(cmd, sizeof(cmd), "%s/prog.c", dir);
    FILE *f = fopen(cmd, "w");
    cr_assert_not_null(f);
    fputs(src, f);
    fclose(f);

    snprintf(cmd, sizeof(cmd), "scripts/cc.sh %s/prog.c %s/prog 2>&1", dir, dir);
    int rc = system(cmd);
    cr_assert_eq(rc, 0, "fallo la compilacion de:\n%s", src);

    snprintf(cmd, sizeof(cmd), "%s/prog", dir);
    FILE *p = popen(cmd, "r");
    cr_assert_not_null(p);
    size_t n = fread(out, 1, out_size - 1, p);
    out[n] = 0;
    int status = pclose(p);
    snprintf(cmd, sizeof(cmd), "rm -rf %s", dir);
    (void)!system(cmd);
    return WIFEXITED(status) ? WEXITSTATUS(status) : -1;
}

/* Codigo de salida de 'int main() { body }' */
static inline int exit_of(const char *body) {
    char src[4096], out[4096];
    snprintf(src, sizeof(src), "int main() {\n%s\n}\n", body);
    return run_c(src, out, sizeof(out));
}

/* Salida estandar de un programa con #include "rt.h" y 'int main() { body }' */
static inline const char *output_of(const char *prelude, const char *body) {
    static char out[8192];
    char src[8192];
    snprintf(src, sizeof(src), "#include \"rt.h\"\n%s\nint main() {\n%s\nreturn 0;\n}\n",
             prelude, body);
    int rc = run_c(src, out, sizeof(out));
    cr_assert_eq(rc, 0, "salida inesperada %d", rc);
    return out;
}

#endif
