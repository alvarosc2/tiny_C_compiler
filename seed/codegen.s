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
extern _analyze
extern _type_name

section .text

; void g_line
global _g_line
_g_line:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    lea rax, [rel S0]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _emit
    lea rax, [rel S1]
    push rax
    pop rdi
    call _emit
    xor eax, eax
L1:
    mov rsp, rbp
    pop rbp
    ret

; int g_new_label
global _g_new_label
_g_new_label:
    push rbp
    mov rbp, rsp
    movsxd rax, dword [rel _g_label]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _g_label], ecx
    movsxd rax, eax
    movsxd rax, dword [rel _g_label]
    jmp L2
    xor eax, eax
L2:
    mov rsp, rbp
    pop rbp
    ret

; void g_label_def
global _g_label_def
_g_label_def:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    lea rax, [rel S2]
    push rax
    pop rdi
    call _emit
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _emit_int
    lea rax, [rel S3]
    push rax
    pop rdi
    call _emit
    xor eax, eax
L3:
    mov rsp, rbp
    pop rbp
    ret

; void g_jump
global _g_jump
_g_jump:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    lea rax, [rel S4]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _emit
    lea rax, [rel S5]
    push rax
    pop rdi
    call _emit
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _emit_int
    lea rax, [rel S6]
    push rax
    pop rdi
    call _emit
    xor eax, eax
L4:
    mov rsp, rbp
    pop rbp
    ret

; void g_push
global _g_push
_g_push:
    push rbp
    mov rbp, rsp
    lea rax, [rel S7]
    push rax
    pop rdi
    call _g_line
    movsxd rax, dword [rel _g_depth]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _g_depth], ecx
    movsxd rax, eax
    xor eax, eax
L5:
    mov rsp, rbp
    pop rbp
    ret

; void g_pop
global _g_pop
_g_pop:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    lea rax, [rel S8]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _emit
    lea rax, [rel S9]
    push rax
    pop rdi
    call _emit
    movsxd rax, dword [rel _g_depth]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _g_depth], ecx
    movsxd rax, eax
    xor eax, eax
L6:
    mov rsp, rbp
    pop rbp
    ret

; char* g_reg
global _g_reg
_g_reg:
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
    sete al
    movzx eax, al
    cmp rax, 0
    je L8
    lea rax, [rel S10]
    jmp L7
L8:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L9
    lea rax, [rel S11]
    jmp L7
L9:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L10
    lea rax, [rel S12]
    jmp L7
L10:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 3
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L11
    lea rax, [rel S13]
    jmp L7
L11:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 4
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L12
    lea rax, [rel S14]
    jmp L7
L12:
    lea rax, [rel S15]
    jmp L7
    xor eax, eax
L7:
    mov rsp, rbp
    pop rbp
    ret

; void g_op_imm
global _g_op_imm
_g_op_imm:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    lea rax, [rel S16]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _emit
    lea rax, [rel S17]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _emit
    lea rax, [rel S18]
    push rax
    pop rdi
    call _emit
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _emit_int
    lea rax, [rel S19]
    push rax
    pop rdi
    call _emit
    xor eax, eax
L13:
    mov rsp, rbp
    pop rbp
    ret

; int g_size
global _g_size
_g_size:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 261
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L15
    mov rax, 1
    jmp L14
L15:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 260
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L16
    mov rax, 4
    jmp L14
L16:
    mov rax, 8
    jmp L14
    xor eax, eax
L14:
    mov rsp, rbp
    pop rbp
    ret

; int g_is_ptr
global _g_is_ptr
_g_is_ptr:
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
    je L18
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
    je L18
    mov eax, 1
    jmp L19
L18:
    mov eax, 0
L19:
    jmp L17
    xor eax, eax
L17:
    mov rsp, rbp
    pop rbp
    ret

; int g_pointee
global _g_pointee
_g_pointee:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 1000
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    push rax
    pop rdi
    call _g_size
    movsxd rax, eax
    jmp L20
    xor eax, eax
L20:
    mov rsp, rbp
    pop rbp
    ret

; void g_norm
global _g_norm
_g_norm:
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
    je L22
    lea rax, [rel S20]
    push rax
    pop rdi
    call _g_line
L22:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 261
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L23
    lea rax, [rel S21]
    push rax
    pop rdi
    call _g_line
L23:
    xor eax, eax
L21:
    mov rsp, rbp
    pop rbp
    ret

; void g_load_head
global _g_load_head
_g_load_head:
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
    je L25
    lea rax, [rel S22]
    push rax
    pop rdi
    call _emit
    jmp L26
L25:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 261
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L27
    lea rax, [rel S23]
    push rax
    pop rdi
    call _emit
    jmp L28
L27:
    lea rax, [rel S24]
    push rax
    pop rdi
    call _emit
L28:
L26:
    xor eax, eax
L24:
    mov rsp, rbp
    pop rbp
    ret

; void g_store_head
global _g_store_head
_g_store_head:
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
    je L30
    lea rax, [rel S25]
    push rax
    pop rdi
    call _emit
    jmp L31
