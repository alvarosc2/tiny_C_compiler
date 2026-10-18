#include "sema_helpers.h"

static void e1(char *src, char *msg) {
    cr_assert_eq(check(src), 1, "%s\n%s", src, error_log());
    cr_assert_str_eq(error_log(), msg, "%s", src);
}

Test(sema_decl, valid_program) {
    cr_assert_eq(check("int g = 1; char *m = \"x\";\n"
                       "int add(int a, int b);\n"
                       "int add(int a, int b) { return a + b; }\n"
                       "int main(void) { int k = add(g, 2); return k; }"), 0);
}

Test(sema_decl, use_before_declare) {
    e1("int f(void) { return g(); }\nint g(void) { return 1; }",
       "<entrada>:1:22: error: funcion 'g' no declarada\n");
}

Test(sema_decl, redeclared_same_scope) {
    e1("void f(void) { int a; int a; }",
       "<entrada>:1:23: error: 'a' ya esta declarado en este ambito\n");
}

Test(sema_decl, shadowing_is_allowed) {
    cr_assert_eq(check("int a; void f(int a) { { int a = 1; a = 2; } }"), 0);
}

Test(sema_decl, block_scope_ends) {
    cr_assert_eq(check("void f(void) { { int a; } a = 1; }"), 1);
}

Test(sema_decl, if_body_has_own_scope) {
    cr_assert_eq(check("void f(void) { if (1) int a; a = 1; }"), 1);
}

Test(sema_decl, param_and_local_clash) {
    cr_assert_eq(check("void f(int a) { int a; }"), 1);
}

Test(sema_decl, void_variable) {
    e1("void v;", "<entrada>:1:1: error: la variable 'v' no puede ser de tipo void\n");
}

Test(sema_decl, void_param) {
    e1("void f(void x) { }",
       "<entrada>:1:8: error: el parametro 'x' no puede ser de tipo void\n");
}

Test(sema_decl, init_type) {
    e1("char *p = 1;", "<entrada>:1:11: error: no se puede inicializar 'char*' con 'int'\n");
}

Test(sema_decl, global_init_must_be_constant) {
    e1("int a = 1;\nint b = a;",
       "<entrada>:2:9: error: el inicializador de 'b' debe ser una constante\n");
}

Test(sema_decl, local_init_sees_outer_name) {
    cr_assert_eq(check("int a; void f(void) { int a = a; }"), 0);
}

Test(sema_decl, prototype_then_definition) {
    cr_assert_eq(check("int f(int a);\nint f(int b) { return b; }"), 0);
}

Test(sema_decl, conflicting_signature) {
    e1("int f(int a);\nchar f(int a) { return 0; }",
       "<entrada>:2:1: error: declaracion de 'f' en conflicto con la anterior\n");
    cr_assert_eq(check("int f(int a);\nint f(char *a);"), 1);
}

Test(sema_decl, defined_twice) {
    e1("void f(void) { }\nvoid f(void) { }",
       "<entrada>:2:1: error: la funcion 'f' ya esta definida\n");
}

Test(sema_decl, return_checks) {
    e1("void f(void) { return 1; }",
       "<entrada>:1:16: error: una funcion void no puede retornar un valor\n");
    e1("int f(void) { return; }",
       "<entrada>:1:15: error: se esperaba un valor de retorno de tipo 'int'\n");
    e1("int f(void) { return \"a\"; }",
       "<entrada>:1:22: error: no se puede retornar 'char*' en una funcion que retorna 'int'\n");
}

Test(sema_decl, recursion_and_annotations) {
    error_quiet(1);
    void *p = parse("int g; int f(int n) { return f(n - 1) + g; }");
    cr_assert_eq(analyze(p), 0);
    void *decl = node_a(p);
    cr_assert_eq(node_value(decl), 1);
    void *fn = node_next(decl);
    void *ret = node_a(node_b(fn));
    void *add = node_a(ret);
    cr_assert_eq(node_decl(node_a(add)), fn);
    cr_assert_eq(node_decl(node_b(add)), decl);
}

Test(sema_decl, more_than_six_parameters) {
    e1("void f(int a, int b, int c, int d, int e, int g, int h) { }",
       "<entrada>:1:1: error: la funcion 'f' no puede tener mas de 6 parametros\n");
    cr_assert_eq(check("void f(int a, int b, int c, int d, int e, int g) { }"), 0);
}
