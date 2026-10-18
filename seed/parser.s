; generado por tcc: NASM, sintaxis Intel, x86-64 Linux
extern _lexer_init
extern _token_kind
extern _token_text
extern _token_value
extern _token_line
extern _token_col
extern _next_char
extern _advance
extern _skip_spaces
extern _read_identifier
extern _read_number
extern _read_string
extern _read_char_literal
extern _make_token
extern _next_token
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

section .text

; int p_kind
global _p_kind
_p_kind:
    push rbp
    mov rbp, rsp
    movsxd rax, dword [rel _p_stop]
    cmp rax, 0
    je L2
    mov rax, 256
    jmp L1
L2:
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    call _token_kind
    movsxd rax, eax
    jmp L1
    xor eax, eax
L1:
    mov rsp, rbp
    pop rbp
    ret

; char* p_token_name
global _p_token_name
_p_token_name:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 256
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L4
    lea rax, [rel S0]
    jmp L3
L4:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 257
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L5
    lea rax, [rel S1]
    jmp L3
L5:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 258
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L6
    lea rax, [rel S2]
    jmp L3
L6:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 259
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L7
    lea rax, [rel S3]
    jmp L3
L7:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 273
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L8
    lea rax, [rel S4]
    jmp L3
L8:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 260
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L9
    lea rax, [rel S5]
    jmp L3
L9:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 261
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L10
    lea rax, [rel S6]
    jmp L3
L10:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 262
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L11
    lea rax, [rel S7]
    jmp L3
L11:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 263
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L12
    lea rax, [rel S8]
    jmp L3
L12:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 264
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L13
    lea rax, [rel S9]
    jmp L3
L13:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 265
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L14
    lea rax, [rel S10]
    jmp L3
L14:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 266
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L15
    lea rax, [rel S11]
    jmp L3
L15:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 267
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L16
    lea rax, [rel S12]
    jmp L3
L16:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 268
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L17
    lea rax, [rel S13]
    jmp L3
L17:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 269
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L18
    lea rax, [rel S14]
    jmp L3
L18:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 270
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L19
    lea rax, [rel S15]
    jmp L3
L19:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 271
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L20
    lea rax, [rel S16]
    jmp L3
L20:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 272
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L21
    lea rax, [rel S17]
    jmp L3
L21:
    mov rax, 4
    push rax
    pop rdi
    call _alloc
    mov rcx, rax
    mov qword [rbp-16], rcx
    mov rax, 39
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
    movsxd rax, dword [rbp-8]
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
    mov rax, 39
    push rax
    mov rax, qword [rbp-16]
    push rax
    mov rax, 2
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
    mov rax, 3
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
    mov rax, qword [rbp-16]
    jmp L3
    xor eax, eax
L3:
    mov rsp, rbp
    pop rbp
    ret

; char* p_found
global _p_found
_p_found:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    call _p_kind
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 257
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L23
    lea rax, [rel S18]
    push rax
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    sub rsp, 8
    call _token_text
    add rsp, 8
    push rax
    lea rax, [rel S19]
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
    jmp L22
L23:
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _p_token_name
    jmp L22
    xor eax, eax
L22:
    mov rsp, rbp
    pop rbp
    ret

; void p_report
global _p_report
_p_report:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, qword [rbp-24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _report_error
    movsxd rax, dword [rel _p_errors]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _p_errors], ecx
    movsxd rax, eax
    movsxd rax, dword [rel _p_count]
    mov rcx, rax
    mov dword [rel _p_last_err], ecx
    movsxd rax, eax
    movsxd rax, dword [rel _p_errors]
    push rax
    mov rax, 20
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setge al
    movzx eax, al
    cmp rax, 0
    je L25
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    lea rax, [rel S20]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _report_error
    mov rax, 1
    mov rcx, rax
    mov dword [rel _p_stop], ecx
    movsxd rax, eax
L25:
    xor eax, eax
L24:
    mov rsp, rbp
    pop rbp
    ret

; void p_error
global _p_error
_p_error:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rel _p_stop]
    cmp rax, 0
    je L27
    jmp L26
L27:
    movsxd rax, dword [rel _p_count]
    push rax
    movsxd rax, dword [rel _p_last_err]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L28
    jmp L26
