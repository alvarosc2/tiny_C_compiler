; generado por tcc: NASM, sintaxis Intel, x86-64 Linux
extern _node_new
extern _node_kind
extern _node_line
extern _node_col
extern _node_value
extern _node_a
extern _node_b
extern _node_c
extern _node_next
extern _node_text
extern _node_type
extern _node_decl
extern _node_set_value
extern _node_set_a
extern _node_set_b
extern _node_set_c
extern _node_set_next
extern _node_set_text
extern _node_set_type
extern _node_set_decl
extern _type_base
extern _type_ptrs
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
extern _st_reset
extern _st_push
extern _st_pop
extern _st_depth_now
extern _sym_declare
extern _sym_lookup
extern _sym_lookup_local
extern _sym_name
extern _sym_type
extern _sym_kind
extern _sym_depth
extern _sym_defined
extern _sym_next
extern _sym_decl
extern _sym_set_defined

section .text

; void s_report
global _s_report
_s_report:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    movsxd rax, dword [rel _s_stop]
    cmp rax, 0
    je L2
    jmp L1
L2:
    movsxd rax, dword [rel _s_errors]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _s_errors], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_line
    movsxd rax, eax
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    sub rsp, 8
    call _node_col
    add rsp, 8
    movsxd rax, eax
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _report_error
    movsxd rax, dword [rel _s_errors]
    push rax
    mov rax, 20
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setge al
    movzx eax, al
    cmp rax, 0
    je L3
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_line
    movsxd rax, eax
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    sub rsp, 8
    call _node_col
    add rsp, 8
    movsxd rax, eax
    push rax
    lea rax, [rel S0]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _report_error
    mov rax, 1
    mov rcx, rax
    mov dword [rel _s_stop], ecx
    movsxd rax, eax
L3:
    xor eax, eax
L1:
    mov rsp, rbp
    pop rbp
    ret

; char* s_q
global _s_q
_s_q:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S1]
    push rax
    mov rax, qword [rbp-16]
    push rax
    lea rax, [rel S2]
    push rax
    mov rax, qword [rbp-24]
    push rax
    pop rsi
    pop rdi
    sub rsp, 8
    call _str_cat
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _str_cat
    push rax
    pop rsi
    pop rdi
    sub rsp, 8
    call _str_cat
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _str_cat
    jmp L4
    xor eax, eax
L4:
    mov rsp, rbp
    pop rbp
    ret

; char* s_q2
global _s_q2
_s_q2:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    mov [rbp-32], rcx
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-24]
    push rax
    lea rax, [rel S3]
    push rax
    mov rax, qword [rbp-32]
    push rax
    lea rax, [rel S4]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _str_cat
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _s_q
    jmp L5
    xor eax, eax
L5:
    mov rsp, rbp
    pop rbp
    ret

