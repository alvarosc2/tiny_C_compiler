#include <criterion/criterion.h>
#include <stdlib.h>

/* make install en un DESTDIR temporal, compilar con el driver instalado y desinstalar */
Test(install, installed_driver_builds_and_runs) {
    cr_assert_eq(system("rm -rf /tmp/tcc_inst && "
                        "make -s install PREFIX=/opt/t DESTDIR=/tmp/tcc_inst >/dev/null"), 0);
    cr_assert_eq(system("/tmp/tcc_inst/opt/t/bin/tinyc examples/hello.c -o /tmp/tcc_inst/hello && "
                        "/tmp/tcc_inst/hello | grep -q '10! = 3628800'"), 0);
    cr_assert_eq(system("/tmp/tcc_inst/opt/t/bin/tinyc -S examples/hello.c -o /tmp/tcc_inst/h.s && "
                        "grep -q 'x86-64' /tmp/tcc_inst/h.s"), 0);
    cr_assert_neq(system("/tmp/tcc_inst/opt/t/bin/tinyc 2>/dev/null"), 0);
    cr_assert_eq(system("make -s uninstall PREFIX=/opt/t DESTDIR=/tmp/tcc_inst && "
                        "test ! -e /tmp/tcc_inst/opt/t/bin/tinyc"), 0);
    system("rm -rf /tmp/tcc_inst");
}