L28:
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    call _token_line
    movsxd rax, eax
    push rax
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    sub rsp, 8
    call _token_col
    add rsp, 8
    movsxd rax, eax
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _p_report
    xor eax, eax
L26:
    mov rsp, rbp
    pop rbp
    ret

; void p_expected
global _p_expected
_p_expected:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    lea rax, [rel S21]
    push rax
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S22]
    push rax
    sub rsp, 8
    call _p_found
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
    push rax
    pop rdi
    call _p_error
    xor eax, eax
L29:
    mov rsp, rbp
    pop rbp
    ret

; void* p_fetch
global _p_fetch
_p_fetch:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    call _next_token
    mov rcx, rax
    mov qword [rbp-8], rcx
L31:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _token_kind
    movsxd rax, eax
    push rax
    mov rax, 274
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L32
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _token_line
    movsxd rax, eax
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    sub rsp, 8
    call _token_col
    add rsp, 8
    movsxd rax, eax
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _token_text
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _p_report
    call _next_token
    mov rcx, rax
    mov qword [rbp-8], rcx
    jmp L31
L32:
    mov rax, qword [rbp-8]
    jmp L30
    xor eax, eax
L30:
    mov rsp, rbp
    pop rbp
    ret

; void p_next
global _p_next
_p_next:
    push rbp
    mov rbp, rsp
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 256
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L34
    jmp L33
L34:
    movsxd rax, dword [rel _p_count]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _p_count], ecx
    movsxd rax, eax
    call _p_fetch
    mov rcx, rax
    mov qword [rel _p_cur], rcx
    xor eax, eax
L33:
    mov rsp, rbp
    pop rbp
    ret

; int p_expect
global _p_expect
_p_expect:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    call _p_kind
    movsxd rax, eax
    push rax
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L36
    call _p_next
    mov rax, 1
    jmp L35
L36:
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _p_token_name
    push rax
    pop rdi
    call _p_expected
    mov rax, 0
    jmp L35
    xor eax, eax
L35:
    mov rsp, rbp
    pop rbp
    ret

; void* p_node
global _p_node
_p_node:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    sub rsp, 8
    call _token_line
    add rsp, 8
    movsxd rax, eax
    push rax
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    call _token_col
    movsxd rax, eax
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _node_new
    jmp L37
    xor eax, eax
L37:
    mov rsp, rbp
    pop rbp
    ret

; int p_is_type
global _p_is_type
_p_is_type:
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
    jne L41
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 261
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L41
    mov eax, 0
    jmp L42
L41:
    mov eax, 1
L42:
    cmp rax, 0
    jne L39
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 262
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L39
    mov eax, 0
    jmp L40
L39:
    mov eax, 1
L40:
    jmp L38
    xor eax, eax
L38:
    mov rsp, rbp
    pop rbp
    ret

; int p_stars
global _p_stars
_p_stars:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
L44:
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 42
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L45
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 1000
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    call _p_next
    jmp L44
L45:
    movsxd rax, dword [rbp-16]
    jmp L43
    xor eax, eax
L43:
    mov rsp, rbp
    pop rbp
    ret

; int p_type
global _p_type
_p_type:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    call _p_kind
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    call _p_next
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _p_stars
    movsxd rax, eax
    jmp L46
    xor eax, eax
L46:
    mov rsp, rbp
    pop rbp
    ret

; void* p_primary
global _p_primary
_p_primary:
    push rbp
    mov rbp, rsp
    sub rsp, 112
    call _p_kind
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    call _token_line
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    call _token_col
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 258
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L48
    mov rax, 16
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _node_new
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-32]
    push rax
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    sub rsp, 8
    call _token_value
    add rsp, 8
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _node_set_value
    call _p_next
    mov rax, qword [rbp-32]
    jmp L47
L48:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 273
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L49
    mov rax, 17
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _node_new
    mov rcx, rax
    mov qword [rbp-40], rcx
    mov rax, qword [rbp-40]
    push rax
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    sub rsp, 8
    call _token_value
    add rsp, 8
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _node_set_value
    call _p_next
    mov rax, qword [rbp-40]
    jmp L47