; char* s_itoa
global _s_itoa
_s_itoa:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setl al
    movzx eax, al
    cmp rax, 0
    je L7
    mov rax, 2
    push rax
    pop rdi
    call _alloc
    mov rcx, rax
    mov qword [rbp-16], rcx
    mov rax, 48
    push rax
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
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
    mov rax, 0
    push rax
    mov rax, qword [rbp-16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
    mov rax, qword [rbp-16]
    jmp L6
L7:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    movsxd rax, eax
    push rax
    pop rdi
    call _s_itoa
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
    push rax
    pop rdi
    sub rsp, 8
    call _s_itoa
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _str_cat
    jmp L6
    xor eax, eax
L6:
    mov rsp, rbp
    pop rbp
    ret

; char* s_count
global _s_count
_s_count:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _s_itoa
    push rax
    lea rax, [rel S5]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rsi
    pop rdi
    sub rsp, 8
    call _str_cat
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _str_cat
    mov rcx, rax
    mov qword [rbp-24], rcx
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L9
    mov rax, qword [rbp-24]
    push rax
    lea rax, [rel S6]
    push rax
    pop rsi
    pop rdi
    call _str_cat
    mov rcx, rax
    mov qword [rbp-24], rcx
L9:
    mov rax, qword [rbp-24]
    jmp L8
    xor eax, eax
L8:
    mov rsp, rbp
    pop rbp
    ret

; char* s_op_name
global _s_op_name
_s_op_name:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 267
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L11
    lea rax, [rel S7]
    jmp L10
L11:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 268
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L12
    lea rax, [rel S8]
    jmp L10
L12:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 269
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L13
    lea rax, [rel S9]
    jmp L10
L13:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 270
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L14
    lea rax, [rel S10]
    jmp L10
L14:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 271
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L15
    lea rax, [rel S11]
    jmp L10
L15:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 272
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L16
    lea rax, [rel S12]
    jmp L10
L16:
    mov rax, 2
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
    mov rax, 0
    push rax
    mov rax, qword [rbp-16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
    mov rax, qword [rbp-16]
    jmp L10
    xor eax, eax
L10:
    mov rsp, rbp
    pop rbp
    ret

; char* type_name
global _type_name
_type_name:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L18
    lea rax, [rel S13]
    jmp L17
L18:
    lea rax, [rel S14]
    mov rcx, rax
    mov qword [rbp-16], rcx
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _type_base
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 260
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L19
    lea rax, [rel S15]
    mov rcx, rax
    mov qword [rbp-16], rcx
L19:
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 261
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L20
    lea rax, [rel S16]
    mov rcx, rax
    mov qword [rbp-16], rcx
L20:
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _type_ptrs
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
L21:
    movsxd rax, dword [rbp-32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L22
    mov rax, qword [rbp-16]
    push rax
    lea rax, [rel S17]
    push rax
    pop rsi
    pop rdi
    call _str_cat
    mov rcx, rax
    mov qword [rbp-16], rcx
    movsxd rax, dword [rbp-32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    jmp L21
L22:
    mov rax, qword [rbp-16]
    jmp L17
    xor eax, eax
L17:
    mov rsp, rbp
    pop rbp
    ret

; int s_is_int
global _s_is_int
_s_is_int:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 260
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L24
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 261
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L24
    mov eax, 0
    jmp L25
L24:
    mov eax, 1
L25:
    jmp L23
    xor eax, eax
L23:
    mov rsp, rbp
    pop rbp
    ret

; int s_is_ptr
global _s_is_ptr
_s_is_ptr:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L27
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _type_ptrs
    movsxd rax, eax
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L27
    mov eax, 1
    jmp L28
L27:
    mov eax, 0
L28:
    jmp L26
    xor eax, eax
L26:
    mov rsp, rbp
    pop rbp
    ret

; int s_is_scalar
global _s_is_scalar
_s_is_scalar:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _s_is_int
    movsxd rax, eax
    cmp rax, 0
    jne L30
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _s_is_ptr
    movsxd rax, eax
    cmp rax, 0
    jne L30
    mov eax, 0
    jmp L31
L30:
    mov eax, 1
L31:
    jmp L29
    xor eax, eax
L29:
    mov rsp, rbp
    pop rbp
    ret

; int s_is_void_ptr
global _s_is_void_ptr
_s_is_void_ptr:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 262
    push rax
    mov rax, 1000
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    jmp L32
    xor eax, eax
L32:
    mov rsp, rbp
    pop rbp
    ret

; int s_ptr_compat
global _s_ptr_compat
_s_ptr_compat:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L36
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _s_is_void_ptr
    movsxd rax, eax
    cmp rax, 0
    jne L36
    mov eax, 0
    jmp L37
L36:
    mov eax, 1
L37:
    cmp rax, 0
    jne L34
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _s_is_void_ptr
    movsxd rax, eax
    cmp rax, 0
    jne L34
    mov eax, 0
    jmp L35
L34:
    mov eax, 1
L35:
    jmp L33
    xor eax, eax
L33:
    mov rsp, rbp
    pop rbp
    ret

; int s_is_null
global _s_is_null
_s_is_null:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_kind
    movsxd rax, eax
    push rax
    mov rax, 16
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L39
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_value
    movsxd rax, eax
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    jmp L38
L39:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_kind
    movsxd rax, eax
    push rax
    mov rax, 12
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L41
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    push rax
    pop rdi
    call _s_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L41
    mov eax, 1
    jmp L42
L41:
    mov eax, 0
L42:
    cmp rax, 0
    je L40
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _s_is_null
    movsxd rax, eax
    jmp L38
L40:
    mov rax, 0
    jmp L38
    xor eax, eax
L38:
    mov rsp, rbp
    pop rbp
    ret

; int s_assignable
global _s_assignable
_s_assignable:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L45
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L45
    mov eax, 0
    jmp L46
L45:
    mov eax, 1
L46:
    cmp rax, 0
    je L44
    mov rax, 1
    jmp L43
L44:
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _s_is_int
    movsxd rax, eax
    cmp rax, 0
    je L48
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _s_is_int
    movsxd rax, eax
    cmp rax, 0
    je L48
    mov eax, 1
    jmp L49
L48:
    mov eax, 0
L49:
    cmp rax, 0
    je L47
    mov rax, 1
    jmp L43
L47:
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _s_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L51
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _s_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L51
    mov eax, 1
    jmp L52
L51:
    mov eax, 0
L52:
    cmp rax, 0
    je L50
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _s_ptr_compat
    movsxd rax, eax
    jmp L43
L50:
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _s_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L54
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _s_is_int
    movsxd rax, eax
    cmp rax, 0
    je L54
    mov eax, 1
    jmp L55
L54:
    mov eax, 0
L55:
    cmp rax, 0
    je L53
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _s_is_null
    movsxd rax, eax
    jmp L43
L53:
    mov rax, 0
    jmp L43
    xor eax, eax
L43:
    mov rsp, rbp
    pop rbp
    ret

; int s_set
global _s_set
_s_set:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _node_set_type
    movsxd rax, dword [rbp-16]
    jmp L56
    xor eax, eax
L56:
    mov rsp, rbp
    pop rbp
    ret

; int s_fail
global _s_fail
_s_fail:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _s_report
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L57
    xor eax, eax
L57:
    mov rsp, rbp
    pop rbp
    ret

; int s_list_len
global _s_list_len
_s_list_len:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
L59:
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L60
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
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-8], rcx
    jmp L59
L60:
    movsxd rax, dword [rbp-16]
    jmp L58
    xor eax, eax
L58:
    mov rsp, rbp
    pop rbp
    ret

; int s_id
global _s_id
_s_id:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_text
    push rax
    pop rdi
    call _sym_lookup
    mov rcx, rax
    mov qword [rbp-16], rcx
    mov rax, qword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L62
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S18]
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_text
    push rax
    lea rax, [rel S19]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_fail
    movsxd rax, eax
    jmp L61
L62:
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    sub rsp, 8
    call _sym_decl
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _node_set_decl
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _sym_kind
    movsxd rax, eax
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L63
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S20]
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_text
    push rax
    lea rax, [rel S21]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_fail
    movsxd rax, eax
    jmp L61
L63:
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    sub rsp, 8
    call _sym_type
    add rsp, 8
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L61
    xor eax, eax
L61:
    mov rsp, rbp
    pop rbp
    ret

; int s_call
global _s_call
_s_call:
    push rbp
    mov rbp, rsp
    sub rsp, 96
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_text
    mov rcx, rax
    mov qword [rbp-16], rcx
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _sym_lookup
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L66
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _sym_kind
    movsxd rax, eax
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    jne L66
    mov eax, 0
    jmp L67
L66:
    mov eax, 1
L67:
    cmp rax, 0
    je L65
L68:
    mov rax, qword [rbp-32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L69
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _s_expr
    movsxd rax, eax
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-32], rcx
    jmp L68
L69:
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L70
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S22]
    push rax
    mov rax, qword [rbp-16]
    push rax
    lea rax, [rel S23]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_fail
    movsxd rax, eax
    jmp L64
