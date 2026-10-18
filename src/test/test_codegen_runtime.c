#include "codegen_helpers.h"

Test(codegen_rt, print_str_and_escapes) {
    cr_assert_str_eq(output_of("", "print_str(\"hola\\n\");"), "hola\n");
    cr_assert_str_eq(output_of("", "print_str(\"a\\tb\\\"c\\\\\\n\");"), "a\tb\"c\\\n");
}

Test(codegen_rt, print_int) {
    cr_assert_str_eq(output_of("", "print_int(0); print_char(' '); print_int(1234);"), "0 1234");
    cr_assert_str_eq(output_of("", "print_int(0 - 56);"), "-56");
    cr_assert_str_eq(output_of("", "print_int(2147483647); print_char(' '); print_int(0 - 2147483647 - 1);"),
                     "2147483647 -2147483648");
}

Test(codegen_rt, string_helpers) {
    cr_assert_str_eq(output_of("", "print_int(str_len(\"hello\"));"), "5");
    cr_assert_str_eq(output_of("", "print_int(str_eq(\"ab\", \"ab\")); print_int(str_eq(\"ab\", \"ac\"));"), "10");
    cr_assert_str_eq(output_of("", "print_str(str_cat(\"foo\", \"bar\"));"), "foobar");
}

Test(codegen_rt, large_allocation) {
    cr_assert_str_eq(output_of("", "char *p = alloc(3000000); p[2999999] = 'x'; print_char(p[2999999]);"), "x");
}

Test(codegen_rt, hello_example) {
    char out[4096];
    int rc = system("scripts/cc.sh examples/hello.c /tmp/tcc_hello_test >/dev/null 2>&1");
    cr_assert_eq(rc, 0);
    FILE *p = popen("/tmp/tcc_hello_test", "r");
    size_t n = fread(out, 1, sizeof(out) - 1, p);
    out[n] = 0;
    pclose(p);
    cr_assert(strstr(out, "10! = 3628800\n") != NULL);
}
