#include "sema_helpers.h"

static void e(char *stmt, char *msg) {
    cr_assert_eq(check_stmt(stmt), 1, "stmt: %s\n%s", stmt, error_log());
    char want[512];
    snprintf(want, sizeof(want), "<entrada>:2:%s\n", msg);
    cr_assert_str_eq(error_log(), want, "stmt: %s", stmt);
}

Test(sema_err, undeclared_identifier) {
    e("x = 1;", "12: error: identificador 'x' no declarado");
}

Test(sema_err, undeclared_function) {
    e("g();", "12: error: funcion 'g' no declarada");
}

Test(sema_err, call_non_function) {
    e("i();", "12: error: 'i' no es una funcion");
}

Test(sema_err, function_as_value) {
    e("i = fi;", "16: error: 'fi' es una funcion, no una variable");
}

Test(sema_err, arg_count) {
    e("fi();", "12: error: la funcion 'fi' espera 1 argumento y recibe 0 argumentos");
    e("fi(1, 2);", "12: error: la funcion 'fi' espera 1 argumento y recibe 2 argumentos");
}

Test(sema_err, arg_type) {
    e("fi(s);", "15: error: argumento 1 de 'fi': no se puede convertir 'char*' a 'int'");
}

Test(sema_err, assign_types) {
    e("i = s;", "14: error: no se puede asignar 'char*' a 'int'");
    e("s = 5;", "14: error: no se puede asignar 'int' a 'char*'");
    e("ip = s;", "15: error: no se puede asignar 'char*' a 'int*'");
}

Test(sema_err, bad_operands) {
    e("s + s;", "14: error: operandos invalidos para '+': 'char*' y 'char*'");
    e("vp + 1;", "15: error: aritmetica sobre 'void*' no permitida");
    e("s * 2;", "14: error: operandos invalidos para '*': 'char*' y 'int'");
}

Test(sema_err, deref_errors) {
    e("*i;", "12: error: no se puede desreferenciar 'int'");
    e("*vp;", "12: error: no se puede desreferenciar 'void*'");
}

Test(sema_err, division_by_zero) {
    e("i / 0;", "16: error: division entre cero");
}

Test(sema_err, condition_not_scalar) {
    e("if (fv()) {}", "16: error: la condicion debe ser escalar, no 'void'");
    e("while (fv()) {}", "19: error: la condicion debe ser escalar, no 'void'");
}

Test(sema_err, no_cascade) {
    /* x no declarado: no debe haber un segundo error por el '+' */
    cr_assert_eq(check_stmt("i = x + 1;"), 1);
}

Test(sema_err, several_errors) {
    cr_assert_eq(check_stmt("x = 1; y = 2;"), 2);
}