L70:
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S24]
    push rax
    mov rax, qword [rbp-16]
    push rax
    lea rax, [rel S25]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_fail
    movsxd rax, eax
    jmp L64
L65:
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _sym_decl
    mov rcx, rax
    mov qword [rbp-40], rcx
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-40]
    push rax
    pop rsi
    pop rdi
    call _node_set_decl
    mov rax, qword [rbp-40]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-48], rcx
    mov rax, 1
    mov rcx, rax
    mov dword [rbp-56], ecx
    movsxd rax, eax
L71:
    mov rax, qword [rbp-32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L72
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _s_expr
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-64], ecx
    movsxd rax, eax
    mov rax, qword [rbp-48]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L73
    mov rax, qword [rbp-48]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-72], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-72]
    push rax
    movsxd rax, dword [rbp-64]
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _s_assignable
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L74
    mov rax, qword [rbp-32]
    push rax
    lea rax, [rel S26]
    push rax
    movsxd rax, dword [rbp-56]
    push rax
    pop rdi
    call _s_itoa
    push rax
    lea rax, [rel S27]
    push rax
    pop rsi
    pop rdi
    call _str_cat
    push rax
    pop rsi
    pop rdi
    sub rsp, 8
    call _str_cat
    add rsp, 8
    push rax
    lea rax, [rel S28]
    push rax
    mov rax, qword [rbp-16]
    push rax
    lea rax, [rel S29]
    push rax
    pop rsi
    pop rdi
    sub rsp, 8
    call _str_cat
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _str_cat
    push rax
    movsxd rax, dword [rbp-64]
    push rax
    pop rdi
    sub rsp, 8
    call _type_name
    add rsp, 8
    push rax
    lea rax, [rel S30]
    push rax
    movsxd rax, dword [rbp-72]
    push rax
    pop rdi
    sub rsp, 8
    call _type_name
    add rsp, 8
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call _s_q2
    push rax
    pop rsi
    pop rdi
    sub rsp, 8
    call _str_cat
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
L74:
    mov rax, qword [rbp-48]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-48], rcx
L73:
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-32], rcx
    movsxd rax, dword [rbp-56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-56], ecx
    movsxd rax, eax
    jmp L71
L72:
    mov rax, qword [rbp-40]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _s_list_len
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-80], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _s_list_len
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-88], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-80]
    push rax
    movsxd rax, dword [rbp-88]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L75
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S31]
    push rax
    mov rax, qword [rbp-16]
    push rax
    lea rax, [rel S32]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    movsxd rax, dword [rbp-80]
    push rax
    lea rax, [rel S33]
    push rax
    pop rsi
    pop rdi
    call _s_count
    push rax
    lea rax, [rel S34]
    push rax
    movsxd rax, dword [rbp-88]
    push rax
    lea rax, [rel S35]
    push rax
    pop rsi
    pop rdi
    call _s_count
    push rax
    pop rsi
    pop rdi
    sub rsp, 8
    call _str_cat
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _str_cat
    push rax
    pop rsi
    pop rdi
    sub rsp, 8
    call _str_cat
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
L75:
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    sub rsp, 8
    call _sym_type
    add rsp, 8
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L64
    xor eax, eax
