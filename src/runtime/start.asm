; Punto de entrada y llamadas al sistema de Linux x86-64. Sin libc.
; Los nombres llevan '_' porque tcc prefija asi todos los simbolos de C.

global _start
global _sys_exit, _sys_write, _sys_read, _sys_open, _sys_close, _sys_map
extern _main

section .text

; Al entrar: [rsp] = argc, rsp+8 = argv
_start:
    xor ebp, ebp
    mov rdi, [rsp]
    lea rsi, [rsp + 8]
    and rsp, -16
    call _main
    mov edi, eax
    mov eax, 60                 ; exit
    syscall

; Los argumentos de C (rdi, rsi, rdx) ya coinciden con los de la syscall.
; Retornan el resultado del kernel (negativo = -errno).

; void sys_exit(int code)
_sys_exit:
    mov eax, 60
    syscall

; int sys_write(int fd, char *buf, int n)
_sys_write:
    mov eax, 1
    syscall
    ret

; int sys_read(int fd, char *buf, int n)
_sys_read:
    xor eax, eax
    syscall
    ret

; int sys_open(char *path, int flags, int mode)
_sys_open:
    mov eax, 2
    syscall
    ret

; int sys_close(int fd)
_sys_close:
    mov eax, 3
    syscall
    ret

; char *sys_map(int len): memoria anonima, lectura/escritura y en ceros
_sys_map:
    mov rsi, rdi
    xor edi, edi
    mov edx, 3                  ; PROT_READ | PROT_WRITE
    mov r10d, 0x22              ; MAP_PRIVATE | MAP_ANONYMOUS
    mov r8, -1
    xor r9d, r9d
    mov eax, 9
    syscall
    ret
