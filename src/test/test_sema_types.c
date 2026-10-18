#include "sema_helpers.h"

static void t(char *expr, char *want) {
    cr_assert_str_eq(type_of(expr), want, "expr: %s", expr);
}

Test(sema_types, literals) {
    t("1", "int");
    t("'a'", "int");
    t("\"hi\"", "char*");
}

Test(sema_types, variables) {
    t("i", "int");
    t("c", "char");
    t("s", "char*");
    t("pp", "int**");
}

Test(sema_types, arithmetic) {
    t("i + c", "int");
    t("c * 2", "int");
    t("-c", "int");
    t("!s", "int");
}

Test(sema_types, pointer_arithmetic) {
    t("s + 1", "char*");
    t("1 + ip", "int*");
    t("ip - 1", "int*");
    t("ip - ip", "int");
    t("ip++", "int*");
}

Test(sema_types, deref_index_cast) {
    t("*ip", "int");
    t("*pp", "int*");
    t("s[i]", "char");
    t("pp[0][1]", "int");
    t("(char *)vp", "char*");
    t("(int)c", "int");
}

Test(sema_types, calls) {
    t("fi(1)", "int");
    t("fv()", "void");
    t("fs(s, 1)", "char*");
    t("fs(0, 1)", "char*");
    t("fs(vp, 1)", "char*");
}

Test(sema_types, comparison_and_logic) {
    t("i < c", "int");
    t("s == 0", "int");
    t("ip == vp", "int");
    t("i && s", "int");
}

Test(sema_types, assignment) {
    t("i = c", "int");
    t("c = i", "char");
    t("s = 0", "char*");
    t("vp = ip", "void*");
    t("ip = vp", "int*");
}

Test(sema_types, names) {
    cr_assert_str_eq(type_name(T_INT), "int");
    cr_assert_str_eq(type_name(T_VOID + 2 * TYPE_PTR_UNIT), "void**");
    cr_assert_str_eq(type_name(TY_ERR), "<error>");
}