L64:
    mov rsp, rbp
    pop rbp
    ret

; int s_cast
global _s_cast
_s_cast:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _s_expr
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L78
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 262
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L78
    mov eax, 0
    jmp L79
L78:
    mov eax, 1
L79:
    cmp rax, 0
    je L77
    movsxd rax, dword [rbp-16]
    jmp L76
L77:
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _s_is_scalar
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L80
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S36]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _type_name
    push rax
    lea rax, [rel S37]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _type_name
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q2
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
L80:
    movsxd rax, dword [rbp-16]
    jmp L76
    xor eax, eax
L76:
    mov rsp, rbp
    pop rbp
    ret

; int s_unop
global _s_unop
_s_unop:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_value
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _s_expr
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L82
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L81
L82:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 42
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L83
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _s_is_ptr
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    jne L85
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _s_is_void_ptr
    movsxd rax, eax
    cmp rax, 0
    jne L85
    mov eax, 0
    jmp L86
L85:
    mov eax, 1
L86:
    cmp rax, 0
    je L84
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S38]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _type_name
    push rax
    lea rax, [rel S39]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_fail
    movsxd rax, eax
    jmp L81
L84:
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 1000
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L81
L83:
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _s_is_scalar
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L87
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S40]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _type_name
    push rax
    lea rax, [rel S41]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_fail
    movsxd rax, eax
    jmp L81
L87:
    mov rax, qword [rbp-8]
    push rax
    mov rax, 260
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L81
    xor eax, eax
L81:
    mov rsp, rbp
    pop rbp
    ret

; int s_bad_operands
global _s_bad_operands
_s_bad_operands:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    mov [rbp-32], rcx
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S42]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _s_op_name
    push rax
    lea rax, [rel S43]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    lea rax, [rel S44]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    sub rsp, 8
    call _type_name
    add rsp, 8
    push rax
    lea rax, [rel S45]
    push rax
    movsxd rax, dword [rbp-32]
    push rax
    pop rdi
    sub rsp, 8
    call _type_name
    add rsp, 8
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call _s_q2
    push rax
    pop rsi
    pop rdi
    sub rsp, 8
    call _str_cat
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_fail
    movsxd rax, eax
    jmp L88
    xor eax, eax
L88:
    mov rsp, rbp
    pop rbp
    ret

; int s_assign
global _s_assign
_s_assign:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-16], rcx
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _s_expr
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _s_expr
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-40], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-32]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L91
    movsxd rax, dword [rbp-40]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L91
    mov eax, 0
    jmp L92
L91:
    mov eax, 1
L92:
    cmp rax, 0
    je L90
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L89
L90:
    movsxd rax, dword [rbp-32]
    push rax
    movsxd rax, dword [rbp-40]
    push rax
    mov rax, qword [rbp-24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _s_assignable
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L93
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S46]
    push rax
    movsxd rax, dword [rbp-40]
    push rax
    pop rdi
    call _type_name
    push rax
    lea rax, [rel S47]
    push rax
    movsxd rax, dword [rbp-32]
    push rax
    pop rdi
    call _type_name
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q2
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_fail
    movsxd rax, eax
    jmp L89
L93:
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L89
    xor eax, eax
L89:
    mov rsp, rbp
    pop rbp
    ret

; int s_binop
global _s_binop
_s_binop:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_value
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 61
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L95
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _s_assign
    movsxd rax, eax
    jmp L94
L95:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _s_expr
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-40], ecx
    movsxd rax, eax
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _s_expr
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-40]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L97
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L97
    mov eax, 0
    jmp L98
L97:
    mov eax, 1
L98:
    cmp rax, 0
    je L96
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L94
L96:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 43
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L100
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 45
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L100
    mov eax, 0
    jmp L101
L100:
    mov eax, 1
L101:
    cmp rax, 0
    je L99
    movsxd rax, dword [rbp-40]
    push rax
    pop rdi
    call _s_is_int
    movsxd rax, eax
    cmp rax, 0
    je L103
    movsxd rax, dword [rbp-48]
    push rax
    pop rdi
    call _s_is_int
    movsxd rax, eax
    cmp rax, 0
    je L103
    mov eax, 1
    jmp L104
L103:
    mov eax, 0
L104:
    cmp rax, 0
    je L102
    mov rax, qword [rbp-8]
    push rax
    mov rax, 260
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L94
L102:
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-56], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-40]
    push rax
    pop rdi
    call _s_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L106
    movsxd rax, dword [rbp-48]
    push rax
    pop rdi
    call _s_is_int
    movsxd rax, eax
    cmp rax, 0
    je L106
    mov eax, 1
    jmp L107
L106:
    mov eax, 0
L107:
    cmp rax, 0
    je L105
    movsxd rax, dword [rbp-40]
    mov rcx, rax
    mov dword [rbp-56], ecx
    movsxd rax, eax