L30:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 261
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L32
    lea rax, [rel S26]
    push rax
    pop rdi
    call _emit
    jmp L33
L32:
    lea rax, [rel S27]
    push rax
    pop rdi
    call _emit
L33:
L31:
    xor eax, eax
L29:
    mov rsp, rbp
    pop rbp
    ret

; void g_store_tail
global _g_store_tail
_g_store_tail:
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
    je L35
    lea rax, [rel S28]
    push rax
    pop rdi
    call _emit
    jmp L36
L35:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 261
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L37
    lea rax, [rel S29]
    push rax
    pop rdi
    call _emit
    jmp L38
L37:
    lea rax, [rel S30]
    push rax
    pop rdi
    call _emit
L38:
L36:
    xor eax, eax
L34:
    mov rsp, rbp
    pop rbp
    ret

; void g_slot
global _g_slot
_g_slot:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    movsxd rax, dword [rel _g_frame]
    push rax
    mov rax, 8
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _g_frame], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    push rax
    movsxd rax, dword [rel _g_frame]
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _node_set_value
    xor eax, eax
L39:
    mov rsp, rbp
    pop rbp
    ret

; void g_slots
global _g_slots
_g_slots:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
L41:
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L42
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
    jne L44
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 3
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L44
    mov eax, 0
    jmp L45
L44:
    mov eax, 1
L45:
    cmp rax, 0
    je L43
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _g_slot
L43:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _g_slots
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    push rax
    pop rdi
    call _g_slots
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_c
    push rax
    pop rdi
    call _g_slots
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-8], rcx
    jmp L41
L42:
    xor eax, eax
L40:
    mov rsp, rbp
    pop rbp
    ret

; void g_mem
global _g_mem
_g_mem:
    push rbp
    mov rbp, rsp
    sub rsp, 16
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
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L47
    lea rax, [rel S31]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_text
    push rax
    pop rdi
    call _emit
    lea rax, [rel S32]
    push rax
    pop rdi
    call _emit
    jmp L48
L47:
    lea rax, [rel S33]
    push rax
    pop rdi
    call _emit
    mov rax, 0
    push rax
    movsxd rax, dword [rbp-16]
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    push rax
    pop rdi
    call _emit_int
    lea rax, [rel S34]
    push rax
    pop rdi
    call _emit
L48:
    xor eax, eax
L46:
    mov rsp, rbp
    pop rbp
    ret

; void g_store_id
global _g_store_id
_g_store_id:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    lea rax, [rel S35]
    push rax
    pop rdi
    call _g_line
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _g_store_head
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _g_mem
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _g_store_tail
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _g_norm
    xor eax, eax
L49:
    mov rsp, rbp
    pop rbp
    ret

; void g_addr
global _g_addr
_g_addr:
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
    mov rax, 14
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L51
    lea rax, [rel S36]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_decl
    push rax
    pop rdi
    call _g_mem
    lea rax, [rel S37]
    push rax
    pop rdi
    call _emit
    jmp L52
L51:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _g_expr
L52:
    xor eax, eax
L50:
    mov rsp, rbp
    pop rbp
    ret

; void g_scale
global _g_scale
_g_scale:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L54
    jmp L53
L54:
    lea rax, [rel S38]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _emit
    lea rax, [rel S39]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _emit
    lea rax, [rel S40]
    push rax
    pop rdi
    call _emit
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _emit_int
    lea rax, [rel S41]
    push rax
    pop rdi
    call _emit
    xor eax, eax
L53:
    mov rsp, rbp
    pop rbp
    ret

; void g_cmp_zero
global _g_cmp_zero
_g_cmp_zero:
    push rbp
    mov rbp, rsp
    lea rax, [rel S42]
    push rax
    lea rax, [rel S43]
    push rax
    mov rax, 0
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _g_op_imm
    xor eax, eax
L55:
    mov rsp, rbp
    pop rbp
    ret

; void g_assign
global _g_assign
_g_assign:
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
    pop rdi
    call _node_type
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    push rax
    pop rdi
    call _g_expr
    mov rax, qword [rbp-16]
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
    je L57
    movsxd rax, dword [rbp-24]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    sub rsp, 8
    call _node_decl
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _g_store_id
    jmp L56
L57:
    call _g_push
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _g_addr
    lea rax, [rel S44]
    push rax
    pop rdi
    call _g_line
    lea rax, [rel S45]
    push rax
    pop rdi
    call _g_pop
    lea rax, [rel S46]
    push rax
    pop rdi
    call _g_line
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _g_store_head
    lea rax, [rel S47]
    push rax
    pop rdi
    call _emit
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _g_store_tail
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _g_norm
    xor eax, eax
L56:
    mov rsp, rbp
    pop rbp
    ret

; void g_logic
global _g_logic
_g_logic:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    call _g_new_label
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    call _g_new_label
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    lea rax, [rel S48]
    mov rcx, rax
    mov qword [rbp-40], rcx
    mov rax, 1
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-56], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 272
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L59
    lea rax, [rel S49]
    mov rcx, rax
    mov qword [rbp-40], rcx
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
    mov rax, 1
    mov rcx, rax
    mov dword [rbp-56], ecx
    movsxd rax, eax
