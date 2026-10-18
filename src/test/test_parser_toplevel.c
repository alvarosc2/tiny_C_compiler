#include "parser_helpers.h"

#define PROG(name, src, expected) \
    Test(parser_top, name) { cr_assert_str_eq(sexpr(src), expected); }

PROG(empty, "", "(Program)")
PROG(global, "int x;", "(Program (Decl int x))")
PROG(globals, "int x = 5; char *s;", "(Program (Decl int x (Num 5)) (Decl char* s))")
PROG(empty_function, "void f(void) { }", "(Program (Func void f (Block)))")
PROG(no_param_list, "int main() { return 0; }",
     "(Program (Func int main (Block (Return (Num 0)))))")
PROG(params, "int add(int a, int b) { return a + b; }",
     "(Program (Func int add (Param int a) (Param int b) "
     "(Block (Return (Binop + (Id a) (Id b))))))")
PROG(pointer_params, "void g(void *p, char **q) { }",
     "(Program (Func void g (Param void* p) (Param char** q) (Block)))")
PROG(pointer_return, "char *dup(char *s) { return s; }",
     "(Program (Func char* dup (Param char* s) (Block (Return (Id s)))))")
PROG(prototype, "int f(int a);", "(Program (Proto int f (Param int a)))")
PROG(prototype_void, "void h(void);", "(Program (Proto void h))")
PROG(mixed_order, "int g = 1; int f(void) { return g; } char c;",
     "(Program (Decl int g (Num 1)) (Func int f (Block (Return (Id g)))) (Decl char c))")
PROG(prototype_then_definition, "int f(int a); int f(int a) { return a; }",
     "(Program (Proto int f (Param int a)) "
     "(Func int f (Param int a) (Block (Return (Id a)))))")

Test(parser_top, type_encoding) {
    error_quiet(1);
    void *p = parse("int a; char *b; void **c;");
    void *d = node_a(p);
    cr_assert_eq(node_type(d), T_INT);
    d = node_next(d);
    cr_assert_eq(node_type(d), T_CHAR + TYPE_PTR_UNIT);
    d = node_next(d);
    cr_assert_eq(node_type(d), T_VOID + 2 * TYPE_PTR_UNIT);
    cr_assert_eq(type_base(node_type(d)), T_VOID);
    cr_assert_eq(type_ptrs(node_type(d)), 2);
}

Test(parser_top, positions) {
    error_quiet(1);
    void *p = parse("int x;\n  int y;");
    void *first = node_a(p);
    void *second = node_next(first);
    cr_assert_eq(node_line(first), 1);
    cr_assert_eq(node_col(first), 1);
    cr_assert_eq(node_line(second), 2);
    cr_assert_eq(node_col(second), 3);
    cr_assert_str_eq(node_text(second), "y");
}

Test(parser_top, valid_program_has_no_errors) {
    parse("int main(void) { int i = 0; while (i < 3) i++; return i; }");
    cr_assert_eq(parse_error_count(), 0);
    cr_assert_str_eq(error_log(), "");
}

Test(parser_top, sample_program_parses) {
    char *src =
        "int count = 0;\n"
        "char *msg = \"hola\";\n"
        "int main(void) {\n"
        "    int i = 0;\n"
        "    while (i <= 10 && msg[i] != '\\n') {\n"
        "        if (i == 5) return i++;\n"
        "        else count = count + 1;\n"
        "        i--;\n"
        "    }\n"
        "    return 0;\n"
        "}\n";
    error_quiet(1);
    parse(src);
    cr_assert_eq(parse_error_count(), 0, "%s", error_log());
}

Test(parser_top, ast_dump_is_indented) {
    char buf[1024] = {0};
    error_quiet(1);
    void *p = parse("int x = 1;");
    FILE *f = fmemopen(buf, sizeof(buf) - 1, "w");
    ast_dump(f, p);
    fclose(f);
    cr_assert_str_eq(buf,
        "Program  (1:1)\n"
        "  Decl int x  (1:1)\n"
        "    Num 1  (1:9)\n");
}
