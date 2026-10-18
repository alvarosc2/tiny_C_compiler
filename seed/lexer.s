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

; int is_alpha
global _is_alpha
_is_alpha:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 97
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setge al
    movzx eax, al
    cmp rax, 0
    je L4
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 122
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setle al
    movzx eax, al
    cmp rax, 0
    je L4
    mov eax, 1
    jmp L5
L4:
    mov eax, 0
L5:
    cmp rax, 0
    jne L2
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 65
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setge al
    movzx eax, al
    cmp rax, 0
    je L6
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 90
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setle al
    movzx eax, al
    cmp rax, 0
    je L6
    mov eax, 1
    jmp L7
L6:
    mov eax, 0
L7:
    cmp rax, 0
    jne L2
    mov eax, 0
    jmp L3
L2:
    mov eax, 1
L3:
    jmp L1
    xor eax, eax
L1:
    mov rsp, rbp
    pop rbp
    ret

; int is_digit
global _is_digit
_is_digit:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 48
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setge al
    movzx eax, al
    cmp rax, 0
    je L9
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 57
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setle al
    movzx eax, al
    cmp rax, 0
    je L9
    mov eax, 1
    jmp L10
L9:
    mov eax, 0
L10:
    jmp L8
    xor eax, eax
L8:
    mov rsp, rbp
    pop rbp
    ret

; void lexer_init
global _lexer_init
_lexer_init:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    mov rcx, rax
    mov qword [rel _src], rcx
    mov rax, 0
    mov rcx, rax
    mov dword [rel _pos], ecx
    movsxd rax, eax
    mov rax, 1
    mov rcx, rax
    mov dword [rel _line], ecx
    movsxd rax, eax
    mov rax, 1
    mov rcx, rax
    mov dword [rel _col], ecx
    movsxd rax, eax
    mov rax, 1
    mov rcx, rax
    mov dword [rel _tok_line], ecx
    movsxd rax, eax
    mov rax, 1
    mov rcx, rax
    mov dword [rel _tok_col], ecx
    movsxd rax, eax
    xor eax, eax
L11:
    mov rsp, rbp
    pop rbp
    ret

; int next_char
global _next_char
_next_char:
    push rbp
    mov rbp, rsp
    mov rax, qword [rel _src]
    push rax
    movsxd rax, dword [rel _pos]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    jmp L12
    xor eax, eax
L12:
    mov rsp, rbp
    pop rbp
    ret

; int advance
global _advance
_advance:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov rax, qword [rel _src]
    push rax
    movsxd rax, dword [rel _pos]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L14
    mov rax, 0
    jmp L13
L14:
    movsxd rax, dword [rel _pos]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _pos], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L15
    movsxd rax, dword [rel _line]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _line], ecx
    movsxd rax, eax
    mov rax, 1
    mov rcx, rax
    mov dword [rel _col], ecx
    movsxd rax, eax
    jmp L16
L15:
    movsxd rax, dword [rel _col]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _col], ecx
    movsxd rax, eax
L16:
    movsxd rax, dword [rbp-8]
    jmp L13
    xor eax, eax
L13:
    mov rsp, rbp
    pop rbp
    ret

; void skip_spaces
global _skip_spaces
_skip_spaces:
    push rbp
    mov rbp, rsp
L18:
    call _next_char
    movsxd rax, eax
    push rax
    mov rax, 32
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L24
    call _next_char
    movsxd rax, eax
    push rax
    mov rax, 10
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
    cmp rax, 0
    jne L22
    call _next_char
    movsxd rax, eax
    push rax
    mov rax, 9
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L22
    mov eax, 0
    jmp L23
L22:
    mov eax, 1
L23:
    cmp rax, 0
    jne L20
    call _next_char
    movsxd rax, eax
    push rax
    mov rax, 13
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L20
    mov eax, 0
    jmp L21
L20:
    mov eax, 1
L21:
    cmp rax, 0
    je L19
    call _advance
    movsxd rax, eax
    jmp L18
L19:
    xor eax, eax
L17:
    mov rsp, rbp
    pop rbp
    ret