L59:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _g_expr
    call _g_cmp_zero
    mov rax, qword [rbp-40]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rsi
    pop rdi
    call _g_jump
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    push rax
    pop rdi
    call _g_expr
    call _g_cmp_zero
    mov rax, qword [rbp-40]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rsi
    pop rdi
    call _g_jump
    lea rax, [rel S50]
    push rax
    lea rax, [rel S51]
    push rax
    movsxd rax, dword [rbp-48]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _g_op_imm
    lea rax, [rel S52]
    push rax
    movsxd rax, dword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _g_jump
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _g_label_def
    lea rax, [rel S53]
    push rax
    lea rax, [rel S54]
    push rax
    movsxd rax, dword [rbp-56]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _g_op_imm
    movsxd rax, dword [rbp-32]
    push rax
    pop rdi
    call _g_label_def
    xor eax, eax
L58:
    mov rsp, rbp
    pop rbp
    ret

; char* g_cc
global _g_cc
_g_cc:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 60
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L61
    movsxd rax, dword [rbp-16]
    cmp rax, 0
    je L62
    lea rax, [rel S55]
    jmp L60
L62:
    lea rax, [rel S56]
    jmp L60
L61:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 62
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L63
    movsxd rax, dword [rbp-16]
    cmp rax, 0
    je L64
    lea rax, [rel S57]
    jmp L60
L64:
    lea rax, [rel S58]
    jmp L60
L63:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 269
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L65
    movsxd rax, dword [rbp-16]
    cmp rax, 0
    je L66
    lea rax, [rel S59]
    jmp L60
L66:
    lea rax, [rel S60]
    jmp L60
L65:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 270
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L67
    movsxd rax, dword [rbp-16]
    cmp rax, 0
    je L68
    lea rax, [rel S61]
    jmp L60
L68:
    lea rax, [rel S62]
    jmp L60
L67:
    movsxd rax, dword [rbp-8]
    push rax
    mov rax, 267
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L69
    lea rax, [rel S63]
    jmp L60
L69:
    lea rax, [rel S64]
    jmp L60
    xor eax, eax
L60:
    mov rsp, rbp
    pop rbp
    ret

; void g_compare
global _g_compare
_g_compare:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    lea rax, [rel S65]
    push rax
    pop rdi
    call _g_line
    lea rax, [rel S66]
    push rax
    pop rdi
    call _emit
    movsxd rax, dword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _g_cc
    push rax
    pop rdi
    call _emit
    lea rax, [rel S67]
    push rax
    pop rdi
    call _emit
    lea rax, [rel S68]
    push rax
    pop rdi
    call _g_line
    xor eax, eax
L70:
    mov rsp, rbp
    pop rbp
    ret

; void g_add
global _g_add
_g_add:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _g_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L72
    lea rax, [rel S69]
    push rax
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    sub rsp, 8
    call _g_pointee
    add rsp, 8
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _g_scale
    jmp L73
L72:
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _g_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L74
    lea rax, [rel S70]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    sub rsp, 8
    call _g_pointee
    add rsp, 8
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _g_scale
L74:
L73:
    lea rax, [rel S71]
    push rax
    pop rdi
    call _g_line
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _g_is_ptr
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L76
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _g_is_ptr
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L76
    mov eax, 1
    jmp L77
L76:
    mov eax, 0
L77:
    cmp rax, 0
    je L75
    mov rax, 260
    push rax
    pop rdi
    call _g_norm
L75:
    xor eax, eax
L71:
    mov rsp, rbp
    pop rbp
    ret

; void g_sub
global _g_sub
_g_sub:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _g_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L80
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _g_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L80
    mov eax, 1
    jmp L81
L80:
    mov eax, 0
L81:
    cmp rax, 0
    je L79
    lea rax, [rel S72]
    push rax
    pop rdi
    call _g_line
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _g_pointee
    movsxd rax, eax
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L82
    lea rax, [rel S73]
    push rax
    lea rax, [rel S74]
    push rax
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _g_pointee
    movsxd rax, eax
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _g_op_imm
    lea rax, [rel S75]
    push rax
    pop rdi
    call _g_line
    lea rax, [rel S76]
    push rax
    pop rdi
    call _g_line
L82:
    mov rax, 260
    push rax
    pop rdi
    call _g_norm
    jmp L83
L79:
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    call _g_is_ptr
    movsxd rax, eax
    cmp rax, 0
    je L84
    lea rax, [rel S77]
    push rax
    movsxd rax, dword [rbp-8]
    push rax
    pop rdi
    sub rsp, 8
    call _g_pointee
    add rsp, 8
    movsxd rax, eax
    push rax
    pop rsi
    pop rdi
    call _g_scale
    lea rax, [rel S78]
    push rax
    pop rdi
    call _g_line
    jmp L85
L84:
    lea rax, [rel S79]
    push rax
    pop rdi
    call _g_line
    mov rax, 260
    push rax
    pop rdi
    call _g_norm