L49:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 259
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L50
    mov rax, 15
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _node_new
    mov rcx, rax
    mov qword [rbp-48], rcx
    mov rax, qword [rbp-48]
    push rax
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    sub rsp, 8
    call _token_text
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _node_set_text
    call _p_next
    mov rax, qword [rbp-48]
    jmp L47
L50:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 257
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L51
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    call _token_text
    mov rcx, rax
    mov qword [rbp-56], rcx
    call _p_next
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 40
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L52
    mov rax, 14
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _node_new
    mov rcx, rax
    mov qword [rbp-64], rcx
    mov rax, qword [rbp-64]
    push rax
    mov rax, qword [rbp-56]
    push rax
    pop rsi
    pop rdi
    call _node_set_text
    mov rax, qword [rbp-64]
    jmp L47
L52:
    mov rax, 13
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _node_new
    mov rcx, rax
    mov qword [rbp-72], rcx
    mov rax, qword [rbp-72]
    push rax
    mov rax, qword [rbp-56]
    push rax
    pop rsi
    pop rdi
    call _node_set_text
    call _p_next
    mov rax, 0
    mov rcx, rax
    mov qword [rbp-80], rcx
    mov rax, 0
    mov rcx, rax
    mov qword [rbp-88], rcx
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 41
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L53
    mov rax, 1
    mov rcx, rax
    mov dword [rbp-96], ecx
    movsxd rax, eax
L54:
    movsxd rax, dword [rbp-96]
    cmp rax, 0
    je L55
    call _p_expression
    mov rcx, rax
    mov qword [rbp-104], rcx
    mov rax, qword [rbp-104]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L56
    mov rax, 0
    jmp L47
L56:
    mov rax, qword [rbp-80]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L57
    mov rax, qword [rbp-104]
    mov rcx, rax
    mov qword [rbp-80], rcx
    jmp L58
L57:
    mov rax, qword [rbp-88]
    push rax
    mov rax, qword [rbp-104]
    push rax
    pop rsi
    pop rdi
    call _node_set_next
L58:
    mov rax, qword [rbp-104]
    mov rcx, rax
    mov qword [rbp-88], rcx
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 44
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L59
    call _p_next
    jmp L60
L59:
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-96], ecx
    movsxd rax, eax
L60:
    jmp L54
L55:
L53:
    mov rax, 41
    push rax
    pop rdi
    call _p_expect
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L61
    mov rax, 0
    jmp L47
L61:
    mov rax, qword [rbp-72]
    push rax
    mov rax, qword [rbp-80]
    push rax
    pop rsi
    pop rdi
    call _node_set_a
    mov rax, qword [rbp-72]
    jmp L47
L51:
    lea rax, [rel S23]
    push rax
    sub rsp, 8
    call _p_found
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _str_cat
    push rax
    pop rdi
    call _p_error
    mov rax, 0
    jmp L47
    xor eax, eax
L47:
    mov rsp, rbp
    pop rbp
    ret

; void* p_unary
global _p_unary
_p_unary:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    call _p_kind
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 33
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L64
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 42
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L64
    mov eax, 0
    jmp L65
L64:
    mov eax, 1
L65:
    cmp rax, 0
    je L63
    mov rax, 11
    push rax
    pop rdi
    call _p_node
    mov rcx, rax
    mov qword [rbp-16], rcx
    mov rax, qword [rbp-16]
    push rax
    movsxd rax, dword [rbp-8]
    push rax
    pop rsi
    pop rdi
    call _node_set_value
    call _p_next
    call _p_unary
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L66
    mov rax, 0
    jmp L62
L66:
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-24]
    push rax
    pop rsi
    pop rdi
    call _node_set_a
    mov rax, qword [rbp-16]
    jmp L62
L63:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 40
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L67
    mov rax, 12
    push rax
    pop rdi
    call _p_node
    mov rcx, rax
    mov qword [rbp-32], rcx
    call _p_next
    call _p_kind
    movsxd rax, eax
    push rax
    pop rdi
    call _p_is_type
    movsxd rax, eax
    cmp rax, 0
    je L68
    mov rax, qword [rbp-32]
    push rax
    sub rsp, 8
    call _p_type
    add rsp, 8
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _node_set_type
    mov rax, 41
    push rax
    pop rdi
    call _p_expect
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L69
    mov rax, 0
    jmp L62