L105:
    movsxd rax, dword [rbp-40]
    push rax
    pop rdi
    call _s_is_int
    movsxd rax, eax
    cmp rax, 0
    je L111
    movsxd rax, dword [rbp-48]
    push rax
    pop rdi
    call _s_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L111
    mov eax, 1
    jmp L112
L111:
    mov eax, 0
L112:
    cmp rax, 0
    je L109
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 43
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L109
    mov eax, 1
    jmp L110
L109:
    mov eax, 0
L110:
    cmp rax, 0
    je L108
    movsxd rax, dword [rbp-48]
    mov rcx, rax
    mov dword [rbp-56], ecx
    movsxd rax, eax
L108:
    movsxd rax, dword [rbp-56]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L113
    movsxd rax, dword [rbp-56]
    push rax
    pop rdi
    call _s_is_void_ptr
    movsxd rax, eax
    cmp rax, 0
    je L114
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S48]
    push rax
    pop rsi
    pop rdi
    call _s_fail
    movsxd rax, eax
    jmp L94
L114:
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-56]
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L94
L113:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 45
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L118
    movsxd rax, dword [rbp-40]
    push rax
    pop rdi
    call _s_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L118
    mov eax, 1
    jmp L119
L118:
    mov eax, 0
L119:
    cmp rax, 0
    je L116
    movsxd rax, dword [rbp-40]
    push rax
    movsxd rax, dword [rbp-48]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L116
    mov eax, 1
    jmp L117
L116:
    mov eax, 0
L117:
    cmp rax, 0
    je L115
    movsxd rax, dword [rbp-40]
    push rax
    pop rdi
    call _s_is_void_ptr
    movsxd rax, eax
    cmp rax, 0
    je L120
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S49]
    push rax
    pop rsi
    pop rdi
    call _s_fail
    movsxd rax, eax
    jmp L94
L120:
    mov rax, qword [rbp-8]
    push rax
    mov rax, 260
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L94
L115:
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    movsxd rax, dword [rbp-40]
    push rax
    movsxd rax, dword [rbp-48]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call _s_bad_operands
    movsxd rax, eax
    jmp L94
L99:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 42
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L122
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 47
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L122
    mov eax, 0
    jmp L123
L122:
    mov eax, 1
L123:
    cmp rax, 0
    je L121
    movsxd rax, dword [rbp-40]
    push rax
    pop rdi
    call _s_is_int
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    jne L125
    movsxd rax, dword [rbp-48]
    push rax
    pop rdi
    call _s_is_int
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    jne L125
    mov eax, 0
    jmp L126
L125:
    mov eax, 1
L126:
    cmp rax, 0
    je L124
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    movsxd rax, dword [rbp-40]
    push rax
    movsxd rax, dword [rbp-48]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call _s_bad_operands
    movsxd rax, eax
    jmp L94
L124:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 42
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L130
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _node_kind
    movsxd rax, eax
    push rax
    mov rax, 16
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L130
    mov eax, 1
    jmp L131
L130:
    mov eax, 0
L131:
    cmp rax, 0
    je L128
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _node_value
    movsxd rax, eax
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L128
    mov eax, 1
    jmp L129
L128:
    mov eax, 0
L129:
    cmp rax, 0
    je L127
    mov rax, qword [rbp-32]
    push rax
    lea rax, [rel S50]
    push rax
    pop rsi
    pop rdi
    call _s_report
L127:
    mov rax, qword [rbp-8]
    push rax
    mov rax, 260
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L94
L121:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 271
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L133
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 272
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L133
    mov eax, 0
    jmp L134
L133:
    mov eax, 1
L134:
    cmp rax, 0
    je L132
    movsxd rax, dword [rbp-40]
    push rax
    pop rdi
    call _s_is_scalar
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    jne L136
    movsxd rax, dword [rbp-48]
    push rax
    pop rdi
    call _s_is_scalar
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    jne L136
    mov eax, 0
    jmp L137
L136:
    mov eax, 1
L137:
    cmp rax, 0
    je L135
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    movsxd rax, dword [rbp-40]
    push rax
    movsxd rax, dword [rbp-48]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call _s_bad_operands
    movsxd rax, eax
    jmp L94
L135:
    mov rax, qword [rbp-8]
    push rax
    mov rax, 260
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L94
L132:
    movsxd rax, dword [rbp-40]
    push rax
    pop rdi
    call _s_is_int
    movsxd rax, eax
    cmp rax, 0
    je L139
    movsxd rax, dword [rbp-48]
    push rax
    pop rdi
    call _s_is_int
    movsxd rax, eax
    cmp rax, 0
    je L139
    mov eax, 1
    jmp L140
L139:
    mov eax, 0
L140:
    cmp rax, 0
    je L138
    mov rax, qword [rbp-8]
    push rax
    mov rax, 260
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L94
L138:
    movsxd rax, dword [rbp-40]
    push rax
    pop rdi
    call _s_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L144
    movsxd rax, dword [rbp-48]
    push rax
    pop rdi
    call _s_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L144
    mov eax, 1
    jmp L145
L144:
    mov eax, 0