L85:
L83:
    xor eax, eax
L78:
    mov rsp, rbp
    pop rbp
    ret

; void g_binop
global _g_binop
_g_binop:
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
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 61
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L87
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _g_assign
    jmp L86
L87:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 271
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L89
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 272
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
    cmp rax, 0
    je L88
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _g_logic
    jmp L86
L88:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
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
    call _node_b
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _g_expr
    call _g_push
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    push rax
    pop rdi
    call _g_expr
    lea rax, [rel S80]
    push rax
    pop rdi
    call _g_line
    lea rax, [rel S81]
    push rax
    pop rdi
    call _g_pop
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 43
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L91
    movsxd rax, dword [rbp-24]
    push rax
    movsxd rax, dword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _g_add
    jmp L92
L91:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 45
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L93
    movsxd rax, dword [rbp-24]
    push rax
    movsxd rax, dword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _g_sub
    jmp L94
L93:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 42
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L95
    lea rax, [rel S82]
    push rax
    pop rdi
    call _g_line
    mov rax, 260
    push rax
    pop rdi
    call _g_norm
    jmp L96
L95:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 47
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L97
    lea rax, [rel S83]
    push rax
    pop rdi
    call _g_line
    lea rax, [rel S84]
    push rax
    pop rdi
    call _g_line
    mov rax, 260
    push rax
    pop rdi
    call _g_norm
    jmp L98
L97:
    movsxd rax, dword [rbp-16]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    sub rsp, 8
    call _g_is_ptr
    add rsp, 8
    movsxd rax, eax
    cmp rax, 0
    jne L99
    movsxd rax, dword [rbp-32]
    push rax
    pop rdi
    sub rsp, 8
    call _g_is_ptr
    add rsp, 8
    movsxd rax, eax
    cmp rax, 0
    jne L99
    mov eax, 0
    jmp L100
L99:
    mov eax, 1
L100:
    push rax
    pop rsi
    pop rdi
    call _g_compare
L98:
L96:
L94:
L92:
    xor eax, eax
L86:
    mov rsp, rbp
    pop rbp
    ret

; void g_unop
global _g_unop
_g_unop:
    push rbp
    mov rbp, rsp
    sub rsp, 16
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
    call _g_expr
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 45
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L102
    lea rax, [rel S85]
    push rax
    pop rdi
    call _g_line
    mov rax, 260
    push rax
    pop rdi
    call _g_norm
    jmp L103
L102:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 33
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L104
    call _g_cmp_zero
    lea rax, [rel S86]
    push rax
    pop rdi
    call _g_line
    lea rax, [rel S87]
    push rax
    pop rdi
    call _g_line
    jmp L105
L104:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 42
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L106
    lea rax, [rel S88]
    push rax
    pop rdi
    call _g_line
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    push rax
    pop rdi
    call _g_load_head
    lea rax, [rel S89]
    push rax
    pop rdi
    call _emit
L106:
L105:
L103:
    xor eax, eax
L101:
    mov rsp, rbp
    pop rbp
    ret

; void g_call
global _g_call
_g_call:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-24], rcx
L108:
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L109
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _g_expr
    call _g_push
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
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-24], rcx
    jmp L108
L109:
L110:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L111
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-16], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-16]
    push rax
    pop rdi
    call _g_reg
    push rax
    pop rdi
    call _g_pop
    jmp L110
L111:
    movsxd rax, dword [rel _g_depth]
    push rax
    movsxd rax, dword [rel _g_depth]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    movsxd rax, eax
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    imul rax, rcx
    movsxd rax, eax
    mov rcx, rax
    pop rax
    sub rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-32]
    cmp rax, 0
    je L112
    lea rax, [rel S90]
    push rax
    lea rax, [rel S91]
    push rax
    mov rax, 8
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _g_op_imm
L112:
    lea rax, [rel S92]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_text
    push rax
    pop rdi
    call _emit
    lea rax, [rel S93]
    push rax
    pop rdi
    call _emit
    movsxd rax, dword [rbp-32]
    cmp rax, 0
    je L113
    lea rax, [rel S94]
    push rax
    lea rax, [rel S95]
    push rax
    mov rax, 8
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _g_op_imm
L113:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    push rax
    pop rdi
    call _g_norm
    xor eax, eax
L107:
    mov rsp, rbp
    pop rbp
    ret

; void g_expr
global _g_expr
_g_expr:
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
    jne L116
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 17
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    jne L116
    mov eax, 0
    jmp L117
L116:
    mov eax, 1
L117:
    cmp rax, 0
    je L115
    lea rax, [rel S96]
    push rax
    lea rax, [rel S97]
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_value
    movsxd rax, eax
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _g_op_imm
    jmp L118
L115:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 15
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L119
    lea rax, [rel S98]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_value
    movsxd rax, eax
    push rax
    pop rdi
    call _emit_int
    lea rax, [rel S99]
    push rax
    pop rdi
    call _emit
    jmp L120
