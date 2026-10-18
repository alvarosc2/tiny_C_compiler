; generado por tcc: NASM, sintaxis Intel, x86-64 Linux
extern _sys_exit
extern _sys_write
extern _sys_read
extern _sys_open
extern _sys_close
extern _sys_map

section .text

; void* alloc
global _alloc
_alloc:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 15
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    push rax
    mov rax, 16
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    movsxd rax, eax
    push rax
    mov rax, 16
    mov rcx, rax
    pop rax
    imul rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rel _rt_left]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L2
    mov rax, 1048576
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L3
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
L3:
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _sys_map
    mov rcx, rax
    mov qword [rel _rt_heap], rcx
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    mov dword [rel _rt_left], ecx
    movsxd rax, eax
L2:
    mov rax, qword [rel _rt_heap]
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, qword [rel _rt_heap]
    push rax
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, rax
    mov qword [rel _rt_heap], rcx
    movsxd rax, dword [rel _rt_left]
    push rax
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _rt_left], ecx
    movsxd rax, eax
    mov rax, qword [rbp-24]
    jmp L1
    xor eax, eax
L1:
    mov rsp, rbp
    pop rbp
    ret

; void copy_mem
global _copy_mem
_copy_mem:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
L5:
    movsxd rax, dword [rbp-32]
    push rax
    movsxd rax, dword [rbp-24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setl al
    movzx eax, al
    cmp rax, 0
    je L6
    mov rax, qword [rbp-16]
    push rax
    movsxd rax, dword [rbp-32]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    push rax
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-32]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
    movsxd rax, dword [rbp-32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    jmp L5
L6:
    xor eax, eax
L4:
    mov rsp, rbp
    pop rbp
    ret

; int str_len
global _str_len
_str_len:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
L8:
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L9
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    jmp L8
L9:
    movsxd rax, dword [rbp-16]
    jmp L7
    xor eax, eax
L7:
    mov rsp, rbp
    pop rbp
    ret

; int str_eq
global _str_eq
_str_eq:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
L11:
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-24]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L13
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-24]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    push rax
    mov rax, qword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L13
    mov eax, 1
    jmp L14
L13:
    mov eax, 0
L14:
    cmp rax, 0
    je L12
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    jmp L11
L12:
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-24]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    push rax
    mov rax, qword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    jmp L10
    xor eax, eax
L10:
    mov rsp, rbp
    pop rbp
    ret

; char* str_cat
global _str_cat
_str_cat:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _str_len
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _str_len
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-24]
    push rax
    movsxd rax, dword [rbp-32]
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    push rax
    pop rdi
    call _alloc
    mov rcx, rax
    mov qword [rbp-40], rcx
    mov rax, qword [rbp-40]
    push rax
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _copy_mem
    mov rax, qword [rbp-40]
    push rax
    movsxd rax, dword [rbp-24]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, qword [rbp-16]
    push rax
    movsxd rax, dword [rbp-32]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _copy_mem
    mov rax, qword [rbp-40]
    jmp L15
    xor eax, eax
L15:
    mov rsp, rbp
    pop rbp
    ret

; void print_char
global _print_char
_print_char:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, 1
    push rax
    pop rdi
    call _alloc
    mov rcx, rax
    mov qword [rbp-16], rcx
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, qword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
    mov rax, 1
    push rax
    mov rax, qword [rbp-16]
    push rax
    mov rax, 1
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _sys_write
    movsxd rax, eax
    xor eax, eax
L16:
    mov rsp, rbp
    pop rbp
    ret

; void print_str
global _print_str
_print_str:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, 1
    push rax
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _str_len
    movsxd rax, eax
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _sys_write
    movsxd rax, eax
    xor eax, eax
L17:
    mov rsp, rbp
    pop rbp
    ret

; char* int_to_str
global _int_to_str
_int_to_str:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov rax, 12
    push rax
    pop rdi
    call _alloc
    mov rcx, rax
    mov qword [rbp-16], rcx
    mov rax, 11
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setl al
    movzx eax, al
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L19
    mov rax, 0
    push rax
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
L19:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L20
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    mov rax, 48
    push rax
    mov rax, qword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
L20:
L21:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L22
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    mov rax, 48
    push rax
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    movsxd rax, eax
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    imul rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    push rax
    mov rax, qword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    jmp L21