L69:
    call _p_unary
    mov rcx, rax
    mov qword [rbp-40], rcx
    mov rax, qword [rbp-40]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L70
    mov rax, 0
    jmp L62
L70:
    mov rax, qword [rbp-32]
    push rax
    mov rax, qword [rbp-40]
    push rax
    pop rsi
    pop rdi
    call _node_set_a
    mov rax, qword [rbp-32]
    jmp L62
L68:
    call _p_expression
    mov rcx, rax
    mov qword [rbp-48], rcx
    mov rax, qword [rbp-48]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L71
    mov rax, 0
    jmp L62
L71:
    mov rax, 41
    push rax
    pop rdi
    call _p_expect
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L72
    mov rax, 0
    jmp L62
L72:
    mov rax, qword [rbp-48]
    jmp L62
L67:
    call _p_primary
    jmp L62
    xor eax, eax
L62:
    mov rsp, rbp
    pop rbp
    ret

; int p_level_op
global _p_level_op
_p_level_op:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L74
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 272
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    jmp L73
L74:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L75
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 271
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    jmp L73
L75:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L76
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 267
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L77
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 268
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L77
    mov eax, 0
    jmp L78
L77:
    mov eax, 1
L78:
    jmp L73
L76:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 3
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L79
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 60
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L84
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 62
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L84
    mov eax, 0
    jmp L85
L84:
    mov eax, 1
L85:
    cmp rax, 0
    jne L82
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 269
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L82
    mov eax, 0
    jmp L83
L82:
    mov eax, 1
L83:
    cmp rax, 0
    jne L80
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 270
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L80
    mov eax, 0
    jmp L81
L80:
    mov eax, 1
L81:
    jmp L73
L79:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 4
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L86
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 43
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L87
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 45
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L87
    mov eax, 0
    jmp L88
L87:
    mov eax, 1
L88:
    jmp L73
L86:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 42
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L89
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 47
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L89
    mov eax, 0
    jmp L90
L89:
    mov eax, 1
L90:
    jmp L73
    xor eax, eax
L73:
    mov rsp, rbp
    pop rbp
    ret

; void* p_binary
global _p_binary
_p_binary:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 6
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L92
    call _p_unary
    jmp L91
L92:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    push rax
    pop rdi
    call _p_binary
    mov rcx, rax
    mov qword [rbp-16], rcx
L93:
    mov rax, qword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L95
    movsxd rax, dword [rbp-8]
    push rax
    sub rsp, 8
    call _p_kind
    add rsp, 8
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _p_level_op
    movsxd rax, eax
    cmp rax, 0
    je L95
    mov eax, 1
    jmp L96
L95:
    mov eax, 0
L96:
    cmp rax, 0
    je L94
    mov rax, 10
    push rax
    pop rdi
    call _p_node
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, qword [rbp-24]
    push rax
    sub rsp, 8
    call _p_kind
    add rsp, 8
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _node_set_value
    call _p_next
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    push rax
    pop rdi
    call _p_binary
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L97
    mov rax, 0
    jmp L91
L97:
    mov rax, qword [rbp-24]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _node_set_a
    mov rax, qword [rbp-24]
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _node_set_b
    mov rax, qword [rbp-24]
    mov rcx, rax
    mov qword [rbp-16], rcx
    jmp L93
L94:
    mov rax, qword [rbp-16]
    jmp L91
    xor eax, eax
L91:
    mov rsp, rbp
    pop rbp
    ret

; void* p_expression
global _p_expression
_p_expression:
    push rbp
    mov rbp, rsp
    mov rax, 0
    push rax
    pop rdi
    call _p_binary
    jmp L98
    xor eax, eax
L98:
    mov rsp, rbp
    pop rbp
    ret

; int p_is_lvalue
global _p_is_lvalue
_p_is_lvalue:
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
    mov rax, 14
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L100
    mov rax, 1
    jmp L99
