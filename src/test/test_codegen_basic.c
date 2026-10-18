#include "codegen_helpers.h"

Test(codegen, return_constant) {
    cr_assert_eq(exit_of("return 42;"), 42);
}

Test(codegen, fall_off_main_returns_zero) {
    cr_assert_eq(exit_of("int x = 5; x = x + 1;"), 0);
}

Test(codegen, arithmetic) {
    cr_assert_eq(exit_of("return 2 + 3 * 4;"), 14);
    cr_assert_eq(exit_of("return (2 + 3) * 4;"), 20);
    cr_assert_eq(exit_of("return 100 - 58;"), 42);
    cr_assert_eq(exit_of("return 85 / 2;"), 42);
    cr_assert_eq(exit_of("return 0 - (0 - 42);"), 42);
    cr_assert_eq(exit_of("int a = 142; int b = 100; return a - a / b * b;"), 42);
}

Test(codegen, signed_division_truncates_toward_zero) {
    cr_assert_eq(exit_of("return (0 - 7) / 2 + 10;"), 7);
    cr_assert_eq(exit_of("int a = 0 - 7; return a - a / 3 * 3 + 10;"), 9);
}

Test(codegen, int_wraps_at_32_bits) {
    cr_assert_eq(exit_of("int x = 2147483647; x = x + 1; if (x < 0) return 1; return 0;"), 1);
}

Test(codegen, comparisons) {
    cr_assert_eq(exit_of("return (1 < 2) + (2 > 1) + (2 <= 2) + (3 >= 4) + (1 == 1) + (1 != 1);"), 4);
    cr_assert_eq(exit_of("return !0 + !5;"), 1);
}

Test(codegen, logic_short_circuits) {
    char *pre = "int x; int set(int v) { x = v; return v; }\n";
    char src[512], out[64];
    snprintf(src, sizeof(src), "%sint main() { 0 && set(1); return x; }", pre);
    cr_assert_eq(run_c(src, out, sizeof(out)), 0);
    snprintf(src, sizeof(src), "%sint main() { 1 || set(1); return x; }", pre);
    cr_assert_eq(run_c(src, out, sizeof(out)), 0);
    snprintf(src, sizeof(src), "%sint main() { 1 && set(7); return x; }", pre);
    cr_assert_eq(run_c(src, out, sizeof(out)), 7);
    cr_assert_eq(exit_of("return (3 && 4) + (0 || 5) + (0 && 1) + (0 || 0);"), 2);
}

Test(codegen, if_else_and_while) {
    cr_assert_eq(exit_of("if (1) return 1; else return 2;"), 1);
    cr_assert_eq(exit_of("if (0) return 1; else return 2;"), 2);
    cr_assert_eq(exit_of("int s = 0; int i = 1; while (i <= 10) { s = s + i; i = i + 1; } return s;"), 55);
}

Test(codegen, locals_and_scopes) {
    cr_assert_eq(exit_of("int a = 1; if (a) { int b = 2; a = a + b; } if (a) { int c = 10; a = a + c; } return a;"), 13);
}

Test(codegen, char_is_signed_and_truncates) {
    cr_assert_eq(exit_of("char c = 200; if (c < 0) return 1; return 0;"), 1);
    cr_assert_eq(exit_of("char c = 65; int i = c; return i;"), 65);
    cr_assert_eq(exit_of("char c = 'a'; return c;"), 97);
}

Test(codegen, assignment_statements) {
    cr_assert_eq(exit_of("int a; int b; b = 21; a = b; return a + b;"), 42);
}
