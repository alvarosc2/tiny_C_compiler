#include <criterion/criterion.h>
#include "../main/lexer.h"

static void expect_error(char *s, char *msg, int line, int col) {
    lexer_init(s);
    void *t = next_token();
    cr_assert_eq(token_kind(t), T_ERROR);
    cr_assert_str_eq(token_text(t), msg);
    cr_assert_eq(token_line(t), line);
    cr_assert_eq(token_col(t), col);
    cr_assert_eq(token_kind(next_token()), T_EOF);
}

Test(lexer_errors, unterminated_string) { expect_error("\"abc", "cadena sin cerrar", 1, 1); }
Test(lexer_errors, lone_quote) { expect_error("\"", "cadena sin cerrar", 1, 1); }
Test(lexer_errors, unterminated_string_position) {
    lexer_init("x\n  \"abc");
    next_token();
    void *t = next_token();
    cr_assert_eq(token_kind(t), T_ERROR);
    cr_assert_eq(token_line(t), 2);
    cr_assert_eq(token_col(t), 3);
}
Test(lexer_errors, unterminated_char) { expect_error("'a", "caracter sin cerrar", 1, 1); }
Test(lexer_errors, lone_apostrophe) { expect_error("'", "caracter sin cerrar", 1, 1); }
Test(lexer_errors, char_escape_at_eof) { expect_error("'\\", "caracter sin cerrar", 1, 1); }

Test(lexer_errors, eof_is_sticky) {
    lexer_init("a");
    next_token();
    for (int i = 0; i < 3; i++) {
        cr_assert_eq(token_kind(next_token()), T_EOF);
    }
}

Test(lexer_errors, valid_literals_still_ok) {
    lexer_init("\"ok\" 'x'");
    cr_assert_eq(token_kind(next_token()), T_STR);
    cr_assert_eq(token_kind(next_token()), T_CHRLIT);
}

Test(lexer_errors, recovers_after_reinit) {
    lexer_init("\"abc");
    next_token();
    lexer_init("\"abc\"");
    cr_assert_eq(token_kind(next_token()), T_STR);
}
