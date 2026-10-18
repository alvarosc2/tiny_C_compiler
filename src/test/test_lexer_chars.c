#include <criterion/criterion.h>
#include "../main/lexer.h"

static void expect_char(char *s, int value) {
    lexer_init(s);
    void *t = next_token();
    cr_assert_eq(token_kind(t), T_CHRLIT);
    cr_assert_eq(token_value(t), value);
    cr_assert_eq(token_kind(next_token()), T_EOF);
}

Test(lexer_chars, letter) { expect_char("'a'", 'a'); }
Test(lexer_chars, digit) { expect_char("'0'", '0'); }
Test(lexer_chars, underscore) { expect_char("'_'", '_'); }
Test(lexer_chars, space) { expect_char("' '", ' '); }
Test(lexer_chars, double_quote) { expect_char("'\"'", '"'); }
Test(lexer_chars, escape_newline) { expect_char("'\\n'", '\n'); }
Test(lexer_chars, escape_return) { expect_char("'\\r'", '\r'); }
Test(lexer_chars, escape_tab) { expect_char("'\\t'", '\t'); }
Test(lexer_chars, escape_nul) { expect_char("'\\0'", 0); }
Test(lexer_chars, escape_quote) { expect_char("'\\''", '\''); }
Test(lexer_chars, escape_backslash) { expect_char("'\\\\'", '\\'); }

Test(lexer_chars, in_expression) {
    lexer_init("c == 'x'");
    cr_assert_eq(token_kind(next_token()), T_ID);
    cr_assert_eq(token_kind(next_token()), T_EQ);
    void *t = next_token();
    cr_assert_eq(token_kind(t), T_CHRLIT);
    cr_assert_eq(token_value(t), 'x');
}

Test(lexer_chars, consecutive) {
    lexer_init("'a''b'");
    cr_assert_eq(token_value(next_token()), 'a');
    cr_assert_eq(token_value(next_token()), 'b');
    cr_assert_eq(token_kind(next_token()), T_EOF);
}
