#ifndef RT_H
#define RT_H

/* Biblioteca de ejecucion propia (sin libc). Las sys_* estan en start.asm;
   el resto en lib.c, compilado con tcc. */

void sys_exit(int code);
int sys_write(int fd, char *buf, int n);
int sys_read(int fd, char *buf, int n);
int sys_open(char *path, int flags, int mode);
int sys_close(int fd);
char *sys_map(int len);

void *alloc(int n);
void copy_mem(char *dst, char *src, int n);
int str_len(char *s);
int str_eq(char *a, char *b);
char *str_cat(char *a, char *b);

int write_all(int fd, char *buf, int n);
char *read_file(char *path);
char *int_to_str(int n);

void print_char(int c);
void print_str(char *s);
void print_int(int n);

#endif
