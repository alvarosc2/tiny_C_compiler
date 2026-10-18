#include <criterion/criterion.h>
#include "../main/lexer.h"

Test(lexer_columns, first_token_is_column_one) {
    lexer_init("x");
    cr_assert_eq(token_col(next_token()), 1);
}

Test(lexer_columns, tokens_on_same_line) {
    lexer_init("int x = 5;");
    int expected[] = {1, 5, 7, 9, 10, 11};
    for (unsigned i = 0; i < sizeof(expected) / sizeof(expected[0]); i++)
        cr_assert_eq(token_col(next_token()), expected[i], "token %u", i);
}

Test(lexer_columns, leading_spaces) {
    lexer_init("   \tx");
    cr_assert_eq(token_col(next_token()), 5);
}

Test(lexer_columns, resets_after_newline) {
    lexer_init("abc\n  d");
    next_token();
    void *t = next_token();
    cr_assert_eq(token_line(t), 2);
    cr_assert_eq(token_col(t), 3);
}

Test(lexer_columns, two_char_operator_is_one_token) {
    lexer_init("a<=b");
    cr_assert_eq(token_col(next_token()), 1);
    cr_assert_eq(token_col(next_token()), 2);
    cr_assert_eq(token_col(next_token()), 4);
}

Test(lexer_columns, string_and_char_literals) {
    lexer_init("\"ab\" 'c' d");
    cr_assert_eq(token_col(next_token()), 1);
    cr_assert_eq(token_col(next_token()), 6);
    cr_assert_eq(token_col(next_token()), 10);
}

Test(lexer_columns, crlf) {
    lexer_init("a\r\n b");
    next_token();
    cr_assert_eq(token_col(next_token()), 2);
}

Test(lexer_columns, reinit_resets) {
    lexer_init("abc def");
    next_token();
    next_token();
    lexer_init("x");
    cr_assert_eq(token_col(next_token()), 1);
}