L22:
    movsxd rax, dword [rbp-32]
    cmp rax, 0
    je L23
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    mov rax, 45
    push rax
    mov rax, qword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
L23:
    mov rax, qword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    mov rcx, rax
    pop rax
    add rax, rcx
    jmp L18
    xor eax, eax
L18:
    mov rsp, rbp
    pop rbp
    ret

; void print_int
global _print_int
_print_int:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _int_to_str
    push rax
    pop rdi
    call _print_str
    xor eax, eax
L24:
    mov rsp, rbp
    pop rbp
    ret

; int write_all
global _write_all
_write_all:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
L26:
    movsxd rax, dword [rbp-32]
    push rax
    movsxd rax, dword [rbp-24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setl al
    movzx eax, al
    cmp rax, 0
    je L27
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, qword [rbp-16]
    push rax
    movsxd rax, dword [rbp-32]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    movsxd rax, dword [rbp-32]
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _sys_write
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-40], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-40]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setle al
    movzx eax, al
    cmp rax, 0
    je L28
    mov rax, 0
    jmp L25
L28:
    movsxd rax, dword [rbp-32]
    push rax
    movsxd rax, dword [rbp-40]
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    jmp L26
L27:
    mov rax, 1
    jmp L25
    xor eax, eax
L25:
    mov rsp, rbp
    pop rbp
    ret

; char* read_file
global _read_file
_read_file:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _sys_open
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setl al
    movzx eax, al
    cmp rax, 0
    je L30
    mov rax, 0
    jmp L29
L30:
    mov rax, 65536
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    push rax
    pop rdi
    call _alloc
    mov rcx, rax
    mov qword [rbp-40], rcx
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, qword [rbp-40]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _sys_read
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
L31:
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L32
    movsxd rax, dword [rbp-32]
    push rax
    movsxd rax, dword [rbp-48]
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-32]
    push rax
    movsxd rax, dword [rbp-24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L33
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    imul rax, rcx
    movsxd rax, eax
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    push rax
    pop rdi
    call _alloc
    mov rcx, rax
    mov qword [rbp-56], rcx
    mov rax, qword [rbp-56]
    push rax
    mov rax, qword [rbp-40]
    push rax
    movsxd rax, dword [rbp-32]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _copy_mem
    mov rax, qword [rbp-56]
    mov rcx, rax
    mov qword [rbp-40], rcx
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    imul rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
L33:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, qword [rbp-40]
    push rax
    movsxd rax, dword [rbp-32]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    movsxd rax, dword [rbp-32]
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _sys_read
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
    jmp L31
L32:
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _sys_close
    movsxd rax, eax
    mov rax, 0
    push rax
    mov rax, qword [rbp-40]
    push rax
    movsxd rax, dword [rbp-32]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
    mov rax, qword [rbp-40]
    jmp L29
    xor eax, eax
L29:
    mov rsp, rbp
    pop rbp
    ret

; void set_source_name
global _set_source_name
_set_source_name:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    mov rcx, rax
    mov qword [rel _rt_name], rcx
    xor eax, eax
L34:
    mov rsp, rbp
    pop rbp
    ret

; void error_quiet
global _error_quiet
_error_quiet:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    mov dword [rel _rt_quiet], ecx
    movsxd rax, eax
    xor eax, eax
L35:
    mov rsp, rbp
    pop rbp
    ret

; void error_log_reset
global _error_log_reset
_error_log_reset:
    push rbp
    mov rbp, rsp
    lea rax, [rel S1]
    mov rcx, rax
    mov qword [rel _rt_log], rcx
    xor eax, eax
L36:
    mov rsp, rbp
    pop rbp
    ret

; char* error_log
global _error_log
_error_log:
    push rbp
    mov rbp, rsp
    mov rax, qword [rel _rt_log]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L38
    lea rax, [rel S2]
    mov rcx, rax
    mov qword [rel _rt_log], rcx
L38:
    mov rax, qword [rel _rt_log]
    jmp L37
    xor eax, eax
L37:
    mov rsp, rbp
    pop rbp
    ret

; void report_error
global _report_error
_report_error:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    mov rax, qword [rel _rt_name]
    push rax
    lea rax, [rel S3]
    push rax
    pop rsi
    pop rdi
    call _str_cat
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-32]
    push rax
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    sub rsp, 8
    call _int_to_str
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _str_cat
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-32]
    push rax
    lea rax, [rel S4]
    push rax
    pop rsi
    pop rdi
    call _str_cat
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-32]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    sub rsp, 8
    call _int_to_str
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _str_cat
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-32]
    push rax
    lea rax, [rel S5]
    push rax
    pop rsi
    pop rdi
    call _str_cat
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-32]
    push rax
    mov rax, qword [rbp-24]
    push rax
    pop rsi
    pop rdi
    call _str_cat
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-32]
    push rax
    lea rax, [rel S6]
    push rax
    pop rsi
    pop rdi
    call _str_cat
    mov rcx, rax
    mov qword [rbp-32], rcx
    movsxd rax, dword [rel _rt_quiet]
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L40
    mov rax, 2
    push rax
    mov rax, qword [rbp-32]
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _str_len
    movsxd rax, eax
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _write_all
    movsxd rax, eax
