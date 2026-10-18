#include "parser_helpers.h"

#define EXPR(name, src, expected) \
    Test(parser_expr, name) { cr_assert_str_eq(expr_sexpr(src), expected); }

EXPR(number, "42", "(Num 42)")
EXPR(identifier, "x", "(Id x)")
EXPR(char_literal, "'a'", "(Chr 97)")
EXPR(string_literal, "\"hi\"", "(Str \"hi\")")

EXPR(mul_binds_tighter, "1 + 2 * 3", "(Binop + (Num 1) (Binop * (Num 2) (Num 3)))")
EXPR(mul_first, "1 * 2 + 3", "(Binop + (Binop * (Num 1) (Num 2)) (Num 3))")
EXPR(sub_left_assoc, "1 - 2 - 3", "(Binop - (Binop - (Num 1) (Num 2)) (Num 3))")
EXPR(parens_override, "(1 + 2) * 3", "(Binop * (Binop + (Num 1) (Num 2)) (Num 3))")
EXPR(nested_parens, "((x))", "(Id x)")

EXPR(or_lower_than_and, "a || b && c", "(Binop || (Id a) (Binop && (Id b) (Id c)))")
EXPR(and_left_assoc, "a && b && c", "(Binop && (Binop && (Id a) (Id b)) (Id c))")
EXPR(equality_lower_than_relational, "a == b < c",
     "(Binop == (Id a) (Binop < (Id b) (Id c)))")
EXPR(relational_before_equality, "a < b == c",
     "(Binop == (Binop < (Id a) (Id b)) (Id c))")
EXPR(relational_lower_than_additive, "a + b >= c - d",
     "(Binop >= (Binop + (Id a) (Id b)) (Binop - (Id c) (Id d)))")
EXPR(not_equal, "a != b", "(Binop != (Id a) (Id b))")
EXPR(le_gt, "a <= b > c", "(Binop > (Binop <= (Id a) (Id b)) (Id c))")

EXPR(assignment_lowest, "a = b || c", "(Binop = (Id a) (Binop || (Id b) (Id c)))")
EXPR(assign_deref, "*p = 1", "(Binop = (Unop * (Id p)) (Num 1))")

EXPR(not, "!a && b", "(Binop && (Unop ! (Id a)) (Id b))")
EXPR(deref_deref, "**pp", "(Unop * (Unop * (Id pp)))")
EXPR(not_not, "!!a", "(Unop ! (Unop ! (Id a)))")
EXPR(mul_vs_deref, "a * *b", "(Binop * (Id a) (Unop * (Id b)))")


EXPR(call_no_args, "f()", "(Call f)")
EXPR(call_args, "f(1, x + 2)", "(Call f (Num 1) (Binop + (Id x) (Num 2)))")
EXPR(call_nested, "f(g(1))", "(Call f (Call g (Num 1)))")
EXPR(call_in_expr, "f(1) + g()", "(Binop + (Call f (Num 1)) (Call g))")

EXPR(cast_char, "(char)x", "(Cast char (Id x))")
EXPR(cast_pointer, "(char *)p + 1", "(Binop + (Cast char* (Id p)) (Num 1))")
EXPR(cast_double_pointer, "(int **)p", "(Cast int** (Id p))")
EXPR(store_through_cast, "*(int *)(p + 8) = 5",
     "(Binop = (Unop * (Cast int* (Binop + (Id p) (Num 8)))) (Num 5))")
EXPR(cast_of_deref, "(int)*p", "(Cast int (Unop * (Id p)))")
EXPR(cast_in_call, "f((char)c)", "(Call f (Cast char (Id c)))")

Test(parser_expr, positions) {
    error_quiet(1);
    void *p = parse("void f() {\n  a + b * c;\n}");
    void *stmt = node_a(node_b(node_a(p)));
    void *plus = node_a(stmt);
    cr_assert_eq(node_kind(plus), N_BINOP);
    cr_assert_eq(node_line(plus), 2);
    cr_assert_eq(node_col(plus), 5);
    void *times = node_b(plus);
    cr_assert_eq(node_col(times), 9);
    cr_assert_eq(node_col(node_a(plus)), 3);
}