; char* read_identifier
global _read_identifier
_read_identifier:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    movsxd rax, dword [rel _pos]
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
L27:
    call _next_char
    movsxd rax, eax
    push rax
    pop rdi
    call _is_alpha
    movsxd rax, eax
    cmp rax, 0
    jne L31
    call _next_char
    movsxd rax, eax
    push rax
    pop rdi
    call _is_digit
    movsxd rax, eax
    cmp rax, 0
    jne L31
    mov eax, 0
    jmp L32
L31:
    mov eax, 1
L32:
    cmp rax, 0
    jne L29
    call _next_char
    movsxd rax, eax
    push rax
    mov rax, 95
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L29
    mov eax, 0
    jmp L30
L29:
    mov eax, 1
L30:
    cmp rax, 0
    je L28
    call _advance
    movsxd rax, eax
    jmp L27
L28:
    movsxd rax, dword [rel _pos]
    push rax
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
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
    mov qword [rbp-24], rcx
    mov rax, qword [rbp-24]
    push rax
    mov rax, qword [rel _src]
    push rax
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _copy_mem
    mov rax, 0
    push rax
    mov rax, qword [rbp-24]
    push rax
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
    mov rax, qword [rbp-24]
    jmp L26
    xor eax, eax
L26:
    mov rsp, rbp
    pop rbp
    ret

; int read_number
global _read_number
_read_number:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    mov rax, 1
    mov rcx, rax
    mov dword [rel _lex_ok], ecx
    movsxd rax, eax
L34:
    call _next_char
    movsxd rax, eax
    push rax
    pop rdi
    call _is_digit
    movsxd rax, eax
    cmp rax, 0
    je L35
    call _advance
    movsxd rax, eax
    push rax
    mov rax, 48
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 2147483647
    push rax
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L36
    mov rax, 0
    mov rcx, rax
    mov dword [rel _lex_ok], ecx
    movsxd rax, eax
    jmp L37
L36:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    imul rax, rcx
    movsxd rax, eax
    push rax
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
L37:
    jmp L34
L35:
    movsxd rax, dword [rbp-8]
    jmp L33
    xor eax, eax
L33:
    mov rsp, rbp
    pop rbp
    ret

; char* read_string
global _read_string
_read_string:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    call _advance
    movsxd rax, eax
    movsxd rax, dword [rel _pos]
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
L39:
    call _next_char
    movsxd rax, eax
    push rax
    mov rax, 34
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L41
    call _next_char
    movsxd rax, eax
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L41
    mov eax, 1
    jmp L42
L41:
    mov eax, 0
L42:
    cmp rax, 0
    je L40
    call _advance
    movsxd rax, eax
    push rax
    mov rax, 92
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L44
    call _next_char
    movsxd rax, eax
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L44
    mov eax, 1
    jmp L45
L44:
    mov eax, 0
L45:
    cmp rax, 0
    je L43
    call _advance
    movsxd rax, eax
L43:
    jmp L39
L40:
    call _next_char
    movsxd rax, eax
    push rax
    mov rax, 34
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    mov rcx, rax
    mov dword [rel _lex_ok], ecx
    movsxd rax, eax
    movsxd rax, dword [rel _pos]
    push rax
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
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
    mov qword [rbp-24], rcx
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-40], ecx
    movsxd rax, eax
L46:
    movsxd rax, dword [rbp-32]
    push rax
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setl al
    movzx eax, al
    cmp rax, 0
    je L47
    mov rax, qword [rel _src]
    push rax
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    movsxd rax, dword [rbp-32]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
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
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 92
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L49
    movsxd rax, dword [rbp-32]
    push rax
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setl al
    movzx eax, al
    cmp rax, 0
    je L49
    mov eax, 1
    jmp L50
L49:
    mov eax, 0
L50:
    cmp rax, 0
    je L48
    mov rax, qword [rel _src]
    push rax
    movsxd rax, dword [rbp-8]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    movsxd rax, dword [rbp-32]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
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
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 110
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L51
    mov rax, 10
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
L51:
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 116
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L52
    mov rax, 9
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
L52:
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 114
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L53
    mov rax, 13
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
L53:
L48:
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, qword [rbp-24]
    push rax
    movsxd rax, dword [rbp-40]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
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
    jmp L46
