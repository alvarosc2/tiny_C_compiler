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
EXPR(div_mod_left_assoc, "a % b / c", "(Binop / (Binop % (Id a) (Id b)) (Id c))")
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

EXPR(assignment, "a = 1", "(Binop = (Id a) (Num 1))")
EXPR(assignment_right_assoc, "a = b = c", "(Binop = (Id a) (Binop = (Id b) (Id c)))")
EXPR(assignment_lowest, "a = b || c", "(Binop = (Id a) (Binop || (Id b) (Id c)))")
EXPR(assign_deref, "*p = 1", "(Binop = (Unop * (Id p)) (Num 1))")
EXPR(assign_index, "a[i + 1] = 2",
     "(Binop = (Index (Id a) (Binop + (Id i) (Num 1))) (Num 2))")

EXPR(unary_minus_binds_tighter, "-a * b", "(Binop * (Unop - (Id a)) (Id b))")
EXPR(not, "!a && b", "(Binop && (Unop ! (Id a)) (Id b))")
EXPR(double_unary, "- - x", "(Unop - (Unop - (Id x)))")
EXPR(unary_plus, "+x", "(Unop + (Id x))")
EXPR(deref_postfix_inc, "*p++", "(Unop * (Postfix ++ (Id p)))")
EXPR(deref_deref, "**pp", "(Unop * (Unop * (Id pp)))")
EXPR(mul_vs_deref, "a * *b", "(Binop * (Id a) (Unop * (Id b)))")

EXPR(index, "a[i]", "(Index (Id a) (Id i))")
EXPR(index_twice, "a[i][j]", "(Index (Index (Id a) (Id i)) (Id j))")
EXPR(post_inc, "i++", "(Postfix ++ (Id i))")
EXPR(post_dec, "i--", "(Postfix -- (Id i))")
EXPR(index_then_inc, "a[0]++", "(Postfix ++ (Index (Id a) (Num 0)))")
EXPR(paren_then_index, "(a)[1]", "(Index (Id a) (Num 1))")
EXPR(paren_then_inc, "(a)++", "(Postfix ++ (Id a))")

EXPR(call_no_args, "f()", "(Call f)")
EXPR(call_args, "f(1, x + 2)", "(Call f (Num 1) (Binop + (Id x) (Num 2)))")
EXPR(call_nested, "f(g(1))", "(Call f (Call g (Num 1)))")
EXPR(call_assign_arg, "f(a = 1, b)", "(Call f (Binop = (Id a) (Num 1)) (Id b))")
EXPR(call_then_index, "f(1)[2]", "(Index (Call f (Num 1)) (Num 2))")
EXPR(call_in_expr, "f(1) + g()", "(Binop + (Call f (Num 1)) (Call g))")

EXPR(cast_char, "(char)x", "(Cast char (Id x))")
EXPR(cast_pointer, "(char *)p + 1", "(Binop + (Cast char* (Id p)) (Num 1))")
EXPR(cast_double_pointer, "(int **)p", "(Cast int** (Id p))")
EXPR(cast_binds_unary, "(int)x[1]", "(Cast int (Index (Id x) (Num 1)))")
EXPR(store_through_cast, "*(int *)(p + 8) = 5",
     "(Binop = (Unop * (Cast int* (Binop + (Id p) (Num 8)))) (Num 5))")
EXPR(cast_in_call, "f((char)c)", "(Call f (Cast char (Id c)))")

Test(parser_expr, positions) {
    error_quiet(1);
    void *p = parse("void f(void) {\n  a + b * c;\n}");
    void *stmt = node_a(node_b(node_a(p)));
    void *plus = node_a(stmt);
    cr_assert_eq(node_kind(plus), N_BINOP);
    cr_assert_eq(node_line(plus), 2);
    cr_assert_eq(node_col(plus), 5);
    void *times = node_b(plus);
    cr_assert_eq(node_col(times), 9);
    cr_assert_eq(node_col(node_a(plus)), 3);
}
