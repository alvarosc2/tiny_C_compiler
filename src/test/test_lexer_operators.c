#include <criterion/criterion.h>
#include "../main/lexer.h"

struct op { char *text; int kind; };

Test(lexer_operators, single_and_double) {
    static struct op cases[] = {
        {"+", '+'}, {"-", '-'}, {"*", '*'}, {"/", '/'}, {"%", '%'},
        {"=", '='}, {"!", '!'}, {"<", '<'}, {">", '>'},
        {"(", '('}, {")", ')'}, {"{", '{'}, {"}", '}'}, {",", ','}, {";", ';'},
        {"==", T_EQ}, {"!=", T_NE}, {"<=", T_LE}, {">=", T_GE},
        {"&&", T_AND}, {"||", T_OR}, {"++", T_INC}, {"--", T_DEC},
        {"[", '['}, {"]", ']'},
    };
    for (unsigned i = 0; i < sizeof(cases) / sizeof(cases[0]); i++) {
        struct op *p = &cases[i];
    lexer_init(p->text);
    cr_assert_eq(token_kind(next_token()), p->kind, "%s", p->text);
    cr_assert_eq(token_kind(next_token()), T_EOF);
    }
}

Test(lexer_operators, assign_vs_equal) {
    lexer_init("a = b == c");
    cr_assert_eq(token_kind(next_token()), T_ID);
    cr_assert_eq(token_kind(next_token()), '=');
    cr_assert_eq(token_kind(next_token()), T_ID);
    cr_assert_eq(token_kind(next_token()), T_EQ);
    cr_assert_eq(token_kind(next_token()), T_ID);
}

Test(lexer_operators, no_spaces) {
    lexer_init("a<=b&&c!=d");
    int expected[] = {T_ID, T_LE, T_ID, T_AND, T_ID, T_NE, T_ID, T_EOF};
    for (unsigned i = 0; i < sizeof(expected) / sizeof(expected[0]); i++)
        cr_assert_eq(token_kind(next_token()), expected[i], "token %u", i);
}

Test(lexer_operators, lone_less_then_assign) {
    lexer_init("< =");
    cr_assert_eq(token_kind(next_token()), '<');
    cr_assert_eq(token_kind(next_token()), '=');
}

Test(lexer_operators, expression) {
    lexer_init("*p = -x + 1;");
    int expected[] = {'*', T_ID, '=', '-', T_ID, '+', T_NUM, ';', T_EOF};
    for (unsigned i = 0; i < sizeof(expected) / sizeof(expected[0]); i++)
        cr_assert_eq(token_kind(next_token()), expected[i], "token %u", i);
}

Test(lexer_operators, increment_vs_plus) {
    lexer_init("a++ + b+++c");
    int expected[] = {T_ID, T_INC, '+', T_ID, T_INC, '+', T_ID, T_EOF};
    for (unsigned i = 0; i < sizeof(expected) / sizeof(expected[0]); i++)
        cr_assert_eq(token_kind(next_token()), expected[i], "token %u", i);
}

Test(lexer_operators, decrement_and_minus) {
    lexer_init("a-- - -b");
    int expected[] = {T_ID, T_DEC, '-', '-', T_ID, T_EOF};
    for (unsigned i = 0; i < sizeof(expected) / sizeof(expected[0]); i++)
        cr_assert_eq(token_kind(next_token()), expected[i], "token %u", i);
}

Test(lexer_operators, indexing) {
    lexer_init("src[pos++]");
    int expected[] = {T_ID, '[', T_ID, T_INC, ']', T_EOF};
    for (unsigned i = 0; i < sizeof(expected) / sizeof(expected[0]); i++)
        cr_assert_eq(token_kind(next_token()), expected[i], "token %u", i);
}