L47:
    mov rax, 0
    push rax
    mov rax, qword [rbp-24]
    push rax
    movsxd rax, dword [rbp-40]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rax
    mov rcx, rax
    mov byte [rdx], cl
    movsx rax, al
    call _advance
    movsxd rax, eax
    mov rax, qword [rbp-24]
    jmp L38
    xor eax, eax
L38:
    mov rsp, rbp
    pop rbp
    ret

; int read_char_literal
global _read_char_literal
_read_char_literal:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    call _advance
    movsxd rax, eax
    call _advance
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L55
    mov rax, 0
    mov rcx, rax
    mov dword [rel _lex_ok], ecx
    movsxd rax, eax
    mov rax, 0
    jmp L54
L55:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 92
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L56
    call _advance
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 110
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L57
    mov rax, 10
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
L57:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 114
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L58
    mov rax, 13
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
L58:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 116
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L59
    mov rax, 9
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
L59:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 48
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L60
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
L60:
L56:
    call _next_char
    movsxd rax, eax
    push rax
    mov rax, 39
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    mov rcx, rax
    mov dword [rel _lex_ok], ecx
    movsxd rax, eax
    movsxd rax, dword [rel _lex_ok]
    cmp rax, 0
    je L61
    call _advance
    movsxd rax, eax
L61:
    movsxd rax, dword [rbp-8]
    jmp L54
    xor eax, eax
L54:
    mov rsp, rbp
    pop rbp
    ret

; void* make_token
global _make_token
_make_token:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    mov rax, 24
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
    movsxd rax, dword [rel _tok_line]
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
    movsxd rax, dword [rel _tok_col]
    push rax
    mov rax, qword [rbp-32]
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
    mov rax, qword [rbp-16]
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
    mov qword [rdx], rcx
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, qword [rbp-32]
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
    mov rax, qword [rbp-32]
    jmp L62
    xor eax, eax
L62:
    mov rsp, rbp
    pop rbp
    ret

; int token_kind
global _token_kind
_token_kind:
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
    jmp L63
    xor eax, eax
L63:
    mov rsp, rbp
    pop rbp
    ret

; char* token_text
global _token_text
_token_text:
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
    mov rax, qword [rdx]
    jmp L64
    xor eax, eax
L64:
    mov rsp, rbp
    pop rbp
    ret

; int token_value
global _token_value
_token_value:
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
    jmp L65
    xor eax, eax
L65:
    mov rsp, rbp
    pop rbp
    ret

; int token_line
global _token_line
_token_line:
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
    jmp L66
    xor eax, eax
L66:
    mov rsp, rbp
    pop rbp
    ret

; int token_col
global _token_col
_token_col:
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
    jmp L67
    xor eax, eax
L67:
    mov rsp, rbp
    pop rbp
    ret

; int keyword_kind
global _keyword_kind
_keyword_kind:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S0]
    push rax
    pop rsi
    pop rdi
    call _str_eq
    movsxd rax, eax
    cmp rax, 0
    je L69
    mov rax, 260
    jmp L68
L69:
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S1]
    push rax
    pop rsi
    pop rdi
    call _str_eq
    movsxd rax, eax
    cmp rax, 0
    je L70
    mov rax, 261
    jmp L68
L70:
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S2]
    push rax
    pop rsi
    pop rdi
    call _str_eq
    movsxd rax, eax
    cmp rax, 0
    je L71
    mov rax, 262
    jmp L68
L71:
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S3]
    push rax
    pop rsi
    pop rdi
    call _str_eq
    movsxd rax, eax
    cmp rax, 0
    je L72
    mov rax, 263
    jmp L68
L72:
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S4]
    push rax
    pop rsi
    pop rdi
    call _str_eq
    movsxd rax, eax
    cmp rax, 0
    je L73
    mov rax, 264
    jmp L68
L73:
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S5]
    push rax
    pop rsi
    pop rdi
    call _str_eq
    movsxd rax, eax
    cmp rax, 0
    je L74
    mov rax, 265
    jmp L68
L74:
    mov rax, qword [rbp-8]
    push rax
    lea rax, [rel S6]
    push rax
    pop rsi
    pop rdi
    call _str_eq
    movsxd rax, eax
    cmp rax, 0
    je L75
    mov rax, 266
    jmp L68
L75:
    mov rax, 257
    jmp L68
    xor eax, eax
L68:
    mov rsp, rbp
    pop rbp
    ret