L145:
    cmp rax, 0
    je L142
    movsxd rax, dword [rbp-40]
    push rax
    movsxd rax, dword [rbp-48]
    push rax
    pop rsi
    pop rdi
    call _s_ptr_compat
    movsxd rax, eax
    cmp rax, 0
    je L142
    mov eax, 1
    jmp L143
L142:
    mov eax, 0
L143:
    cmp rax, 0
    je L141
    mov rax, qword [rbp-8]
    push rax
    mov rax, 260
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L94
L141:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 267
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L147
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 268
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L147
    mov eax, 0
    jmp L148
L147:
    mov eax, 1
L148:
    cmp rax, 0
    je L146
    movsxd rax, dword [rbp-40]
    push rax
    pop rdi
    call _s_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L150
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _s_is_null
    movsxd rax, eax
    cmp rax, 0
    je L150
    mov eax, 1
    jmp L151
L150:
    mov eax, 0
L151:
    cmp rax, 0
    je L149
    mov rax, qword [rbp-8]
    push rax
    mov rax, 260
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L94
L149:
    movsxd rax, dword [rbp-48]
    push rax
    pop rdi
    call _s_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L153
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _s_is_null
    movsxd rax, eax
    cmp rax, 0
    je L153
    mov eax, 1
    jmp L154
L153:
    mov eax, 0
L154:
    cmp rax, 0
    je L152
    mov rax, qword [rbp-8]
    push rax
    mov rax, 260
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L94
L152:
L146:
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    movsxd rax, dword [rbp-40]
    push rax
    movsxd rax, dword [rbp-48]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call _s_bad_operands
    movsxd rax, eax
    jmp L94
    xor eax, eax
L94:
    mov rsp, rbp
    pop rbp
    ret

; int s_expr
global _s_expr
_s_expr:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_kind
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 16
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L157
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 17
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L157
    mov eax, 0
    jmp L158
L157:
    mov eax, 1
L158:
    cmp rax, 0
    je L156
    mov rax, qword [rbp-8]
    push rax
    mov rax, 260
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L155
L156:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 15
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L159
    mov rax, qword [rbp-8]
    push rax
    mov rax, 261
    push rax
    mov rax, 1000
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _s_set
    movsxd rax, eax
    jmp L155
L159:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 14
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L160
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _s_id
    movsxd rax, eax
    jmp L155
L160:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 13
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L161
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _s_call
    movsxd rax, eax
    jmp L155
L161:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 12
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L162
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _s_cast
    movsxd rax, eax
    jmp L155
L162:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 11
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L163
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _s_unop
    movsxd rax, eax
    jmp L155
L163:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _s_binop
    movsxd rax, eax
    jmp L155
    xor eax, eax
L155:
    mov rsp, rbp
    pop rbp
    ret

; int s_is_const
global _s_is_const
_s_is_const:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_kind
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 16
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L167
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 17
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L167
    mov eax, 0
    jmp L168
L167:
    mov eax, 1
L168:
    cmp rax, 0
    jne L165
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 15
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L165
    mov eax, 0
    jmp L166
L165:
    mov eax, 1
L166:
    jmp L164
    xor eax, eax
L164:
    mov rsp, rbp
    pop rbp
    ret

; void s_decl
global _s_decl
_s_decl:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_text
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _node_set_value
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 262
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L170
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S51]
    push rax
    mov rax, qword [rbp-32]
    push rax
    lea rax, [rel S52]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
L170:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-40], rcx
    mov rax, qword [rbp-40]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L171
    mov rax, qword [rbp-40]
    push rax
    pop rdi
    call _s_expr
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    cmp rax, 0
    je L173
    mov rax, qword [rbp-40]
    push rax
    pop rdi
    call _s_is_const
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L173
    mov eax, 1
    jmp L174
L173:
    mov eax, 0
L174:
    cmp rax, 0
    je L172
    mov rax, qword [rbp-40]
    push rax
    lea rax, [rel S53]
    push rax
    mov rax, qword [rbp-32]
    push rax
    lea rax, [rel S54]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
    jmp L175
L172:
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 262
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L177
    movsxd rax, dword [rbp-24]
    push rax
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, qword [rbp-40]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _s_assignable
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L177
    mov eax, 1
    jmp L178
L177:
    mov eax, 0
L178:
    cmp rax, 0
    je L176
    mov rax, qword [rbp-40]
    push rax
    lea rax, [rel S55]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _type_name
    push rax
    lea rax, [rel S56]
    push rax
    movsxd rax, dword [rbp-48]
    push rax
    pop rdi
    call _type_name
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q2
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
L176:
L175:
L171:
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _sym_lookup_local
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L179
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S57]
    push rax
    mov rax, qword [rbp-32]
    push rax
    lea rax, [rel S58]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
    jmp L169
L179:
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 262
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L180
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
L180:
    mov rax, qword [rbp-32]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, 1
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call _sym_declare
    xor eax, eax
L169:
    mov rsp, rbp
    pop rbp
    ret