L40:
    call _error_log
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _str_cat
    mov rcx, rax
    mov qword [rel _rt_log], rcx
    xor eax, eax
L39:
    mov rsp, rbp
    pop rbp
    ret

; void em_room
global _em_room
_em_room:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    movsxd rax, dword [rel _em_len]
    push rax
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    push rax
    movsxd rax, dword [rel _em_cap]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setle al
    movzx eax, al
    cmp rax, 0
    je L42
    jmp L41
L42:
    movsxd rax, dword [rel _em_cap]
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L43
    mov rax, 4096
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
L43:
L44:
    movsxd rax, dword [rel _em_len]
    push rax
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    push rax
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L45
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    imul rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    jmp L44
L45:
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _alloc
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, qword [rbp-24]
    push rax
    mov rax, qword [rel _em_buf]
    push rax
    movsxd rax, dword [rel _em_len]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _copy_mem
    mov rax, qword [rbp-24]
    mov rcx, rax
    mov qword [rel _em_buf], rcx
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    mov dword [rel _em_cap], ecx
    movsxd rax, eax
    xor eax, eax
L41:
    mov rsp, rbp
    pop rbp
    ret

; void emit_reset
global _emit_reset
_emit_reset:
    push rbp
    mov rbp, rsp
    mov rax, 0
    mov rcx, rax
    mov dword [rel _em_len], ecx
    movsxd rax, eax
    mov rax, 0
    push rax
    pop rdi
    call _em_room
    mov rax, 0
    push rax
    mov rax, qword [rel _em_buf]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
    xor eax, eax
L46:
    mov rsp, rbp
    pop rbp
    ret

; void emit
global _emit
_emit:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _str_len
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _em_room
    mov rax, qword [rel _em_buf]
    push rax
    movsxd rax, dword [rel _em_len]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _copy_mem
    movsxd rax, dword [rel _em_len]
    push rax
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _em_len], ecx
    movsxd rax, eax
    xor eax, eax
L47:
    mov rsp, rbp
    pop rbp
    ret

; void emit_char
global _emit_char
_emit_char:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, 1
    push rax
    pop rdi
    call _em_room
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, qword [rel _em_buf]
    push rax
    movsxd rax, dword [rel _em_len]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
    movsxd rax, dword [rel _em_len]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _em_len], ecx
    movsxd rax, eax
    mov rax, 0
    push rax
    mov rax, qword [rel _em_buf]
    push rax
    movsxd rax, dword [rel _em_len]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
    xor eax, eax
L48:
    mov rsp, rbp
    pop rbp
    ret

; void emit_int
global _emit_int
_emit_int:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _int_to_str
    push rax
    pop rdi
    call _emit
    xor eax, eax
L49:
    mov rsp, rbp
    pop rbp
    ret

; char* emit_text
global _emit_text
_emit_text:
    push rbp
    mov rbp, rsp
    mov rax, 0
    push rax
    pop rdi
    call _em_room
    mov rax, qword [rel _em_buf]
    jmp L50
    xor eax, eax
L50:
    mov rsp, rbp
    pop rbp
    ret

section .rodata
S0: db "<entrada>", 0
S1: db 0
S2: db 0
S3: db ":", 0
S4: db ":", 0
S5: db ": error: ", 0
S6: db 10, 0

section .data
_rt_heap: dq 0
_rt_left: dd 0
_rt_name: dq S0
_rt_log: dq 0
_rt_quiet: dd 0
_em_buf: dq 0
_em_len: dd 0
_em_cap: dd 0
