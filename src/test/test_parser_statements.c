#include "parser_helpers.h"

#define STMT(name, src, expected) \
    Test(parser_stmt, name) { cr_assert_str_eq(stmt_sexpr(src), expected); }

STMT(decl, "int x;", "(Decl int x)")
STMT(decl_init, "int x = 1 + 2;", "(Decl int x (Binop + (Num 1) (Num 2)))")
STMT(decl_pointer, "char *s = \"a\";", "(Decl char* s (Str \"a\"))")
STMT(decl_double_pointer, "int **pp;", "(Decl int** pp)")
STMT(decl_void_pointer, "void *p = 0;", "(Decl void* p (Num 0))")
STMT(expr_stmt, "a = 1;", "(ExprStmt (Binop = (Id a) (Num 1)))")
STMT(call_stmt, "f(1);", "(ExprStmt (Call f (Num 1)))")

STMT(return_void, "return;", "(Return)")
STMT(return_value, "return 1;", "(Return (Num 1))")
STMT(return_expr, "return a + b;", "(Return (Binop + (Id a) (Id b)))")

STMT(if_only, "if (a) b;", "(If (Id a) (ExprStmt (Id b)))")
STMT(if_else, "if (a) b; else c;", "(If (Id a) (ExprStmt (Id b)) (ExprStmt (Id c)))")
STMT(dangling_else, "if (a) if (b) c; else d;",
     "(If (Id a) (If (Id b) (ExprStmt (Id c)) (ExprStmt (Id d))))")
STMT(else_if_chain, "if (a) b; else if (c) d; else e;",
     "(If (Id a) (ExprStmt (Id b)) (If (Id c) (ExprStmt (Id d)) (ExprStmt (Id e))))")
STMT(if_with_blocks, "if (a) { b; } else { c; }",
     "(If (Id a) (Block (ExprStmt (Id b))) (Block (ExprStmt (Id c))))")
STMT(if_return, "if (a) return 1;", "(If (Id a) (Return (Num 1)))")

STMT(while_stmt, "while (a) b;", "(While (Id a) (ExprStmt (Id b)))")
STMT(while_block, "while (i < 3) { i = i + 1; }",
     "(While (Binop < (Id i) (Num 3)) (Block (ExprStmt (Binop = (Id i) (Binop + (Id i) (Num 1))))))")
STMT(while_nested, "while (a) while (b) c;",
     "(While (Id a) (While (Id b) (ExprStmt (Id c))))")

STMT(sequence, "int a; a = 1; return a;",
     "(Decl int a) (ExprStmt (Binop = (Id a) (Num 1))) (Return (Id a))")
STMT(decl_inside_loop, "while (a) { int b = 1; }",
     "(While (Id a) (Block (Decl int b (Num 1))))")
STMT(cast_statement, "(char)x;", "(ExprStmt (Cast char (Id x)))")
STMT(deref_statement, "*p = 1;", "(ExprStmt (Binop = (Unop * (Id p)) (Num 1)))")

Test(parser_stmt, statements_are_linked_in_order) {
    error_quiet(1);
    void *p = parse("void f() { a; b; c; }");
    void *s = node_a(node_b(node_a(p)));
    cr_assert_str_eq(node_text(node_a(s)), "a");
    s = node_next(s);
    cr_assert_str_eq(node_text(node_a(s)), "b");
    s = node_next(s);
    cr_assert_str_eq(node_text(node_a(s)), "c");
    cr_assert_null(node_next(s));
}

Test(parser_stmt, if_without_else_has_null_c) {
    error_quiet(1);
    void *p = parse("void f() { if (a) b; }");
    void *n = node_a(node_b(node_a(p)));
    cr_assert_eq(node_kind(n), N_IF);
    cr_assert_null(node_c(n));
}