L100:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_kind
    movsxd rax, eax
    push rax
    mov rax, 11
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L101
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_value
    movsxd rax, eax
    push rax
    mov rax, 42
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L101
    mov eax, 1
    jmp L102
L101:
    mov eax, 0
L102:
    jmp L99
    xor eax, eax
L99:
    mov rsp, rbp
    pop rbp
    ret

; void* p_decl_rest
global _p_decl_rest
_p_decl_rest:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    mov [rbp-32], rcx
    mov rax, 4
    push rax
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _node_new
    mov rcx, rax
    mov qword [rbp-40], rcx
    mov rax, qword [rbp-40]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rsi
    pop rdi
    call _node_set_type
    mov rax, qword [rbp-40]
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _node_set_text
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 61
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L104
    call _p_next
    call _p_expression
    mov rcx, rax
    mov qword [rbp-48], rcx
    mov rax, qword [rbp-48]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L105
    mov rax, 0
    jmp L103
L105:
    mov rax, qword [rbp-40]
    push rax
    mov rax, qword [rbp-48]
    push rax
    pop rsi
    pop rdi
    call _node_set_a
L104:
    mov rax, 59
    push rax
    pop rdi
    call _p_expect
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L106
    mov rax, 0
    jmp L103
L106:
    mov rax, qword [rbp-40]
    jmp L103
    xor eax, eax
L103:
    mov rsp, rbp
    pop rbp
    ret

; void* p_local_decl
global _p_local_decl
_p_local_decl:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    call _token_line
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    call _token_col
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    call _p_type
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 257
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L108
    lea rax, [rel S24]
    push rax
    pop rdi
    call _p_expected
    mov rax, 0
    jmp L107
L108:
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    call _token_text
    mov rcx, rax
    mov qword [rbp-32], rcx
    call _p_next
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call _p_decl_rest
    jmp L107
    xor eax, eax
L107:
    mov rsp, rbp
    pop rbp
    ret

; void p_sync_stmt
global _p_sync_stmt
_p_sync_stmt:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
L110:
    movsxd rax, dword [rbp-8]
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L111
    call _p_kind
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 256
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L113
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 125
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L113
    mov eax, 0
    jmp L114
L113:
    mov eax, 1
L114:
    cmp rax, 0
    je L112
    mov rax, 1
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    jmp L115
L112:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 59
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L116
    call _p_next
    mov rax, 1
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    jmp L117
L116:
    call _p_next
L117:
L115:
    jmp L110
L111:
    xor eax, eax
L109:
    mov rsp, rbp
    pop rbp
    ret

; void* p_block
global _p_block
_p_block:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov rax, 5
    push rax
    pop rdi
    call _p_node
    mov rcx, rax
    mov qword [rbp-8], rcx
    call _p_next
    mov rax, 0
    mov rcx, rax
    mov qword [rbp-16], rcx
    mov rax, 0
    mov rcx, rax
    mov qword [rbp-24], rcx
L119:
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 125
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L121
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 256
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L121
    mov eax, 1
    jmp L122
L121:
    mov eax, 0
L122:
    cmp rax, 0
    je L120
    call _p_statement
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L123
    call _p_sync_stmt
    jmp L124
L123:
    mov rax, qword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L125
    mov rax, qword [rbp-32]
    mov rcx, rax
    mov qword [rbp-16], rcx
    jmp L126
L125:
    mov rax, qword [rbp-24]
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _node_set_next
L126:
    mov rax, qword [rbp-32]
    mov rcx, rax
    mov qword [rbp-24], rcx
L124:
    jmp L119
L120:
    mov rax, 125
    push rax
    pop rdi
    call _p_expect
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _node_set_a
    mov rax, qword [rbp-8]
    jmp L118
    xor eax, eax
L118:
    mov rsp, rbp
    pop rbp
    ret

; void* p_expr_stmt
global _p_expr_stmt
_p_expr_stmt:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov rax, 9
    push rax
    pop rdi
    call _p_node
    mov rcx, rax
    mov qword [rbp-8], rcx
    call _p_expression
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
    je L128
    mov rax, 0
    jmp L127
