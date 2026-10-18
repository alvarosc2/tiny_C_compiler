#include <criterion/criterion.h>
#include "../main/lexer.h"

static void expect_id(char *s, char *name) {
    lexer_init(s);
    void *t = next_token();
    cr_assert_eq(token_kind(t), T_ID);
    cr_assert_str_eq(token_text(t), name);
    cr_assert_eq(token_kind(next_token()), T_EOF);
}

Test(lexer_identifiers, simple) { expect_id("foo", "foo"); }
Test(lexer_identifiers, leading_underscore) { expect_id("_x", "_x"); }
Test(lexer_identifiers, with_digits) { expect_id("var123", "var123"); }
Test(lexer_identifiers, mixed_case_and_underscores) { expect_id("My_Var_2", "My_Var_2"); }
Test(lexer_identifiers, single_letter) { expect_id("a", "a"); }
Test(lexer_identifiers, keyword_prefix_is_identifier) { expect_id("integer", "integer"); }
Test(lexer_identifiers, keyword_suffix_is_identifier) { expect_id("my_int", "my_int"); }

Test(lexer_identifiers, stops_at_non_identifier_char) {
    lexer_init("abc(");
    void *t = next_token();
    cr_assert_str_eq(token_text(t), "abc");
    cr_assert_eq(token_kind(next_token()), '(');
}

Test(lexer_identifiers, sequence) {
    lexer_init("a b_c _d");
    cr_assert_str_eq(token_text(next_token()), "a");
    cr_assert_str_eq(token_text(next_token()), "b_c");
    cr_assert_str_eq(token_text(next_token()), "_d");
    cr_assert_eq(token_kind(next_token()), T_EOF);
}

Test(lexer_identifiers, string_literal) {
    lexer_init("\"hola mundo\"");
    void *t = next_token();
    cr_assert_eq(token_kind(t), T_STR);
    cr_assert_str_eq(token_text(t), "hola mundo");
}

Test(lexer_identifiers, empty_string_literal) {
    lexer_init("\"\"");
    void *t = next_token();
    cr_assert_eq(token_kind(t), T_STR);
    cr_assert_str_eq(token_text(t), "");
}

Test(lexer_identifiers, empty_input_is_eof) {
    lexer_init("   \n\t ");
    cr_assert_eq(token_kind(next_token()), T_EOF);
}
