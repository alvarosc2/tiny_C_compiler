#include "rt.h"
#include "runtime.h"

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
        *(dst + i) = *(src + i);
        i = i + 1;
    }
}

int str_len(char *s) {
    int n = 0;
    while (*(s + n) != 0) n = n + 1;
    return n;
}

int str_eq(char *a, char *b) {
    int i = 0;
    while (*(a + i) != 0 && *(a + i) == *(b + i)) i = i + 1;
    return *(a + i) == *(b + i);
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
    *(b + 0) = c;
    sys_write(1, b, 1);
}

void print_str(char *s) {
    sys_write(1, s, str_len(s));
}

// Trabaja con negativos para que -2147483648 tambien funcione
char *int_to_str(int n) {
    char *buf = alloc(12);
    int i = 11;
    int neg = n < 0;
    if (n > 0) n = 0 - n;
    if (n == 0) {
        i = i - 1;
        *(buf + i) = '0';
    }
    while (n != 0) {
        i = i - 1;
        *(buf + i) = '0' - (n - n / 10 * 10);
        n = n / 10;
    }
    if (neg) {
        i = i - 1;
        *(buf + i) = '-';
    }
    return buf + i;
}

void print_int(int n) {
    print_str(int_to_str(n));
}

// ---------- archivos ----------

// Escribe todo el bufer; devuelve 0 si hubo error
int write_all(int fd, char *buf, int n) {
    int done = 0;
    while (done < n) {
        int w = sys_write(fd, buf + done, n - done);
        if (w <= 0) return 0;
        done = done + w;
    }
    return 1;
}

// Lee un archivo completo como cadena terminada en 0; nulo si no se puede abrir
char *read_file(char *path) {
    int fd = sys_open(path, 0, 0);
    if (fd < 0) return 0;
    int cap = 65536;
    int len = 0;
    char *buf = alloc(cap + 1);
    int n = sys_read(fd, buf, cap);
    while (n > 0) {
        len = len + n;
        if (len == cap) {
            char *bigger = alloc(cap * 2 + 1);
            copy_mem(bigger, buf, len);
            buf = bigger;
            cap = cap * 2;
        }
        n = sys_read(fd, buf + len, cap - len);
    }
    sys_close(fd);
    *(buf + len) = 0;
    return buf;
}

// ---------- servicios del compilador (runtime.h) ----------

char *rt_name = "<entrada>";
char *rt_log;
int rt_quiet;

void set_source_name(char *name) {
    rt_name = name;
}

void error_quiet(int quiet) {
    rt_quiet = quiet;
}

void error_log_reset() {
    rt_log = "";
}

char *error_log() {
    if (rt_log == 0) rt_log = "";
    return rt_log;
}

// archivo:linea:col: error: mensaje
void report_error(int line, int col, char *msg) {
    char *text = str_cat(rt_name, ":");
    text = str_cat(text, int_to_str(line));
    text = str_cat(text, ":");
    text = str_cat(text, int_to_str(col));
    text = str_cat(text, ": error: ");
    text = str_cat(text, msg);
    text = str_cat(text, "\n");
    if (!rt_quiet) write_all(2, text, str_len(text));
    rt_log = str_cat(error_log(), text);
}

// ---------- bufer de salida del generador ----------

char *em_buf;
int em_len;
int em_cap;

void em_room(int extra) {
    if (em_len + extra + 1 <= em_cap) return;
    int cap = em_cap;
    if (cap == 0) cap = 4096;
    while (em_len + extra + 1 > cap) cap = cap * 2;
    char *bigger = alloc(cap);
    copy_mem(bigger, em_buf, em_len);
    em_buf = bigger;
    em_cap = cap;
}

void emit_reset() {
    em_len = 0;
    em_room(0);
    *(em_buf + 0) = 0;
}

void emit(char *s) {
    int n = str_len(s);
    em_room(n);
    copy_mem(em_buf + em_len, s, n + 1);
    em_len = em_len + n;
}

void emit_char(int c) {
    em_room(1);
    *(em_buf + em_len) = c;
    em_len = em_len + 1;
    *(em_buf + em_len) = 0;
}

void emit_int(int n) {
    emit(int_to_str(n));
}

char *emit_text() {
    em_room(0);
    return em_buf;
}