L128:
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 61
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L129
    mov rax, 10
    push rax
    pop rdi
    call _p_node
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, qword [rbp-24]
    push rax
    mov rax, 61
    push rax
    pop rsi
    pop rdi
    call _node_set_value
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _p_is_lvalue
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L130
    lea rax, [rel S25]
    push rax
    pop rdi
    call _p_error
L130:
    call _p_next
    call _p_expression
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L131
    mov rax, 0
    jmp L127
L131:
    mov rax, qword [rbp-24]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _node_set_a
    mov rax, qword [rbp-24]
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _node_set_b
    mov rax, qword [rbp-24]
    mov rcx, rax
    mov qword [rbp-16], rcx
L129:
    mov rax, 59
    push rax
    pop rdi
    call _p_expect
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L132
    mov rax, 0
    jmp L127
L132:
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _node_set_a
    mov rax, qword [rbp-8]
    jmp L127
    xor eax, eax
L127:
    mov rsp, rbp
    pop rbp
    ret

; void* p_return
global _p_return
_p_return:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov rax, 8
    push rax
    pop rdi
    call _p_node
    mov rcx, rax
    mov qword [rbp-8], rcx
    call _p_next
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 59
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L134
    call _p_expression
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
    je L135
    mov rax, 0
    jmp L133
L135:
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _node_set_a
L134:
    mov rax, 59
    push rax
    pop rdi
    call _p_expect
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L136
    mov rax, 0
    jmp L133
L136:
    mov rax, qword [rbp-8]
    jmp L133
    xor eax, eax
L133:
    mov rsp, rbp
    pop rbp
    ret

; void* p_condition
global _p_condition
_p_condition:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    call _p_next
    mov rax, 40
    push rax
    pop rdi
    call _p_expect
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L138
    mov rax, 0
    jmp L137
L138:
    call _p_expression
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
    je L139
    mov rax, 0
    jmp L137
L139:
    mov rax, 41
    push rax
    pop rdi
    call _p_expect
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L140
    mov rax, 0
    jmp L137
L140:
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _node_set_a
    mov rax, qword [rbp-8]
    jmp L137
    xor eax, eax
L137:
    mov rsp, rbp
    pop rbp
    ret

; void* p_simple
global _p_simple
_p_simple:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    call _p_kind
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 263
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L142
    call _p_return
    jmp L141
L142:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 264
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L143
    mov rax, 6
    push rax
    pop rdi
    call _p_node
    push rax
    pop rdi
    call _p_condition
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
    je L144
    mov rax, 0
    jmp L141
L144:
    call _p_body
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L145
    mov rax, 0
    jmp L141
L145:
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-24]
    push rax
    pop rsi
    pop rdi
    call _node_set_b
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 265
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L146
    call _p_next
    call _p_body
    mov rcx, rax
    mov qword [rbp-32], rcx
    mov rax, qword [rbp-32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L147
    mov rax, 0
    jmp L141
L147:
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _node_set_c
L146:
    mov rax, qword [rbp-16]
    jmp L141
L143:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 266
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L148
    mov rax, 7
    push rax
    pop rdi
    call _p_node
    push rax
    pop rdi
    call _p_condition
    mov rcx, rax
    mov qword [rbp-40], rcx
    mov rax, qword [rbp-40]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L149
    mov rax, 0
    jmp L141
L149:
    call _p_body
    mov rcx, rax
    mov qword [rbp-48], rcx
    mov rax, qword [rbp-48]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L150
    mov rax, 0
    jmp L141
L150:
    mov rax, qword [rbp-40]
    push rax
    mov rax, qword [rbp-48]
    push rax
    pop rsi
    pop rdi
    call _node_set_b
    mov rax, qword [rbp-40]
    jmp L141
L148:
    call _p_expr_stmt
    jmp L141
    xor eax, eax
L141:
    mov rsp, rbp
    pop rbp
    ret

; void* p_body
global _p_body
_p_body:
    push rbp
    mov rbp, rsp
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 123
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L152
    call _p_block
    jmp L151
L152:
    call _p_simple
    jmp L151
    xor eax, eax
L151:
    mov rsp, rbp
    pop rbp
    ret

; void* p_statement
global _p_statement
_p_statement:
    push rbp
    mov rbp, rsp
    call _p_kind
    movsxd rax, eax
    push rax
    pop rdi
    call _p_is_type
    movsxd rax, eax
    cmp rax, 0
    je L154
    call _p_local_decl
    jmp L153
L154:
    call _p_simple
    jmp L153
    xor eax, eax
L153:
    mov rsp, rbp
    pop rbp
    ret

; void* p_params
global _p_params
_p_params:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov rax, 0
    mov rcx, rax
    mov qword [rbp-8], rcx
    mov rax, 0
    mov rcx, rax
    mov qword [rbp-16], rcx
    mov rax, 1
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
L156:
    movsxd rax, dword [rbp-24]
    cmp rax, 0
    je L157
    call _p_kind
    movsxd rax, eax
    push rax
    pop rdi
    call _p_is_type
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L158
    lea rax, [rel S26]
    push rax
    pop rdi
    call _p_expected
    mov rax, qword [rbp-8]
    jmp L155
L158:
    mov rax, 3
    push rax
    pop rdi
    call _p_node
    mov rcx, rax
    mov qword [rbp-32], rcx
    call _p_kind
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-40], ecx
    movsxd rax, eax
    call _p_next
    mov rax, qword [rbp-32]
    push rax
    movsxd rax, dword [rbp-40]
    push rax
    pop rdi
    sub rsp, 8
    call _p_stars
    add rsp, 8
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _node_set_type
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L159
    mov rax, qword [rbp-32]
    mov rcx, rax
    mov qword [rbp-8], rcx
    jmp L160
