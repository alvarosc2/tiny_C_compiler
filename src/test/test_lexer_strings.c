#include <criterion/criterion.h>
#include <string.h>
#include "../main/lexer.h"
#include "../main/tokens.h"

static char *text_of(char *src) {
    lexer_init(src);
    void *t = next_token();
    cr_assert_eq(token_kind(t), T_STR);
    return token_text(t);
}

Test(lexer_strings, escapes_are_decoded) {
    cr_assert_str_eq(text_of("\"a\\nb\""), "a\nb");
    cr_assert_str_eq(text_of("\"\\t\\r\""), "\t\r");
    cr_assert_str_eq(text_of("\"q\\\"q\""), "q\"q");
    cr_assert_str_eq(text_of("\"\\\\\""), "\\");
}

Test(lexer_strings, escaped_quote_does_not_close) {
    lexer_init("\"a\\\"b\" 7");
    cr_assert_eq(token_kind(next_token()), T_STR);
    cr_assert_eq(token_kind(next_token()), T_NUM);
}

Test(lexer_strings, trailing_backslash_is_unterminated) {
    lexer_init("\"abc\\");
    cr_assert_eq(token_kind(next_token()), T_ERROR);
}
