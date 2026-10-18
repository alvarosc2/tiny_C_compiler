#include "rt.h"
#include "runtime.h"
#include "parser.h"
#include "sema.h"
#include "codegen.h"

// Linea de comandos del compilador auto-alojado: sin libc, sin depuracion.
//   tcc [--check | --asm] archivo.c      (ya preprocesado con cpp -P)

int usage() {
    char *m = "uso: tcc [--check | --asm] archivo.c\n";
    write_all(2, m, str_len(m));
    return 2;
}

int main(int argc, char **argv) {
    int want_asm = 0;
    char *path = 0;
    int i = 1;
    while (i < argc) {
        char *a = *(argv + i);
        if (*(a + 0) == '-' && *(a + 1) == '-') {
            if (str_eq(a, "--asm")) want_asm = 1;
            else if (str_eq(a, "--check")) want_asm = 0;
            else return usage();
        } else {
            if (path != 0) return usage();
            path = a;
        }
        i = i + 1;
    }
    if (path == 0) return usage();

    char *source = read_file(path);
    if (source == 0) {
        char *m = str_cat(str_cat("no se puede leer ", path), "\n");
        write_all(2, m, str_len(m));
        return 1;
    }
    set_source_name(path);
    void *program = parse(source);
    if (parse_error_count() > 0) return 1;
    if (analyze(program) > 0) return 1;
    if (want_asm) {
        char *text = generate(program);
        if (!write_all(1, text, str_len(text))) return 1;
    }
    return 0;
}