L119:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 14
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L121
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    push rax
    pop rdi
    call _g_load_head
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_decl
    push rax
    pop rdi
    call _g_mem
    lea rax, [rel S100]
    push rax
    pop rdi
    call _emit
    jmp L122
L121:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 13
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L123
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _g_call
    jmp L124
L123:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 12
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L125
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _g_expr
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    push rax
    pop rdi
    call _g_norm
    jmp L126
L125:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 11
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L127
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _g_unop
    jmp L128
L127:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _g_binop
L128:
L126:
L124:
L122:
L120:
L118:
    xor eax, eax
L114:
    mov rsp, rbp
    pop rbp
    ret

; void g_stmts
global _g_stmts
_g_stmts:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
L130:
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L131
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _g_stmt
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-8], rcx
    jmp L130
L131:
    xor eax, eax
L129:
    mov rsp, rbp
    pop rbp
    ret

; void g_stmt
global _g_stmt
_g_stmt:
    push rbp
    mov rbp, rsp
    sub rsp, 48
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
    je L133
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L134
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _g_expr
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    push rax
    mov rax, qword [rbp-8]
    push rax
    pop rsi
    pop rdi
    call _g_store_id
L134:
    jmp L135
L133:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 9
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L136
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _g_expr
    jmp L137
L136:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 8
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L138
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L139
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _g_expr
L139:
    lea rax, [rel S101]
    push rax
    movsxd rax, dword [rel _g_ret]
    push rax
    pop rsi
    pop rdi
    call _g_jump
    jmp L140
L138:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 5
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L141
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _g_stmts
    jmp L142
L141:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 6
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L143
    call _g_new_label
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _g_expr
    call _g_cmp_zero
    lea rax, [rel S102]
    push rax
    movsxd rax, dword [rbp-24]
    push rax
    pop rsi
    pop rdi
    call _g_jump
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    push rax
    pop rdi
    call _g_stmt
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
    je L144
    call _g_new_label
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    lea rax, [rel S103]
    push rax
    movsxd rax, dword [rbp-32]
    push rax
    pop rsi
    pop rdi
    call _g_jump
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _g_label_def
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_c
    push rax
    pop rdi
    call _g_stmt
    movsxd rax, dword [rbp-32]
    push rax
    pop rdi
    call _g_label_def
    jmp L145
L144:
    movsxd rax, dword [rbp-24]
    push rax
    pop rdi
    call _g_label_def
L145:
    jmp L146
L143:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 7
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L147
    call _g_new_label
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-40], ecx
    movsxd rax, eax
    call _g_new_label
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-40]
    push rax
    pop rdi
    call _g_label_def
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _g_expr
    call _g_cmp_zero
    lea rax, [rel S104]
    push rax
    movsxd rax, dword [rbp-48]
    push rax
    pop rsi
    pop rdi
    call _g_jump
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    push rax
    pop rdi
    call _g_stmt
    lea rax, [rel S105]
    push rax
    movsxd rax, dword [rbp-40]
    push rax
    pop rsi
    pop rdi
    call _g_jump
    movsxd rax, dword [rbp-48]
    push rax
    pop rdi
    call _g_label_def
L147:
L146:
L142:
L140:
L137:
L135:
    xor eax, eax
L132:
    mov rsp, rbp
    pop rbp
    ret

; void g_function
global _g_function
_g_function:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov rax, 0
    mov rcx, rax
    mov dword [rel _g_depth], ecx
    movsxd rax, eax
    mov rax, 0
    mov rcx, rax
    mov dword [rel _g_frame], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _g_slots
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    push rax
    pop rdi
    call _g_slots
    movsxd rax, dword [rel _g_frame]
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
    mov dword [rbp-16], ecx
    movsxd rax, eax
    call _g_new_label
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _g_ret], ecx
    movsxd rax, eax
    lea rax, [rel S106]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_type
    movsxd rax, eax
    push rax
    pop rdi
    call _type_name
    push rax
    pop rdi
    call _emit
    lea rax, [rel S107]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_text
    push rax
    pop rdi
    call _emit
    lea rax, [rel S108]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_text
    push rax
    pop rdi
    call _emit
    lea rax, [rel S109]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_text
    push rax
    pop rdi
    call _emit
    lea rax, [rel S110]
    push rax
    pop rdi
    call _emit
    lea rax, [rel S111]
    push rax
    pop rdi
    call _g_line
    lea rax, [rel S112]
    push rax
    pop rdi
    call _g_line
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L149
    lea rax, [rel S113]
    push rax
    lea rax, [rel S114]
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _g_op_imm
L149:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-24], rcx
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
L150:
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L151
    lea rax, [rel S115]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _g_mem
    lea rax, [rel S116]
    push rax
    pop rdi
    call _emit
    movsxd rax, dword [rbp-32]
    push rax
    pop rdi
    call _g_reg
    push rax
    pop rdi
    call _emit
    lea rax, [rel S117]
    push rax
    pop rdi
    call _emit
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
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-24], rcx
    jmp L150
