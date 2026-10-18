#include "rt.h"

// Reserva por bloques de 1 MiB. La memoria no se libera y viene en ceros.
char *rt_heap;
int rt_left;

void *alloc(int n) {
    n = (n + 15) / 16 * 16;
    if (n > rt_left) {
        int size = 1048576;
        if (n > size) size = n;
        rt_heap = sys_map(size);
        rt_left = size;
    }
    char *p = rt_heap;
    rt_heap = rt_heap + n;
    rt_left = rt_left - n;
    return p;
}

void copy_mem(char *dst, char *src, int n) {
    int i = 0;
    while (i < n) {
        dst[i] = src[i];
        i = i + 1;
    }
}

int str_len(char *s) {
    int n = 0;
    while (s[n] != 0) n = n + 1;
    return n;
}

int str_eq(char *a, char *b) {
    int i = 0;
    while (a[i] != 0 && a[i] == b[i]) i = i + 1;
    return a[i] == b[i];
}

char *str_cat(char *a, char *b) {
    int la = str_len(a);
    int lb = str_len(b);
    char *p = alloc(la + lb + 1);
    copy_mem(p, a, la);
    copy_mem(p + la, b, lb);
    return p;
}

void print_char(int c) {
    char *b = alloc(1);
    b[0] = c;
    sys_write(1, b, 1);
}

void print_str(char *s) {
    sys_write(1, s, str_len(s));
}

// Trabaja con negativos para que -2147483648 tambien funcione
void print_int(int n) {
    char *buf = alloc(12);
    int i = 12;
    int neg = n < 0;
    if (n > 0) n = 0 - n;
    if (n == 0) {
        i = i - 1;
        buf[i] = '0';
    }
    while (n != 0) {
        i = i - 1;
        buf[i] = '0' - n % 10;
        n = n / 10;
    }
    if (neg) {
        i = i - 1;
        buf[i] = '-';
    }
    sys_write(1, buf + i, 12 - i);
}
