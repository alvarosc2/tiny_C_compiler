; generado por tcc: NASM, sintaxis Intel, x86-64 Linux
extern _sys_exit
extern _sys_write
extern _sys_read
extern _sys_open
extern _sys_close
extern _sys_map
extern _alloc
extern _copy_mem
extern _str_len
extern _str_eq
extern _str_cat
extern _write_all
extern _read_file
extern _int_to_str
extern _print_char
extern _print_str
extern _print_int
extern _set_source_name
extern _report_error
extern _error_log
extern _error_log_reset
extern _error_quiet
extern _emit_reset
extern _emit
extern _emit_char
extern _emit_int
extern _emit_text
extern _parse
extern _parse_error_count
extern _analyze
extern _type_name
extern _generate

section .text

; int usage
global _usage
_usage:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    lea rax, [rel S0]
    mov rcx, rax
    mov qword [rbp-8], rcx
    mov rax, 2
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
    call _write_all
    movsxd rax, eax
    mov rax, 2
    jmp L1
    xor eax, eax
L1:
    mov rsp, rbp
    pop rbp
    ret

; int main
global _main
_main:
    push rbp
    mov rbp, rsp
    sub rsp, 80
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    mov rax, 0
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, 1
    mov rcx, rax
    mov dword [rbp-40], ecx
    movsxd rax, eax
L3:
    movsxd rax, dword [rbp-40]
    push rax
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setl al
    movzx eax, al
    cmp rax, 0
    je L4
    mov rax, qword [rbp-16]
    push rax
    movsxd rax, dword [rbp-40]
    mov rcx, rax
    pop rax
    imul rcx, rcx, 8
    add rax, rcx
    mov rdx, rax
    mov rax, qword [rdx]
    mov rcx, rax
    mov qword [rbp-48], rcx
    mov rax, qword [rbp-48]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    push rax
    mov rax, 45
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L6
    mov rax, qword [rbp-48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    push rax
    mov rax, 45
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L6
    mov eax, 1
    jmp L7
L6:
    mov eax, 0
L7:
    cmp rax, 0
    je L5
    mov rax, qword [rbp-48]
    push rax
    lea rax, [rel S1]
    push rax
    pop rsi
    pop rdi
    call _str_eq
    movsxd rax, eax
    cmp rax, 0
    je L8
    mov rax, 1
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    jmp L9
L8:
    mov rax, qword [rbp-48]
    push rax
    lea rax, [rel S2]
    push rax
    pop rsi
    pop rdi
    call _str_eq
    movsxd rax, eax
    cmp rax, 0
    je L10
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    jmp L11
L10:
    call _usage
    movsxd rax, eax
    jmp L2
L11:
L9:
    jmp L12
L5:
    mov rax, qword [rbp-32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L13
    call _usage
    movsxd rax, eax
    jmp L2
L13:
    mov rax, qword [rbp-48]
    mov rcx, rax
    mov qword [rbp-32], rcx
L12:
    movsxd rax, dword [rbp-40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-40], ecx
    movsxd rax, eax
    jmp L3
L4:
    mov rax, qword [rbp-32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L14
    call _usage
    movsxd rax, eax
    jmp L2
L14:
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _read_file
    mov rcx, rax
    mov qword [rbp-56], rcx
    mov rax, qword [rbp-56]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L15
    lea rax, [rel S3]
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _str_cat
    push rax
    lea rax, [rel S4]
    push rax
    pop rsi
    pop rdi
    call _str_cat
    mov rcx, rax
    mov qword [rbp-64], rcx
    mov rax, 2
    push rax
    mov rax, qword [rbp-64]
    push rax
    mov rax, qword [rbp-64]
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
    mov rax, 1
    jmp L2
L15:
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _set_source_name
    mov rax, qword [rbp-56]
    push rax
    pop rdi
    call _parse
    mov rcx, rax
    mov qword [rbp-72], rcx
    call _parse_error_count
    movsxd rax, eax
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L16
    mov rax, 1
    jmp L2
L16:
    mov rax, qword [rbp-72]
    push rax
    pop rdi
    call _analyze
    movsxd rax, eax
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L17
    mov rax, 1
    jmp L2
L17:
    movsxd rax, dword [rbp-24]
    cmp rax, 0
    je L18
    mov rax, qword [rbp-72]
    push rax
    pop rdi
    call _generate
    mov rcx, rax
    mov qword [rbp-80], rcx
    mov rax, 1
    push rax
    mov rax, qword [rbp-80]
    push rax
    mov rax, qword [rbp-80]
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
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L19
    mov rax, 1
    jmp L2
L19:
L18:
    mov rax, 0
    jmp L2
    xor eax, eax
L2:
    mov rsp, rbp
    pop rbp
    ret

section .rodata
S0: db "uso: tcc [--check | --asm] archivo.c", 10, 0
S1: db "--asm", 0
S2: db "--check", 0
S3: db "no se puede leer ", 0
S4: db 10, 0

section .data