L151:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    push rax
    pop rdi
    call _node_a
    push rax
    pop rdi
    call _g_stmts
    lea rax, [rel S118]
    push rax
    pop rdi
    call _g_line
    movsxd rax, dword [rel _g_ret]
    push rax
    pop rdi
    call _g_label_def
    lea rax, [rel S119]
    push rax
    pop rdi
    call _g_line
    lea rax, [rel S120]
    push rax
    pop rdi
    call _g_line
    lea rax, [rel S121]
    push rax
    pop rdi
    call _g_line
    xor eax, eax
L148:
    mov rsp, rbp
    pop rbp
    ret

; void g_strings
global _g_strings
_g_strings:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi
L153:
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L154
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_kind
    movsxd rax, eax
    push rax
    mov rax, 15
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L155
    movsxd rax, dword [rbp-16]
    cmp rax, 0
    je L156
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _g_string_data
    jmp L157
L156:
    mov rax, qword [rbp-8]
    push rax
    movsxd rax, dword [rel _g_nstr]
    push rax
    pop rsi
    pop rdi
    call _node_set_value
    movsxd rax, dword [rel _g_nstr]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rel _g_nstr], ecx
    movsxd rax, eax
L157:
L155:
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _g_strings
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_b
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _g_strings
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_c
    push rax
    movsxd rax, dword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _g_strings
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-8], rcx
    jmp L153
L154:
    xor eax, eax
L152:
    mov rsp, rbp
    pop rbp
    ret

; void g_string_data
global _g_string_data
_g_string_data:
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
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
    mov rax, 1
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-40], ecx
    movsxd rax, eax
    lea rax, [rel S122]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_value
    movsxd rax, eax
    push rax
    pop rdi
    call _emit_int
    lea rax, [rel S123]
    push rax
    pop rdi
    call _emit
L159:
    mov rax, qword [rbp-16]
    push rax
    movsxd rax, dword [rbp-40]
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
    je L160
    mov rax, qword [rbp-16]
    push rax
    movsxd rax, dword [rbp-40]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    movsx rax, byte [rdx]
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 32
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setge al
    movzx eax, al
    cmp rax, 0
    je L164
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 127
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setl al
    movzx eax, al
    cmp rax, 0
    je L164
    mov eax, 1
    jmp L165
L164:
    mov eax, 0
L165:
    cmp rax, 0
    je L162
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 34
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L162
    mov eax, 1
    jmp L163
L162:
    mov eax, 0
L163:
    cmp rax, 0
    je L161
    movsxd rax, dword [rbp-24]
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L166
    movsxd rax, dword [rbp-32]
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L167
    lea rax, [rel S124]
    push rax
    pop rdi
    call _emit
L167:
    lea rax, [rel S125]
    push rax
    pop rdi
    call _emit
    mov rax, 1
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
L166:
    movsxd rax, dword [rbp-48]
    push rax
    pop rdi
    call _emit_char
    jmp L168
L161:
    movsxd rax, dword [rbp-24]
    cmp rax, 0
    je L169
    lea rax, [rel S126]
    push rax
    pop rdi
    call _emit
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-24], ecx
    movsxd rax, eax
L169:
    movsxd rax, dword [rbp-32]
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L170
    lea rax, [rel S127]
    push rax
    pop rdi
    call _emit
L170:
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setl al
    movzx eax, al
    cmp rax, 0
    je L171
    movsxd rax, dword [rbp-48]
    push rax
    mov rax, 256
    mov rcx, rax
    pop rax
    add rax, rcx
    movsxd rax, eax
    mov rcx, rax
    mov dword [rbp-48], ecx
    movsxd rax, eax
L171:
    movsxd rax, dword [rbp-48]
    push rax
    pop rdi
    call _emit_int
L168:
    mov rax, 0
    mov rcx, rax
    mov dword [rbp-32], ecx
    movsxd rax, eax
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
    jmp L159
L160:
    movsxd rax, dword [rbp-24]
    cmp rax, 0
    je L172
    lea rax, [rel S128]
    push rax
    pop rdi
    call _emit
L172:
    movsxd rax, dword [rbp-32]
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L173
    lea rax, [rel S129]
    push rax
    pop rdi
    call _emit
L173:
    lea rax, [rel S130]
    push rax
    pop rdi
    call _emit
    xor eax, eax
L158:
    mov rsp, rbp
    pop rbp
    ret

; void g_global
global _g_global
_g_global:
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
    mov rcx, rax
    mov qword [rbp-24], rcx
    lea rax, [rel S131]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_text
    push rax
    pop rdi
    call _emit
    lea rax, [rel S132]
    push rax
    pop rdi
    call _emit
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 260
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L175
    lea rax, [rel S133]
    push rax
    pop rdi
    call _emit
    jmp L176
L175:
    movsxd rax, dword [rbp-16]
    push rax
    mov rax, 261
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L177
    lea rax, [rel S134]
    push rax
    pop rdi
    call _emit
    jmp L178
L177:
    lea rax, [rel S135]
    push rax
    pop rdi
    call _emit
L178:
L176:
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L179
    lea rax, [rel S136]
    push rax
    pop rdi
    call _emit
    jmp L180
