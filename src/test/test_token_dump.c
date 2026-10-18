#include <criterion/criterion.h>
#include <criterion/redirect.h>
#include <stdio.h>
#include <string.h>
#include "../main/token_dump.h"
#include "../main/tokens.h"

static void dump_to_buffer(char *source, char *buf, size_t size) {
    FILE *f = fmemopen(buf, size, "w");
    cr_assert_not_null(f);
    tokens_dump(f, source);
    fclose(f);
}

Test(token_dump, identifier_format) {
    char buf[256] = {0};
    dump_to_buffer("este_es_un_identificador", buf, sizeof(buf));
    cr_assert_str_eq(buf, "1:1: <Identificador> este_es_un_identificador\n1:25: <Fin>\n");
}

Test(token_dump, declaration) {
    char buf[512] = {0};
    dump_to_buffer("int x = 5;", buf, sizeof(buf));
    cr_assert_str_eq(buf,
        "1:1: <PalabraClave> int\n"
        "1:5: <Identificador> x\n"
        "1:7: <Operador> =\n"
        "1:9: <Numero> 5\n"
        "1:10: <Operador> ;\n"
        "1:11: <Fin>\n");
}

Test(token_dump, strings_chars_and_operators) {
    char buf[512] = {0};
    dump_to_buffer("\"hi\" 'a' '\\n' <= ++", buf, sizeof(buf));
    cr_assert_str_eq(buf,
        "1:1: <Cadena> \"hi\"\n"
        "1:6: <Caracter> 'a' (97)\n"
        "1:10: <Caracter> (10)\n"
        "1:15: <Operador> <=\n"
        "1:18: <Operador> ++\n"
        "1:20: <Fin>\n");
}

Test(token_dump, unknown_character) {
    char buf[256] = {0};
    dump_to_buffer("@", buf, sizeof(buf));
    cr_assert_str_eq(buf, "1:1: <Desconocido> @\n1:2: <Fin>\n");
}

Test(token_dump, multiline) {
    char buf[512] = {0};
    dump_to_buffer("int a;\n\n  return a;", buf, sizeof(buf));
    cr_assert_str_eq(buf,
        "1:1: <PalabraClave> int\n"
        "1:5: <Identificador> a\n"
        "1:6: <Operador> ;\n"
        "3:3: <PalabraClave> return\n"
        "3:10: <Identificador> a\n"
        "3:11: <Operador> ;\n"
        "3:12: <Fin>\n");
}

Test(token_dump, error_token) {
    char buf[256] = {0};
    dump_to_buffer("\"abc", buf, sizeof(buf));
    cr_assert_str_eq(buf, "1:1: <Error> cadena sin cerrar\n1:5: <Fin>\n");
}

Test(token_dump, categories) {
    cr_assert_str_eq(token_category(T_WHILE), "PalabraClave");
    cr_assert_str_eq(token_category(T_AND), "Operador");
    cr_assert_str_eq(token_category('['), "Operador");
    cr_assert_str_eq(token_category(T_EOF), "Fin");
}
