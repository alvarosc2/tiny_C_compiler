#include <criterion/criterion.h>
#include "../main/lexer.h"

struct kw { char *text; int kind; };

Test(lexer_keywords, all_keywords) {
    static struct kw cases[] = {
        {"int", T_INT}, {"char", T_CHAR}, {"void", T_VOID},
        {"return", T_RETURN}, {"if", T_IF}, {"else", T_ELSE},
        {"while", T_WHILE},
    };
    for (unsigned i = 0; i < sizeof(cases) / sizeof(cases[0]); i++) {
        struct kw *p = &cases[i];
    lexer_init(p->text);
    void *t = next_token();
    cr_assert_eq(token_kind(t), p->kind, "%s", p->text);
    cr_assert_str_eq(token_text(t), p->text);
    cr_assert_eq(token_kind(next_token()), T_EOF);
    }
}

Test(lexer_keywords, case_sensitive) {
    lexer_init("Int WHILE");
    cr_assert_eq(token_kind(next_token()), T_ID);
    cr_assert_eq(token_kind(next_token()), T_ID);
}

Test(lexer_keywords, function_header) {
    lexer_init("int main(void)");
    cr_assert_eq(token_kind(next_token()), T_INT);
    cr_assert_eq(token_kind(next_token()), T_ID);
    cr_assert_eq(token_kind(next_token()), '(');
    cr_assert_eq(token_kind(next_token()), T_VOID);
    cr_assert_eq(token_kind(next_token()), ')');
    cr_assert_eq(token_kind(next_token()), T_EOF);
}

Test(lexer_keywords, pointer_type) {
    lexer_init("char *s;");
    cr_assert_eq(token_kind(next_token()), T_CHAR);
    cr_assert_eq(token_kind(next_token()), '*');
    cr_assert_eq(token_kind(next_token()), T_ID);
    cr_assert_eq(token_kind(next_token()), ';');
}

Test(lexer_keywords, if_else_while_statement) {
    lexer_init("if (x) return; else while (y) {}");
    int expected[] = {T_IF, '(', T_ID, ')', T_RETURN, ';', T_ELSE, T_WHILE,
                      '(', T_ID, ')', '{', '}', T_EOF};
    for (unsigned i = 0; i < sizeof(expected) / sizeof(expected[0]); i++)
        cr_assert_eq(token_kind(next_token()), expected[i], "token %u", i);
}