L179:
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _node_kind
    movsxd rax, eax
    push rax
    mov rax, 15
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L181
    lea rax, [rel S137]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _node_value
    movsxd rax, eax
    push rax
    pop rdi
    call _emit_int
    jmp L182
L181:
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _node_value
    movsxd rax, eax
    push rax
    pop rdi
    call _emit_int
L182:
L180:
    lea rax, [rel S138]
    push rax
    pop rdi
    call _emit
    xor eax, eax
L174:
    mov rsp, rbp
    pop rbp
    ret

; int g_defined
global _g_defined
_g_defined:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-24], rcx
L184:
    mov rax, qword [rbp-24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L185
    mov rax, qword [rbp-24]
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
    je L189
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _node_b
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L189
    mov eax, 1
    jmp L190
L189:
    mov eax, 0
L190:
    cmp rax, 0
    je L187
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _node_text
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rsi
    pop rdi
    call _str_eq
    movsxd rax, eax
    cmp rax, 0
    je L187
    mov eax, 1
    jmp L188
L187:
    mov eax, 0
L188:
    cmp rax, 0
    je L186
    mov rax, 1
    jmp L183
L186:
    mov rax, qword [rbp-24]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-24], rcx
    jmp L184
L185:
    mov rax, 0
    jmp L183
    xor eax, eax
L183:
    mov rsp, rbp
    pop rbp
    ret

; int g_proto_before
global _g_proto_before
_g_proto_before:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp-8], rdi
    mov [rbp-16], rsi
    mov [rbp-24], rdx
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-32], rcx
L192:
    mov rax, qword [rbp-32]
    push rax
    mov rax, qword [rbp-16]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L193
    mov rax, qword [rbp-32]
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
    je L195
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _node_text
    push rax
    mov rax, qword [rbp-24]
    push rax
    pop rsi
    pop rdi
    call _str_eq
    movsxd rax, eax
    cmp rax, 0
    je L195
    mov eax, 1
    jmp L196
L195:
    mov eax, 0
L196:
    cmp rax, 0
    je L194
    mov rax, 1
    jmp L191
L194:
    mov rax, qword [rbp-32]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-32], rcx
    jmp L192
L193:
    mov rax, 0
    jmp L191
    xor eax, eax
L191:
    mov rsp, rbp
    pop rbp
    ret

; char* generate
global _generate
_generate:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp-8], rdi
    call _emit_reset
    mov rax, 0
    mov rcx, rax
    mov dword [rel _g_label], ecx
    movsxd rax, eax
    mov rax, 0
    mov rcx, rax
    mov dword [rel _g_nstr], ecx
    movsxd rax, eax
    mov rax, qword [rbp-8]
    push rax
    mov rax, 0
    push rax
    pop rsi
    pop rdi
    call _g_strings
    lea rax, [rel S139]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-16], rcx
L198:
    mov rax, qword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L199
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
    je L201
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _node_b
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L201
    mov eax, 1
    jmp L202
L201:
    mov eax, 0
L202:
    cmp rax, 0
    je L200
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    sub rsp, 8
    call _node_text
    add rsp, 8
    push rax
    pop rsi
    pop rdi
    call _g_defined
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L204
    mov rax, qword [rbp-8]
    push rax
    mov rax, qword [rbp-16]
    push rax
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _node_text
    push rax
    pop rdx
    pop rsi
    pop rdi
    call _g_proto_before
    movsxd rax, eax
    cmp rax, 0
    sete al
    movzx eax, al
    cmp rax, 0
    je L204
    mov eax, 1
    jmp L205
L204:
    mov eax, 0
L205:
    cmp rax, 0
    je L203
    lea rax, [rel S140]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _node_text
    push rax
    pop rdi
    call _emit
    lea rax, [rel S141]
    push rax
    pop rdi
    call _emit
L203:
L200:
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-16], rcx
    jmp L198
L199:
    lea rax, [rel S142]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-16], rcx
L206:
    mov rax, qword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L207
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
    je L209
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _node_b
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L209
    mov eax, 1
    jmp L210
L209:
    mov eax, 0
L210:
    cmp rax, 0
    je L208
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _g_function
L208:
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-16], rcx
    jmp L206
L207:
    movsxd rax, dword [rel _g_nstr]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setg al
    movzx eax, al
    cmp rax, 0
    je L211
    lea rax, [rel S143]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    mov rax, 1
    push rax
    pop rsi
    pop rdi
    call _g_strings
L211:
    lea rax, [rel S144]
    push rax
    pop rdi
    call _emit
    mov rax, qword [rbp-8]
    push rax
    pop rdi
    call _node_a
    mov rcx, rax
    mov qword [rbp-16], rcx