; void s_param
global _s_param
_s_param:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_text
    mov rcx, rax
    mov qword [rbp-24], rcx
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 262
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L182
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S59]
    push rax
    mov rax, qword [rbp-24]
    push rax
    lea rax, [rel S60]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
L182:
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _sym_lookup_local
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L183
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S61]
    push rax
    mov rax, qword [rbp-24]
    push rax
    lea rax, [rel S62]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
    jmp L181
L183:
    mov rax, qword [rbp-24]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 1
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call _sym_declare
    xor eax, eax
L181:
    mov rsp, rbp
    pop rbp
    ret

; int s_same_signature
global _s_same_signature
_s_same_signature:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    sub rsp, 8
    call _node_type
    add rsp, 8
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L185
    mov rax, 0
    jmp L184
L185:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-32], rcx
L186:
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L188
    mov rax, qword [rbp-32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L188
    mov eax, 1
    jmp L189
L188:
    mov eax, 0
L189:
    cmp rax, 0
    je L187
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    sub rsp, 8
    call _node_type
    add rsp, 8
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L190
    mov rax, 0
    jmp L184
L190:
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-32], rcx
    jmp L186
L187:
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L191
    mov rax, qword [rbp-32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L191
    mov eax, 1
    jmp L192
L191:
    mov eax, 0
L192:
    jmp L184
    xor eax, eax
L184:
    mov rsp, rbp
    pop rbp
    ret

; void s_cond
global _s_cond
_s_cond:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _s_expr
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L195
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _s_is_scalar
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L195
    mov eax, 1
    jmp L196
L195:
    mov eax, 0
L196:
    cmp rax, 0
    je L194
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S63]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _type_name
    push rax
    lea rax, [rel S64]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
L194:
    xor eax, eax
L193:
    mov rsp, rbp
    pop rbp
    ret

; void s_return
global _s_return
_s_return:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-16], rcx
    mov rax, qword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L198
    movsxd rax, dword [rel _s_ret]
    push rax
    mov rax, 262
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L199
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S65]
    push rax
    movsxd rax, dword [rel _s_ret]
    push rax
    pop rdi
    call _type_name
    push rax
    lea rax, [rel S66]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
L199:
    jmp L197
L198:
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _s_expr
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    movsxd rax, dword [rel _s_ret]
    push rax
    mov rax, 262
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L200
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S67]
    push rax
    pop rsi
    pop rdi
    call _s_report
    jmp L197
L200:
    movsxd rax, dword [rel _s_ret]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _s_assignable
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L201
    mov rax, qword [rbp-16]
    push rax
    lea rax, [rel S68]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _type_name
    push rax
    lea rax, [rel S69]
    push rax
    movsxd rax, dword [rel _s_ret]
    push rax
    pop rdi
    call _type_name
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q2
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
L201:
    xor eax, eax
L197:
    mov rsp, rbp
    pop rbp
    ret

; void s_stmts
global _s_stmts
_s_stmts:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
L203:
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L204
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _s_stmt
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-8], rcx
    jmp L203
L204:
    xor eax, eax
L202:
    mov rsp, rbp
    pop rbp
    ret

; void s_sub
global _s_sub
_s_sub:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    call _st_push
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _s_stmt
    call _st_pop
    xor eax, eax
L205:
    mov rsp, rbp
    pop rbp
    ret

; void s_stmt
global _s_stmt
_s_stmt:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_kind
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 4
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L207
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    push rax
    pop rsi
    pop rdi
    call _s_decl
    jmp L208
L207:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 9
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L209
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _s_expr
    movsxd rax, eax
    jmp L210
L209:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 8
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L211
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _s_return
    jmp L212
L211:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 6
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L213
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _s_cond
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    push rax
    pop rdi
    call _s_sub
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_c
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L214
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_c
    push rax
    pop rdi
    call _s_sub
L214:
    jmp L215
L213:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 7
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L216
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _s_cond
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    push rax
    pop rdi
    call _s_sub
    jmp L217
L216:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 5
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L218
    call _st_push
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _s_stmts
    call _st_pop
L218:
L217:
L215:
L212:
L210:
L208:
    xor eax, eax
L206:
    mov rsp, rbp
    pop rbp
    ret

; void s_function
global _s_function
_s_function:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_text
    mov rcx, rax
    mov qword [rbp-16], rcx
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _sym_lookup_local
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L220
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _sym_kind
    movsxd rax, eax
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L221
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S70]
    push rax
    mov rax, qword [rbp-16]
    push rax
    lea rax, [rel S71]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
    jmp L222
L221:
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _sym_decl
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rsi
    pop rdi
    call _s_same_signature
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L223
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S72]
    push rax
    mov rax, qword [rbp-16]
    push rax
    lea rax, [rel S73]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
L223:
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L224
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _sym_defined
    movsxd rax, eax
    cmp rax, 0
    je L225
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S74]
    push rax
    mov rax, qword [rbp-16]
    push rax
    lea rax, [rel S75]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
L225:
    mov rax, qword [rbp-32]
    push rax
    mov rax, 1
    push rax
    pop rsi
    pop rdi
    call _sym_set_defined
