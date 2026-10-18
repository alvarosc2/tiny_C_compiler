#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "runtime.h"

void *alloc(int n) {
    return calloc(1, n);
}

void copy_mem(char *dst, char *src, int n) {
    memcpy(dst, src, n);
}

int str_eq(char *a, char *b) {
    return strcmp(a, b) == 0;
}

char *str_cat(char *a, char *b) {
    size_t la = strlen(a);
    size_t lb = strlen(b);
    char *p = calloc(1, la + lb + 1);
    memcpy(p, a, la);
    memcpy(p + la, b, lb);
    return p;
}

static char log_buf[65536];
static size_t log_len;
static int quiet_mode;
static const char *source_name = "<entrada>";

void set_source_name(char *name) {
    source_name = name;
}

void report_error(int line, int col, char *msg) {
    char line_buf[1024];
    int n = snprintf(line_buf, sizeof(line_buf), "%s:%d:%d: error: %s\n",
                     source_name, line, col, msg);
    if (!quiet_mode) fputs(line_buf, stderr);
    if (n > 0 && log_len + (size_t)n < sizeof(log_buf)) {
        memcpy(log_buf + log_len, line_buf, n);
        log_len += n;
        log_buf[log_len] = 0;
    }
}

char *error_log() {
    return log_buf;
}

void error_log_reset() {
    log_len = 0;
    log_buf[0] = 0;
}

void error_quiet(int quiet) {
    quiet_mode = quiet;
}

static char *emit_buf;
static size_t emit_len, emit_cap;

static void emit_room(size_t extra) {
    if (emit_len + extra + 1 <= emit_cap) return;
    while (emit_len + extra + 1 > emit_cap) emit_cap = emit_cap ? emit_cap * 2 : 4096;
    emit_buf = realloc(emit_buf, emit_cap);
}

void emit_reset() {
    emit_len = 0;
    emit_room(0);
    emit_buf[0] = 0;
}

void emit(char *s) {
    size_t n = strlen(s);
    emit_room(n);
    memcpy(emit_buf + emit_len, s, n + 1);
    emit_len += n;
}

void emit_char(int c) {
    emit_room(1);
    emit_buf[emit_len++] = (char)c;
    emit_buf[emit_len] = 0;
}

void emit_int(int n) {
    char tmp[16];
    snprintf(tmp, sizeof(tmp), "%d", n);
    emit(tmp);
}

char *emit_text() {
    emit_room(0);
    return emit_buf;
}