L159:
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _node_set_next
L160:
    mov rax, qword [rbp-32]
    mov rcx, rax
    mov qword [rbp-16], rcx
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 257
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L161
    lea rax, [rel S27]
    push rax
    pop rdi
    call _p_expected
    mov rax, qword [rbp-8]
    jmp L155
L161:
    mov rax, qword [rbp-32]
    push rax
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    sub rsp, 8
    call _token_text
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _node_set_text
    call _p_next
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 44
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L162
    call _p_next
    jmp L163
L162:
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
L163:
    jmp L156
L157:
    mov rax, qword [rbp-8]
    jmp L155
    xor eax, eax
L155:
    mov rsp, rbp
    pop rbp
    ret

; void* p_function
global _p_function
_p_function:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    mov [rbp-32], rcx
    mov rax, 2
    push rax
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _node_new
    mov rcx, rax
    mov qword [rbp-40], rcx
    mov rax, qword [rbp-40]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rsi
    pop rdi
    call _node_set_type
    mov rax, qword [rbp-40]
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _node_set_text
    call _p_next
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 41
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L165
    mov rax, qword [rbp-40]
    push rax
    sub rsp, 8
    call _p_params
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _node_set_a
L165:
    mov rax, 41
    push rax
    pop rdi
    call _p_expect
    movsxd rax, eax
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 59
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L166
    call _p_next
    mov rax, qword [rbp-40]
    jmp L164
L166:
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 123
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L167
    mov rax, qword [rbp-40]
    push rax
    sub rsp, 8
    call _p_block
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _node_set_b
    mov rax, qword [rbp-40]
    jmp L164
L167:
    lea rax, [rel S28]
    push rax
    pop rdi
    call _p_expected
    mov rax, qword [rbp-40]
    jmp L164
    xor eax, eax
L164:
    mov rsp, rbp
    pop rbp
    ret

; void* p_external
global _p_external
_p_external:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    call _token_line
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    call _token_col
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    call _p_type
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 257
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L169
    lea rax, [rel S29]
    push rax
    pop rdi
    call _p_expected
    mov rax, 0
    jmp L168
L169:
    mov rax, qword [rel _p_cur]
    push rax
    pop rdi
    call _token_text
    mov rcx, rax
    mov qword [rbp-32], rcx
    call _p_next
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 40
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L170
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call _p_function
    jmp L168
L170:
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, qword [rbp-32]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call _p_decl_rest
    jmp L168
    xor eax, eax
L168:
    mov rsp, rbp
    pop rbp
    ret

; void p_sync_top
global _p_sync_top
_p_sync_top:
    push rbp
    mov rbp, rsp
