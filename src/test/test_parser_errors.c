#include "parser_helpers.h"

/* Analiza en silencio y deja el registro de errores en error_log() */
static inline int errors_of(char *src) {
    error_quiet(1);
    parse(src);
    return parse_error_count();
}

Test(parser_err, missing_expression) {
    cr_assert_eq(errors_of("int x = ;"), 1);
    cr_assert_str_eq(error_log(),
        "<entrada>:1:9: error: se esperaba una expresion y se encontro ';'\n");
}

Test(parser_err, missing_semicolon_recovers_at_next_type) {
    cr_assert_eq(errors_of("int x = 1\nint y;"), 1);
    cr_assert_str_eq(error_log(),
        "<entrada>:2:1: error: se esperaba ';' y se encontro 'int'\n");
    cr_assert_str_eq(sexpr("int x = 1\nint y;"), "(Program (Decl int y))");
}

Test(parser_err, reports_several_errors) {
    cr_assert_eq(errors_of("void f(void) {\n  int a = ;\n  int b = ;\n}\n"), 2);
    cr_assert_str_eq(error_log(),
        "<entrada>:2:11: error: se esperaba una expresion y se encontro ';'\n"
        "<entrada>:3:11: error: se esperaba una expresion y se encontro ';'\n");
}

Test(parser_err, keeps_parsing_after_bad_function) {
    char *src = "void f(void) { int a = ; }\nint g() { return 1; }";
    cr_assert_eq(errors_of(src), 1);
    cr_assert_not_null(strstr(sexpr(src), "(Func int g (Block (Return (Num 1))))"));
}

Test(parser_err, unclosed_block) {
    cr_assert_eq(errors_of("void f(void) {"), 1);
    cr_assert_str_eq(error_log(),
        "<entrada>:1:15: error: se esperaba '}' y se encontro fin de archivo\n");
}

Test(parser_err, lexer_error_is_reported_once) {
    cr_assert_eq(errors_of("char *s = \"abc;"), 1);
    cr_assert_str_eq(error_log(), "<entrada>:1:11: error: cadena sin cerrar\n");
}

Test(parser_err, number_too_large) {
    cr_assert_eq(errors_of("int x = 99999999999;"), 1);
    cr_assert_str_eq(error_log(), "<entrada>:1:9: error: numero demasiado grande\n");
}

Test(parser_err, not_assignable) {
    cr_assert_eq(errors_of("void f(void) { 1 = 2; }"), 1);
    cr_assert_str_eq(error_log(),
        "<entrada>:1:18: error: el lado izquierdo de '=' no es asignable\n");
}

Test(parser_err, binary_result_not_assignable) {
    cr_assert_eq(errors_of("void f(void) { a + b = 2; }"), 1);
}

Test(parser_err, stray_token_at_top_level) {
    cr_assert_eq(errors_of("x = 1;\nint y;"), 1);
    cr_assert_str_eq(error_log(),
        "<entrada>:1:1: error: se esperaba una declaracion o funcion "
        "y se encontro identificador 'x'\n");
    cr_assert_str_eq(sexpr("x = 1;\nint y;"), "(Program (Decl int y))");
}

Test(parser_err, unmatched_close_brace) {
    cr_assert_eq(errors_of("}"), 1);
    cr_assert_str_eq(error_log(),
        "<entrada>:1:1: error: se esperaba una declaracion o funcion y se encontro '}'\n");
}

Test(parser_err, bad_parameter_list_still_parses_body) {
    char *src = "int f( { return 1; }";
    cr_assert_eq(errors_of(src), 1);
    cr_assert_str_eq(error_log(), "<entrada>:1:8: error: se esperaba un tipo y se encontro '{'\n");
    cr_assert_not_null(strstr(sexpr(src), "(Block (Return (Num 1)))"));
}

Test(parser_err, parameter_without_name) {
    cr_assert_eq(errors_of("int f(int) {}"), 1);
    cr_assert_str_eq(error_log(),
        "<entrada>:1:10: error: se esperaba un identificador y se encontro ')'\n");
}

Test(parser_err, missing_close_paren_in_if) {
    cr_assert_eq(errors_of("void f(void) { if (a b; }"), 1);
    cr_assert_str_eq(error_log(),
        "<entrada>:1:22: error: se esperaba ')' y se encontro identificador 'b'\n");
}

Test(parser_err, missing_close_paren_in_call) {
    cr_assert_eq(errors_of("void f(void) { g(1; }"), 1);
    cr_assert_str_eq(error_log(), "<entrada>:1:19: error: se esperaba ')' y se encontro ';'\n");
}

Test(parser_err, unknown_character) {
    cr_assert_eq(errors_of("void f(void) { a @ b; }"), 1);
    cr_assert_str_eq(error_log(), "<entrada>:1:18: error: se esperaba ';' y se encontro '@'\n");
}

Test(parser_err, else_without_if) {
    cr_assert_eq(errors_of("void f(void) { else; }"), 1);
    cr_assert_str_eq(error_log(),
        "<entrada>:1:16: error: se esperaba una expresion y se encontro 'else'\n");
}

Test(parser_err, missing_function_body) {
    cr_assert_eq(errors_of("int f(void) int x;"), 1);
    cr_assert_str_eq(error_log(),
        "<entrada>:1:13: error: se esperaba '{' o ';' y se encontro 'int'\n");
}

Test(parser_err, errors_in_nested_blocks) {
    char *src = "void f(void) {\n  while (a) {\n    b = ;\n  }\n  c = ;\n}";
    cr_assert_eq(errors_of(src), 2);
}

Test(parser_err, statement_after_error_is_kept) {
    char *src = "void f(void) { a = ; return 1; }";
    cr_assert_eq(errors_of(src), 1);
    cr_assert_str_eq(sexpr(src), "(Program (Func void f (Block (Return (Num 1)))))");
}

Test(parser_err, stops_after_twenty_errors) {
    char src[1024] = "";
    for (int i = 0; i < 25; i++) strcat(src, "int x = ;\n");
    cr_assert_eq(errors_of(src), 20);
    char *log = error_log();
    cr_assert_not_null(strstr(log, "demasiados errores\n"));
    cr_assert_eq(strstr(log, "demasiados errores\n") + strlen("demasiados errores\n"),
                 log + strlen(log));
}

Test(parser_err, error_log_resets_between_parses) {
    errors_of("int x = ;");
    cr_assert_eq(errors_of("int x;"), 0);
    cr_assert_str_eq(error_log(), "");
}

Test(parser_err, source_name_in_message) {
    error_quiet(1);
    set_source_name("prueba.c");
    parse("int x = ;");
    cr_assert_str_eq(error_log(),
        "prueba.c:1:9: error: se esperaba una expresion y se encontro ';'\n");
}
