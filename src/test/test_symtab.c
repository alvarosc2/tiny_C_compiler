#include <criterion/criterion.h>
#include "../main/symtab.h"

Test(symtab, declare_and_lookup) {
    st_reset();
    void *s = sym_declare("x", 5, SYM_VAR, 0);
    cr_assert_eq(sym_lookup("x"), s);
    cr_assert_eq(sym_type(s), 5);
    cr_assert_eq(sym_kind(s), SYM_VAR);
    cr_assert_null(sym_lookup("y"));
}

Test(symtab, inner_scope_shadows_and_pops) {
    st_reset();
    void *outer = sym_declare("x", 1, SYM_VAR, 0);
    st_push();
    void *inner = sym_declare("x", 2, SYM_VAR, 0);
    cr_assert_eq(sym_lookup("x"), inner);
    cr_assert_eq(sym_lookup_local("x"), inner);
    cr_assert_eq(st_depth_now(), 1);
    st_pop();
    cr_assert_eq(sym_lookup("x"), outer);
    cr_assert_eq(st_depth_now(), 0);
}

Test(symtab, local_lookup_ignores_outer) {
    st_reset();
    sym_declare("g", 1, SYM_VAR, 0);
    st_push();
    cr_assert_null(sym_lookup_local("g"));
    cr_assert_not_null(sym_lookup("g"));
    st_pop();
}

Test(symtab, defined_flag) {
    st_reset();
    void *f = sym_declare("f", 1, SYM_FUNC, 0);
    cr_assert_eq(sym_defined(f), 0);
    sym_set_defined(f, 1);
    cr_assert_eq(sym_defined(f), 1);
}
