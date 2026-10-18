#include "codegen_helpers.h"

Test(codegen_mem, globals) {
    char src[] = "int g = 40; char c = 'a'; char *m = \"hi\";\n"
                 "int u;\n"
                 "int main() { u = 2; return g + u + (*m == 'h') - (c == 97); }";
    char out[64];
    cr_assert_eq(run_c(src, out, sizeof(out)), 42);
}

Test(codegen_mem, string_indexing) {
    cr_assert_eq(exit_of("char *s = \"abc\"; return *(s + 2) - *s;"), 2);
}

static int run_rt(const char *body) {
    char src[4096], out[4096];
    snprintf(src, sizeof(src), "#include \"rt.h\"\nint main() {\n%s\n}\n", body);
    return run_c(src, out, sizeof(out));
}

Test(codegen_mem, int_pointer_arithmetic_scales) {
    cr_assert_eq(run_rt("int *p = alloc(40); *(p + 3) = 7; int *q = p + 3; return *q;"), 7);
    cr_assert_eq(run_rt("int *p = alloc(40); int *q = p + 5; return q - p;"), 5);
}

Test(codegen_mem, store_through_pointer) {
    cr_assert_eq(run_rt("int *p = alloc(8); *p = 40; *(p + 1) = 2; return *p + *(p + 1);"), 42);
}

Test(codegen_mem, char_buffer) {
    cr_assert_eq(run_rt("char *b = alloc(4); *b = 'o'; *(b + 1) = 'k'; return *b + *(b + 1) - 'o';"), 'k');
}

Test(codegen_mem, pointer_to_pointer) {
    cr_assert_eq(run_rt("int **pp = alloc(16); *(pp + 1) = alloc(8); *(*(pp + 1) + 1) = 42; return *(*(pp + 1) + 1);"), 42);
}

Test(codegen_mem, pointer_difference_scales) {
    cr_assert_eq(run_rt("int *p = alloc(16); int *q = p + 2; return q - p;"), 2);
}

Test(codegen_mem, null_comparison) {
    cr_assert_eq(run_rt("char *p = 0; if (p == 0) return 1; return 2;"), 1);
}

Test(codegen_mem, alloc_is_zeroed) {
    cr_assert_eq(run_rt("int *p = alloc(64); int i = 0; int s = 0; while (i < 16) { s = s + *(p + i); i = i + 1; } return s;"), 0);
}
