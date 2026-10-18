; generado por tcc: NASM, sintaxis Intel, x86-64 Linux
extern _alloc
extern _copy_mem
extern _str_eq
extern _str_cat
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

section .text

; char* sym_name
global _sym_name
_sym_name:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    mov rax, qword [rdx]
    jmp L1
    xor eax, eax
L1:
    mov rsp, rbp
    pop rbp
    ret

; int sym_type
global _sym_type
_sym_type:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    mov rax, 8
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsxd rax, dword [rdx]
    jmp L2
    xor eax, eax
L2:
    mov rsp, rbp
    pop rbp
    ret

; int sym_kind
global _sym_kind
_sym_kind:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    mov rax, 12
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsxd rax, dword [rdx]
    jmp L3
    xor eax, eax
L3:
    mov rsp, rbp
    pop rbp
    ret

; int sym_depth
global _sym_depth
_sym_depth:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    mov rax, 16
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsxd rax, dword [rdx]
    jmp L4
    xor eax, eax
L4:
    mov rsp, rbp
    pop rbp
    ret

; int sym_defined
global _sym_defined
_sym_defined:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    mov rax, 20
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsxd rax, dword [rdx]
    jmp L5
    xor eax, eax
L5:
    mov rsp, rbp
    pop rbp
    ret

; void* sym_next
global _sym_next
_sym_next:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    mov rax, 24
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    mov rax, qword [rdx]
    jmp L6
    xor eax, eax
L6:
    mov rsp, rbp
    pop rbp
    ret

; void* sym_decl
global _sym_decl
_sym_decl:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    mov rax, 32
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    mov rax, qword [rdx]
    jmp L7
    xor eax, eax
L7:
    mov rsp, rbp
    pop rbp
    ret

; void sym_set_defined
global _sym_set_defined
_sym_set_defined:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, qword [rbp-8]
    push rax
    mov rax, 20
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov dword [rdx], ecx
    movsxd rax, eax
    xor eax, eax
L8:
    mov rsp, rbp
    pop rbp
    ret

; void st_reset
global _st_reset
_st_reset:
    push rbp
    mov rbp, rsp
    mov rax, 0
    mov rcx, rax
    mov qword [rel _st_top], rcx
    mov rax, 0
    mov rcx, rax
    mov dword [rel _st_depth], ecx
    movsxd rax, eax
    xor eax, eax
L9:
    mov rsp, rbp
    pop rbp
    ret

; int st_depth_now
global _st_depth_now
_st_depth_now:
    push rbp
    mov rbp, rsp
    movsxd rax, dword [rel _st_depth]
    jmp L10
    xor eax, eax
L10:
    mov rsp, rbp
    pop rbp
    ret

; void st_push
global _st_push
_st_push:
    push rbp
    mov rbp, rsp
    movsxd rax, dword [rel _st_depth]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _st_depth], ecx
    movsxd rax, eax
    xor eax, eax
L11:
    mov rsp, rbp
    pop rbp
    ret

; void st_pop
global _st_pop
_st_pop:
    push rbp
    mov rbp, rsp
L13:
    mov rax, qword [rel _st_top]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L15
    mov rax, qword [rel _st_top]
    push rax
    pop rdi
    call _sym_depth
    movsxd rax, eax
    push rax
    movsxd rax, dword [rel _st_depth]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L15
    mov eax, 1
    jmp L16
L15:
    mov eax, 0
L16:
    cmp rax, 0
    je L14
    mov rax, qword [rel _st_top]
    push rax
    pop rdi
    call _sym_next
    mov rcx, rax
    mov qword [rel _st_top], rcx
    jmp L13
L14:
    movsxd rax, dword [rel _st_depth]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _st_depth], ecx
    movsxd rax, eax
    xor eax, eax
L12:
    mov rsp, rbp
    pop rbp
    ret

; void* sym_declare
global _sym_declare
_sym_declare:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    mov [rbp-32], rcx
    mov rax, 40
    push rax
    pop rdi
    call _alloc
    mov rcx, rax
    mov qword [rbp-40], rcx
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-40]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov qword [rdx], rcx
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, qword [rbp-40]
    push rax
    mov rax, 8
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov dword [rdx], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, qword [rbp-40]
    push rax
    mov rax, 12
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov dword [rdx], ecx
    movsxd rax, eax
    movsxd rax, dword [rel _st_depth]
    push rax
    mov rax, qword [rbp-40]
    push rax
    mov rax, 16
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov dword [rdx], ecx
    movsxd rax, eax
    mov rax, qword [rel _st_top]
    push rax
    mov rax, qword [rbp-40]
    push rax
    mov rax, 24
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov qword [rdx], rcx
    mov rax, qword [rbp-32]
    push rax
    mov rax, qword [rbp-40]
    push rax
    mov rax, 32
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov qword [rdx], rcx
    mov rax, qword [rbp-40]
    mov rcx, rax
    mov qword [rel _st_top], rcx
    mov rax, qword [rbp-40]
    jmp L17
    xor eax, eax
L17:
    mov rsp, rbp
    pop rbp
    ret

; void* sym_lookup
global _sym_lookup
_sym_lookup:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rel _st_top]
    mov rcx, rax
    mov qword [rbp-16], rcx
L19:
    mov rax, qword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L20
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _sym_name
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rsi
    pop rdi
    call _str_eq
    movsxd rax, eax
    cmp rax, 0
    je L21
    mov rax, qword [rbp-16]
    jmp L18
L21:
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _sym_next
    mov rcx, rax
    mov qword [rbp-16], rcx
    jmp L19
L20:
    mov rax, 0
    jmp L18
    xor eax, eax
L18:
    mov rsp, rbp
    pop rbp
    ret

; void* sym_lookup_local
global _sym_lookup_local
_sym_lookup_local:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rel _st_top]
    mov rcx, rax
    mov qword [rbp-16], rcx
L23:
    mov rax, qword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L25
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _sym_depth
    movsxd rax, eax
    push rax
    movsxd rax, dword [rel _st_depth]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L25
    mov eax, 1
    jmp L26
L25:
    mov eax, 0
L26:
    cmp rax, 0
    je L24
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _sym_name
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rsi
    pop rdi
    call _str_eq
    movsxd rax, eax
    cmp rax, 0
    je L27
    mov rax, qword [rbp-16]
    jmp L22
L27:
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _sym_next
    mov rcx, rax
    mov qword [rbp-16], rcx
    jmp L23
L24:
    mov rax, 0
    jmp L22
    xor eax, eax
L22:
    mov rsp, rbp
    pop rbp
    ret

section .data
_st_top: dq 0
_st_depth: dd 0