; void* next_token
global _next_token
_next_token:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    call _skip_spaces
    movsxd rax, dword [rel _line]
    mov rcx, rax
    mov dword [rel _tok_line], ecx
    movsxd rax, eax
    movsxd rax, dword [rel _col]
    mov rcx, rax
    mov dword [rel _tok_col], ecx
    movsxd rax, eax
    call _next_char
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-8], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L77
    mov rax, 256
    push rax
    mov rax, 0
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L77:
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _is_alpha
    movsxd rax, eax
    cmp rax, 0
    jne L79
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 95
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L79
    mov eax, 0
    jmp L80
L79:
    mov eax, 1
L80:
    cmp rax, 0
    je L78
    call _read_identifier
    mov rcx, rax
    mov qword [rbp-16], rcx
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _keyword_kind
    movsxd rax, eax
    push rax
    mov rax, qword [rbp-16]
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L78:
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _is_digit
    movsxd rax, eax
    cmp rax, 0
    je L81
    call _read_number
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    movsxd rax, dword [rel _lex_ok]
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L82
    mov rax, 274
    push rax
    lea rax, [rel S7]
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L82:
    mov rax, 258
    push rax
    mov rax, 0
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L81:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 34
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L83
    call _read_string
    mov rcx, rax
    mov qword [rbp-32], rcx
    movsxd rax, dword [rel _lex_ok]
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L84
    mov rax, 274
    push rax
    lea rax, [rel S8]
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L84:
    mov rax, 259
    push rax
    mov rax, qword [rbp-32]
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L83:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 39
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L85
    call _read_char_literal
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-40], ecx
    movsxd rax, eax
    movsxd rax, dword [rel _lex_ok]
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L86
    mov rax, 274
    push rax
    lea rax, [rel S9]
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L86:
    mov rax, 273
    push rax
    mov rax, 0
    push rax
    movsxd rax, dword [rbp-40]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L85:
    call _advance
    movsxd rax, eax
    call _next_char
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 61
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L88
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 61
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L88
    mov eax, 1
    jmp L89
L88:
    mov eax, 0
L89:
    cmp rax, 0
    je L87
    call _advance
    movsxd rax, eax
    mov rax, 267
    push rax
    mov rax, 0
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L87:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 33
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L91
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 61
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L91
    mov eax, 1
    jmp L92
L91:
    mov eax, 0
L92:
    cmp rax, 0
    je L90
    call _advance
    movsxd rax, eax
    mov rax, 268
    push rax
    mov rax, 0
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L90:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 60
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L94
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 61
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L94
    mov eax, 1
    jmp L95
L94:
    mov eax, 0
L95:
    cmp rax, 0
    je L93
    call _advance
    movsxd rax, eax
    mov rax, 269
    push rax
    mov rax, 0
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L93:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 62
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L97
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 61
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L97
    mov eax, 1
    jmp L98
L97:
    mov eax, 0
L98:
    cmp rax, 0
    je L96
    call _advance
    movsxd rax, eax
    mov rax, 270
    push rax
    mov rax, 0
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L96:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 38
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L100
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 38
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L100
    mov eax, 1
    jmp L101
L100:
    mov eax, 0
L101:
    cmp rax, 0
    je L99
    call _advance
    movsxd rax, eax
    mov rax, 271
    push rax
    mov rax, 0
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L99:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 124
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L103
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 124
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L103
    mov eax, 1
    jmp L104
L103:
    mov eax, 0
L104:
    cmp rax, 0
    je L102
    call _advance
    movsxd rax, eax
    mov rax, 272
    push rax
    mov rax, 0
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
L102:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 0
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _make_token
    jmp L76
    xor eax, eax
L76:
    mov rsp, rbp
    pop rbp
    ret

section .rodata
S0: db "int", 0
S1: db "char", 0
S2: db "void", 0
S3: db "return", 0
S4: db "if", 0
S5: db "else", 0
S6: db "while", 0
S7: db "numero demasiado grande", 0
S8: db "cadena sin cerrar", 0
S9: db "caracter sin cerrar", 0

section .data
_src: dq 0
_pos: dd 0
_line: dd 0
_col: dd 0
_tok_line: dd 0
_tok_col: dd 0
_lex_ok: dd 0
