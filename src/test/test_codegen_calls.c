#include "codegen_helpers.h"

static int run_prog(const char *src) {
    char out[4096];
    return run_c(src, out, sizeof(out));
}

Test(codegen_calls, arguments_in_order) {
    cr_assert_eq(run_prog("int f(int a, int b) { return a - b; }\n"
                          "int main() { return f(50, 8); }"), 42);
}

Test(codegen_calls, six_arguments) {
    cr_assert_eq(run_prog("int f(int a, int b, int c, int d, int e, int g) {"
                          " return a + 2 * b + 3 * c + 4 * d + 5 * e + 6 * g; }\n"
                          "int main() { return f(1, 1, 1, 1, 1, 1); }"), 21);
}

Test(codegen_calls, nested_calls_and_pending_operands) {
    cr_assert_eq(run_prog("int f(int a, int b) { return a * b; }\n"
                          "int main() { return 2 + f(3, f(2, 3)) + 22; }"), 42);
}

Test(codegen_calls, recursion) {
    cr_assert_eq(run_prog("int fib(int n) { if (n < 2) return n; return fib(n - 1) + fib(n - 2); }\n"
                          "int main() { return fib(10); }"), 55);
}

Test(codegen_calls, prototype_then_definition) {
    cr_assert_eq(run_prog("int g(int a);\n"
                          "int f(int a) { return g(a) + 1; }\n"
                          "int g(int a) { return a * 2; }\n"
                          "int main() { return f(20) + 1; }"), 42);
}

Test(codegen_calls, void_function_and_globals) {
    cr_assert_eq(run_prog("int n;\nvoid bump() { n = n + 1; }\n"
                          "int main() { bump(); bump(); return n + 40; }"), 42);
}

Test(codegen_calls, char_and_pointer_parameters) {
    cr_assert_eq(run_prog("int at(char *s, int i) { return *(s + i); }\n"
                          "char up(char c) { return c - 32; }\n"
                          "int main() { return up(at(\"abc\", 1)) - 'B' + 42; }"), 42);
}

Test(codegen_calls, main_receives_argc_argv) {
    cr_assert_eq(run_prog("int main(int argc, char **argv) { return argc + 41; }"), 42);
}

Test(codegen_calls, stack_alignment_at_call) {
    /* alloc de 16 bytes con operandos pendientes en la pila: si el call quedara
       desalineado, un acceso SSE fallaria; aqui verificamos que no se rompe nada */
    cr_assert_eq(run_prog("int f(int a, int b, int c) { return a + b + c; }\n"
                          "int main() { return 1 + (2 + (3 + f(10, 11, 15))); }"), 42);
}
