#include "rt.h"

int fact(int n) {
    if (n <= 1) return 1;
    return n * fact(n - 1);
}

int main() {
    int i = 1;
    print_str("Factoriales:\n");
    while (i <= 10) {
        print_int(i);
        print_str("! = ");
        print_int(fact(i));
        print_char('\n');
        i = i + 1;
    }
    return 0;
}
