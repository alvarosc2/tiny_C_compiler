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

; void* node_new
global _node_new
_node_new:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    mov rax, 72
    push rax
    pop rdi
    call _alloc
    mov rcx, rax
    mov qword [rbp-32], rcx
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, qword [rbp-32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov dword [rdx], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, qword [rbp-32]
    push rax
    mov rax, 4
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
    mov rax, qword [rbp-32]
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
    mov rax, qword [rbp-32]
    jmp L1
    xor eax, eax
L1:
    mov rsp, rbp
    pop rbp
    ret

; int node_kind
global _node_kind
_node_kind:
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
    movsxd rax, dword [rdx]
    jmp L2
    xor eax, eax
L2:
    mov rsp, rbp
    pop rbp
    ret

; int node_line
global _node_line
_node_line:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    mov rax, 4
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

; int node_col
global _node_col
_node_col:
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
    jmp L4
    xor eax, eax
L4:
    mov rsp, rbp
    pop rbp
    ret

; int node_value
global _node_value
_node_value:
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
    jmp L5
    xor eax, eax
L5:
    mov rsp, rbp
    pop rbp
    ret

; void* node_a
global _node_a
_node_a:
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
    mov rax, qword [rdx]
    jmp L6
    xor eax, eax
L6:
    mov rsp, rbp
    pop rbp
    ret

; void* node_b
global _node_b
_node_b:
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
    jmp L7
    xor eax, eax
L7:
    mov rsp, rbp
    pop rbp
    ret

; void* node_c
global _node_c
_node_c:
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
    jmp L8
    xor eax, eax
L8:
    mov rsp, rbp
    pop rbp
    ret

; void* node_next
global _node_next
_node_next:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    mov rax, 40
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    mov rax, qword [rdx]
    jmp L9
    xor eax, eax
L9:
    mov rsp, rbp
    pop rbp
    ret

; char* node_text
global _node_text
_node_text:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    mov rax, 48
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    mov rax, qword [rdx]
    jmp L10
    xor eax, eax
L10:
    mov rsp, rbp
    pop rbp
    ret

; int node_type
global _node_type
_node_type:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    mov rax, 56
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsxd rax, dword [rdx]
    jmp L11
    xor eax, eax
L11:
    mov rsp, rbp
    pop rbp
    ret

; void* node_decl
global _node_decl
_node_decl:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    mov rax, 64
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    mov rax, qword [rdx]
    jmp L12
    xor eax, eax
L12:
    mov rsp, rbp
    pop rbp
    ret

; void node_set_value
global _node_set_value
_node_set_value:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, qword [rbp-8]
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
    xor eax, eax
L13:
    mov rsp, rbp
    pop rbp
    ret

; void node_set_a
global _node_set_a
_node_set_a:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-8]
    push rax
    mov rax, 16
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov qword [rdx], rcx
    xor eax, eax
L14:
    mov rsp, rbp
    pop rbp
    ret

; void node_set_b
global _node_set_b
_node_set_b:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-8]
    push rax
    mov rax, 24
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov qword [rdx], rcx
    xor eax, eax
L15:
    mov rsp, rbp
    pop rbp
    ret

; void node_set_c
global _node_set_c
_node_set_c:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-8]
    push rax
    mov rax, 32
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov qword [rdx], rcx
    xor eax, eax
L16:
    mov rsp, rbp
    pop rbp
    ret

; void node_set_next
global _node_set_next
_node_set_next:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-8]
    push rax
    mov rax, 40
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov qword [rdx], rcx
    xor eax, eax
L17:
    mov rsp, rbp
    pop rbp
    ret

; void node_set_text
global _node_set_text
_node_set_text:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-8]
    push rax
    mov rax, 48
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov qword [rdx], rcx
    xor eax, eax
L18:
    mov rsp, rbp
    pop rbp
    ret

; void node_set_type
global _node_set_type
_node_set_type:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, qword [rbp-8]
    push rax
    mov rax, 56
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov dword [rdx], ecx
    movsxd rax, eax
    xor eax, eax
L19:
    mov rsp, rbp
    pop rbp
    ret

; void node_set_decl
global _node_set_decl
_node_set_decl:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-8]
    push rax
    mov rax, 64
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov qword [rdx], rcx
    xor eax, eax
L20:
    mov rsp, rbp
    pop rbp
    ret

; int type_base
global _type_base
_type_base:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 1000
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    movsxd rax, eax
    push rax
    mov rax, 1000
    mov rcx, rax
    pop rax
    imul rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    jmp L21
    xor eax, eax
L21:
    mov rsp, rbp
    pop rbp
    ret

; int type_ptrs
global _type_ptrs
_type_ptrs:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 1000
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    movsxd rax, eax
    jmp L22
    xor eax, eax
L22:
    mov rsp, rbp
    pop rbp
    ret

section .data