L224:
L222:
    jmp L226
L220:
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    sub rsp, 8
    call _node_type
    add rsp, 8
    movsxd rax, eax
    push rax
    mov rax, 2
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call _sym_declare
    mov rcx, rax
    mov qword [rbp-40], rcx
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L227
    mov rax, qword [rbp-40]
    push rax
    mov rax, 1
    push rax
    pop rsi
    pop rdi
    call _sym_set_defined
L227:
L226:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _s_list_len
    movsxd rax, eax
    push rax
    mov rax, 6
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L228
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S76]
    push rax
    mov rax, qword [rbp-16]
    push rax
    lea rax, [rel S77]
    push rax
    pop rdx
    pop rsi
    pop rdi
    sub rsp, 8
    call _s_q
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _s_report
L228:
    call _st_push
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-48], rcx
L229:
    mov rax, qword [rbp-48]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L230
    mov rax, qword [rbp-48]
    push rax
    pop rdi
    call _s_param
    mov rax, qword [rbp-48]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-48], rcx
    jmp L229
L230:
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L231
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _s_ret], ecx
    movsxd rax, eax
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _s_stmts
L231:
    call _st_pop
    xor eax, eax
L219:
    mov rsp, rbp
    pop rbp
    ret

; int analyze
global _analyze
_analyze:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    call _st_reset
    mov rax, 0
    mov rcx, rax
    mov dword [rel _s_errors], ecx
    movsxd rax, eax
    mov rax, 0
    mov rcx, rax
    mov dword [rel _s_stop], ecx
    movsxd rax, eax
    mov rax, 262
    mov rcx, rax
    mov dword [rel _s_ret], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-16], rcx
L233:
    mov rax, qword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L234
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _node_kind
    movsxd rax, eax
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L235
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _s_function
    jmp L236
L235:
    mov rax, qword [rbp-16]
    push rax
    mov rax, 1
    push rax
    pop rsi
    pop rdi
    call _s_decl
L236:
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-16], rcx
    jmp L233
L234:
    movsxd rax, dword [rel _s_errors]
    jmp L232
    xor eax, eax
L232:
    mov rsp, rbp
    pop rbp
    ret

section .rodata
S0: db "demasiados errores", 0
S1: db "'", 0
S2: db "'", 0
S3: db 0
S4: db 0
S5: db " ", 0
S6: db "s", 0
S7: db "==", 0
S8: db "!=", 0
S9: db "<=", 0
S10: db ">=", 0
S11: db "&&", 0
S12: db "||", 0
S13: db "<error>", 0
S14: db "void", 0
S15: db "int", 0
S16: db "char", 0
S17: db "*", 0
S18: db "identificador ", 0
S19: db " no declarado", 0
S20: db 0
S21: db " es una funcion, no una variable", 0
S22: db "funcion ", 0
S23: db " no declarada", 0
S24: db 0
S25: db " no es una funcion", 0
S26: db "argumento ", 0
S27: db " de ", 0
S28: db "'", 0
S29: db "': no se puede convertir ", 0
S30: db " a ", 0
S31: db "la funcion ", 0
S32: db " espera ", 0
S33: db "argumento", 0
S34: db " y recibe ", 0
S35: db "argumento", 0
S36: db "no se puede convertir ", 0
S37: db " a ", 0
S38: db "no se puede desreferenciar ", 0
S39: db 0
S40: db "operando invalido para '!': ", 0
S41: db 0
S42: db "operandos invalidos para ", 0
S43: db ": ", 0
S44: db 0
S45: db " y ", 0
S46: db "no se puede asignar ", 0
S47: db " a ", 0
S48: db "aritmetica sobre 'void*' no permitida", 0
S49: db "aritmetica sobre 'void*' no permitida", 0
S50: db "division entre cero", 0
S51: db "la variable ", 0
S52: db " no puede ser de tipo void", 0
S53: db "el inicializador de ", 0
S54: db " debe ser una constante", 0
S55: db "no se puede inicializar ", 0
S56: db " con ", 0
S57: db 0
S58: db " ya esta declarado en este ambito", 0
S59: db "el parametro ", 0
S60: db " no puede ser de tipo void", 0
S61: db 0
S62: db " ya esta declarado en este ambito", 0
S63: db "la condicion debe ser escalar, no ", 0
S64: db 0
S65: db "se esperaba un valor de retorno de tipo ", 0
S66: db 0
S67: db "una funcion void no puede retornar un valor", 0
S68: db "no se puede retornar ", 0
S69: db " en una funcion que retorna ", 0
S70: db 0
S71: db " ya esta declarado en este ambito", 0
S72: db "declaracion de ", 0
S73: db " en conflicto con la anterior", 0
S74: db "la funcion ", 0
S75: db " ya esta definida", 0
S76: db "la funcion ", 0
S77: db " no puede tener mas de 6 parametros", 0

section .data
_s_errors: dd 0
_s_stop: dd 0
_s_ret: dd 0