L172:
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 256
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L174
    call _p_kind
    movsxd rax, eax
    push rax
    pop rdi
    call _p_is_type
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L174
    mov eax, 1
    jmp L175
L174:
    mov eax, 0
L175:
    cmp rax, 0
    je L173
    call _p_next
    jmp L172
L173:
    xor eax, eax
L171:
    mov rsp, rbp
    pop rbp
    ret

; void* parse
global _parse
_parse:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _lexer_init
    call _error_log_reset
    mov rax, 0
    mov rcx, rax
    mov dword [rel _p_count], ecx
    movsxd rax, eax
    mov rax, 0
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _p_last_err], ecx
    movsxd rax, eax
    mov rax, 0
    mov rcx, rax
    mov dword [rel _p_errors], ecx
    movsxd rax, eax
    mov rax, 0
    mov rcx, rax
    mov dword [rel _p_stop], ecx
    movsxd rax, eax
    call _p_fetch
    mov rcx, rax
    mov qword [rel _p_cur], rcx
    mov rax, 1
    push rax
    mov rax, 1
    push rax
    mov rax, 1
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _node_new
    mov rcx, rax
    mov qword [rbp-16], rcx
    mov rax, 0
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, 0
    mov rcx, rax
    mov qword [rbp-32], rcx
L177:
    call _p_kind
    movsxd rax, eax
    push rax
    mov rax, 256
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L178
    call _p_kind
    movsxd rax, eax
    push rax
    pop rdi
    call _p_is_type
    movsxd rax, eax
    cmp rax, 0
    je L179
    call _p_external
    mov rcx, rax
    mov qword [rbp-40], rcx
    mov rax, qword [rbp-40]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L180
    call _p_sync_top
    jmp L181
L180:
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L182
    mov rax, qword [rbp-40]
    mov rcx, rax
    mov qword [rbp-24], rcx
    jmp L183
L182:
    mov rax, qword [rbp-32]
    push rax
    mov rax, qword [rbp-40]
    push rax
    pop rsi
    pop rdi
    call _node_set_next
L183:
    mov rax, qword [rbp-40]
    mov rcx, rax
    mov qword [rbp-32], rcx
L181:
    jmp L184
L179:
    lea rax, [rel S30]
    push rax
    sub rsp, 8
    call _p_found
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _str_cat
    push rax
    pop rdi
    call _p_error
    call _p_next
    call _p_sync_top
L184:
    jmp L177
L178:
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-24]
    push rax
    pop rsi
    pop rdi
    call _node_set_a
    mov rax, qword [rbp-16]
    jmp L176
    xor eax, eax
L176:
    mov rsp, rbp
    pop rbp
    ret

; int parse_error_count
global _parse_error_count
_parse_error_count:
    push rbp
    mov rbp, rsp
    movsxd rax, dword [rel _p_errors]
    jmp L185
    xor eax, eax
L185:
    mov rsp, rbp
    pop rbp
    ret

section .rodata
S0: db "fin de archivo", 0
S1: db "identificador", 0
S2: db "numero", 0
S3: db "cadena", 0
S4: db "caracter", 0
S5: db "'int'", 0
S6: db "'char'", 0
S7: db "'void'", 0
S8: db "'return'", 0
S9: db "'if'", 0
S10: db "'else'", 0
S11: db "'while'", 0
S12: db "'=='", 0
S13: db "'!='", 0
S14: db "'<='", 0
S15: db "'>='", 0
S16: db "'&&'", 0
S17: db "'||'", 0
S18: db "identificador '", 0
S19: db "'", 0
S20: db "demasiados errores", 0
S21: db "se esperaba ", 0
S22: db " y se encontro ", 0
S23: db "se esperaba una expresion y se encontro ", 0
S24: db "un identificador", 0
S25: db "el lado izquierdo de '=' no es asignable", 0
S26: db "un tipo", 0
S27: db "un identificador", 0
S28: db "'{' o ';'", 0
S29: db "un identificador", 0
S30: db "se esperaba una declaracion o funcion y se encontro ", 0

section .data
_p_cur: dq 0
_p_count: dd 0
_p_last_err: dd 0
_p_errors: dd 0
_p_stop: dd 0
