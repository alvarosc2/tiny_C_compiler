#include <criterion/criterion.h>
#include "../main/lexer.h"

Test(lexer_lines, first_token_is_line_one) {
    lexer_init("x");
    cr_assert_eq(token_line(next_token()), 1);
}

Test(lexer_lines, newlines_increment) {
    lexer_init("a\nb\n\nc");
    cr_assert_eq(token_line(next_token()), 1);
    cr_assert_eq(token_line(next_token()), 2);
    cr_assert_eq(token_line(next_token()), 4);
}

Test(lexer_lines, same_line_tokens) {
    lexer_init("a + b\nc");
    cr_assert_eq(token_line(next_token()), 1);
    cr_assert_eq(token_line(next_token()), 1);
    cr_assert_eq(token_line(next_token()), 1);
    cr_assert_eq(token_line(next_token()), 2);
}

Test(lexer_lines, crlf) {
    lexer_init("a\r\nb");
    next_token();
    cr_assert_eq(token_line(next_token()), 2);
}

Test(lexer_lines, eof_line) {
    lexer_init("a\n\n");
    next_token();
    void *t = next_token();
    cr_assert_eq(token_kind(t), T_EOF);
    cr_assert_eq(token_line(t), 3);
}

Test(lexer_lines, multiline_string_reports_start_line) {
    lexer_init("\"a\nb\" x");
    cr_assert_eq(token_line(next_token()), 1);
    cr_assert_eq(token_line(next_token()), 2);
}

Test(lexer_lines, reinit_resets) {
    lexer_init("a\nb");
    next_token();
    next_token();
    lexer_init("c");
    cr_assert_eq(token_line(next_token()), 1);
}
