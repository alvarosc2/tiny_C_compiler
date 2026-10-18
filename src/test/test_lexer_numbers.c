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

Test(lexer_numbers, int_max) { expect_num("2147483647", 2147483647); }

static void expect_too_big(char *s) {
    lexer_init(s);
    void *t = next_token();
    cr_assert_eq(token_kind(t), T_ERROR);
    cr_assert_str_eq(token_text(t), "numero demasiado grande");
    cr_assert_eq(token_col(t), 1);
    cr_assert_eq(token_kind(next_token()), T_EOF);
}

Test(lexer_numbers, int_max_plus_one) { expect_too_big("2147483648"); }
Test(lexer_numbers, huge) { expect_too_big("99999999999999999999"); }
Test(lexer_numbers, overflow_wrap_candidate) { expect_too_big("4294967297"); }

Test(lexer_numbers, leading_zeros_ok) { expect_num("0000000000042", 42); }

Test(lexer_numbers, recovers_after_overflow) {
    lexer_init("99999999999 7");
    cr_assert_eq(token_kind(next_token()), T_ERROR);
    void *t = next_token();
    cr_assert_eq(token_kind(t), T_NUM);
    cr_assert_eq(token_value(t), 7);
}
