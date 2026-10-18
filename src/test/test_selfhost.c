#include <criterion/criterion.h>
#include <stdlib.h>

/* tcc0 (gcc) -> tcc1 (sin libc) -> tcc2: el ensamblador de ambas etapas debe coincidir */
Test(selfhost, fixed_point_and_behavior) {
    cr_assert_eq(system("rm -rf /tmp/tcc_self && "
                        "scripts/selfhost.sh build/tcc /tmp/tcc_self/s1 && "
                        "scripts/selfhost.sh /tmp/tcc_self/s1/tcc /tmp/tcc_self/s2"), 0);
    cr_assert_eq(system("for f in /tmp/tcc_self/s1/*.s; do "
                        "cmp $f /tmp/tcc_self/s2/$(basename $f) || exit 1; done"), 0);
    cr_assert_neq(system("ldd /tmp/tcc_self/s2/tcc >/dev/null 2>&1"), 0);
    cr_assert_eq(system("printf 'int main(void) { return x; }' > /tmp/tcc_self/e.c && "
                        "/tmp/tcc_self/s2/tcc /tmp/tcc_self/e.c 2>/dev/null"), 256);
    cr_assert_eq(system("/tmp/tcc_self/s2/tcc 2>/dev/null"), 512);
    system("rm -rf /tmp/tcc_self");
}
