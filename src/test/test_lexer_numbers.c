#include <criterion/criterion.h>
#include "../main/lexer.h"

static void expect_num(char *s, int value) {
    lexer_init(s);
    void *t = next_token();
    cr_assert_eq(token_kind(t), T_NUM);
    cr_assert_eq(token_value(t), value);
    cr_assert_eq(token_kind(next_token()), T_EOF);
}

Test(lexer_numbers, single_digit) { expect_num("7", 7); }
Test(lexer_numbers, zero) { expect_num("0", 0); }
Test(lexer_numbers, multi_digit) { expect_num("12345", 12345); }
Test(lexer_numbers, surrounded_by_spaces) { expect_num("  \t42\n", 42); }

Test(lexer_numbers, number_sequence) {
    lexer_init("1 22 333");
    cr_assert_eq(token_value(next_token()), 1);
    cr_assert_eq(token_value(next_token()), 22);
    cr_assert_eq(token_value(next_token()), 333);
    cr_assert_eq(token_kind(next_token()), T_EOF);
}

Test(lexer_numbers, number_followed_by_operator) {
    lexer_init("5+3");
    cr_assert_eq(token_value(next_token()), 5);
    cr_assert_eq(token_kind(next_token()), '+');
    cr_assert_eq(token_value(next_token()), 3);
}

Test(lexer_numbers, read_number_direct) {
    lexer_init("987;");
    cr_assert_eq(read_number(), 987);
    cr_assert_eq(next_char(), ';');
}