L212:
    mov rax, qword [rbp-16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    cmp rax, 0
    je L213
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _node_kind
    movsxd rax, eax
    push rax
    mov rax, 4
    mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    cmp rax, 0
    je L214
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _g_global
L214:
    mov rax, qword [rbp-16]
    push rax
    pop rdi
    call _node_next
    mov rcx, rax
    mov qword [rbp-16], rcx
    jmp L212
L213:
    call _emit_text
    jmp L197
    xor eax, eax
L197:
    mov rsp, rbp
    pop rbp
    ret

section .rodata
S0: db "    ", 0
S1: db 10, 0
S2: db "L", 0
S3: db ":", 10, 0
S4: db "    ", 0
S5: db " L", 0
S6: db 10, 0
S7: db "push rax", 0
S8: db "    pop ", 0
S9: db 10, 0
S10: db "rdi", 0
S11: db "rsi", 0
S12: db "rdx", 0
S13: db "rcx", 0
S14: db "r8", 0
S15: db "r9", 0
S16: db "    ", 0
S17: db " ", 0
S18: db ", ", 0
S19: db 10, 0
S20: db "movsxd rax, eax", 0
S21: db "movsx rax, al", 0
S22: db "    movsxd rax, dword ", 0
S23: db "    movsx rax, byte ", 0
S24: db "    mov rax, qword ", 0
S25: db "    mov dword ", 0
S26: db "    mov byte ", 0
S27: db "    mov qword ", 0
S28: db ", ecx", 10, 0
S29: db ", cl", 10, 0
S30: db ", rcx", 10, 0
S31: db "[rel _", 0
S32: db "]", 0
S33: db "[rbp-", 0
S34: db "]", 0
S35: db "mov rcx, rax", 0
S36: db "    lea rax, ", 0
S37: db 10, 0
S38: db "    imul ", 0
S39: db ", ", 0
S40: db ", ", 0
S41: db 10, 0
S42: db "cmp", 0
S43: db "rax", 0
S44: db "mov rdx, rax", 0
S45: db "rax", 0
S46: db "mov rcx, rax", 0
S47: db "[rdx]", 0
S48: db "je", 0
S49: db "jne", 0
S50: db "mov", 0
S51: db "eax", 0
S52: db "jmp", 0
S53: db "mov", 0
S54: db "eax", 0
S55: db "b", 0
S56: db "l", 0
S57: db "a", 0
S58: db "g", 0
S59: db "be", 0
S60: db "le", 0
S61: db "ae", 0
S62: db "ge", 0
S63: db "e", 0
S64: db "ne", 0
S65: db "cmp rax, rcx", 0
S66: db "    set", 0
S67: db " al", 10, 0
S68: db "movzx eax, al", 0
S69: db "rcx", 0
S70: db "rax", 0
S71: db "add rax, rcx", 0
S72: db "sub rax, rcx", 0
S73: db "mov", 0
S74: db "rcx", 0
S75: db "cqo", 0
S76: db "idiv rcx", 0
S77: db "rcx", 0
S78: db "sub rax, rcx", 0
S79: db "sub rax, rcx", 0
S80: db "mov rcx, rax", 0
S81: db "rax", 0
S82: db "imul rax, rcx", 0
S83: db "cqo", 0
S84: db "idiv rcx", 0
S85: db "neg rax", 0
S86: db "sete al", 0
S87: db "movzx eax, al", 0
S88: db "mov rdx, rax", 0
S89: db "[rdx]", 10, 0
S90: db "sub", 0
S91: db "rsp", 0
S92: db "    call _", 0
S93: db 10, 0
S94: db "add", 0
S95: db "rsp", 0
S96: db "mov", 0
S97: db "rax", 0
S98: db "    lea rax, [rel S", 0
S99: db "]", 10, 0
S100: db 10, 0
S101: db "jmp", 0
S102: db "je", 0
S103: db "jmp", 0
S104: db "je", 0
S105: db "jmp", 0
S106: db 10, "; ", 0
S107: db " ", 0
S108: db 10, "global _", 0
S109: db 10, "_", 0
S110: db ":", 10, 0
S111: db "push rbp", 0
S112: db "mov rbp, rsp", 0
S113: db "sub", 0
S114: db "rsp", 0
S115: db "    mov ", 0
S116: db ", ", 0
S117: db 10, 0
S118: db "xor eax, eax", 0
S119: db "mov rsp, rbp", 0
S120: db "pop rbp", 0
S121: db "ret", 0
S122: db "S", 0
S123: db ": db ", 0
S124: db ", ", 0
S125: db 34, 0
S126: db 34, 0
S127: db ", ", 0
S128: db 34, 0
S129: db ", ", 0
S130: db "0", 10, 0
S131: db "_", 0
S132: db ": ", 0
S133: db "dd ", 0
S134: db "db ", 0
S135: db "dq ", 0
S136: db "0", 0
S137: db "S", 0
S138: db 10, 0
S139: db "; generado por tcc: NASM, sintaxis Intel, x86-64 Linux", 10, 0
S140: db "extern _", 0
S141: db 10, 0
S142: db 10, "section .text", 10, 0
S143: db 10, "section .rodata", 10, 0
S144: db 10, "section .data", 10, 0

section .data
_g_depth: dd 0
_g_label: dd 0
_g_nstr: dd 0
_g_frame: dd 0
_g_ret: dd 0
