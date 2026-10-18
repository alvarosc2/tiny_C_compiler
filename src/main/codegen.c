#include "tokens.h"
#include "ast.h"
#include "runtime.h"
#include "sema.h"
#include "codegen.h"

// Prefijo g_ en todo. Máquina de pila: cada expresión deja su valor en rax,
// siempre normalizado (int y char con signo extendido a 64 bits).
int g_depth;   // qwords empujados a la pila dentro de la expresión en curso
int g_label;   // contador de etiquetas L<n>
int g_nstr;    // contador de literales de cadena S<n>
int g_frame;   // bytes de locales en la función en curso
int g_ret;     // etiqueta de salida de la función en curso

void g_expr(void *n);
void g_stmt(void *s);
void g_scale(char *reg, int size);
void g_string_data(void *n);

// ---------- utilidades de salida ----------

void g_line(char *s) {
    emit("    ");
    emit(s);
    emit("\n");
}

int g_new_label() {
    g_label = g_label + 1;
    return g_label;
}

void g_label_def(int n) {
    emit("L");
    emit_int(n);
    emit(":\n");
}

void g_jump(char *op, int n) {
    emit("    ");
    emit(op);
    emit(" L");
    emit_int(n);
    emit("\n");
}

void g_push() {
    g_line("push rax");
    g_depth = g_depth + 1;
}

void g_pop(char *reg) {
    emit("    pop ");
    emit(reg);
    emit("\n");
    g_depth = g_depth - 1;
}

char *g_reg(int i) {
    if (i == 0) return "rdi";
    if (i == 1) return "rsi";
    if (i == 2) return "rdx";
    if (i == 3) return "rcx";
    if (i == 4) return "r8";
    return "r9";
}

// "    op reg, n"
void g_op_imm(char *op, char *reg, int n) {
    emit("    ");
    emit(op);
    emit(" ");
    emit(reg);
    emit(", ");
    emit_int(n);
    emit("\n");
}

// ---------- tipos ----------

int g_size(int t) {
    if (t == T_CHAR) return 1;
    if (t == T_INT) return 4;
    return 8;
}

int g_is_ptr(int t) {
    return t > 0 && type_ptrs(t) > 0;
}

// Tamaño del tipo apuntado, para escalar la aritmética de punteros
int g_pointee(int t) {
    return g_size(t - TYPE_PTR_UNIT);
}

// Reduce rax al ancho de su tipo con signo
void g_norm(int t) {
    if (t == T_INT) g_line("movsxd rax, eax");
    if (t == T_CHAR) g_line("movsx rax, al");
}

void g_load_head(int t) {
    if (t == T_INT) emit("    movsxd rax, dword ");
    else if (t == T_CHAR) emit("    movsx rax, byte ");
    else emit("    mov rax, qword ");
}

// Guarda rcx en el operando que sigue
void g_store_head(int t) {
    if (t == T_INT) emit("    mov dword ");
    else if (t == T_CHAR) emit("    mov byte ");
    else emit("    mov qword ");
}

void g_store_tail(int t) {
    if (t == T_INT) emit(", ecx\n");
    else if (t == T_CHAR) emit(", cl\n");
    else emit(", rcx\n");
}

// ---------- variables ----------
// N_DECL.value: > 0 global; < 0 local, con offset -value desde rbp.

void g_slot(void *d) {
    g_frame = g_frame + 8;
    node_set_value(d, 0 - g_frame);
}

void g_slots(void *n) {
    while (n != 0) {
        int k = node_kind(n);
        if (k == N_DECL || k == N_PARAM) g_slot(n);
        g_slots(node_a(n));
        g_slots(node_b(n));
        g_slots(node_c(n));
        n = node_next(n);
    }
}

void g_mem(void *d) {
    int v = node_value(d);
    if (v > 0) {
        emit("[rel _");
        emit(node_text(d));
        emit("]");
    } else {
        emit("[rbp-");
        emit_int(0 - v);
        emit("]");
    }
}

void g_store_id(int t, void *d) {
    g_line("mov rcx, rax");
    g_store_head(t);
    g_mem(d);
    g_store_tail(t);
    g_norm(t);
}

// ---------- expresiones ----------

// Deja en rax la dirección de un lvalue
void g_addr(void *n) {
    int k = node_kind(n);
    if (k == N_ID) {
        emit("    lea rax, ");
        g_mem(node_decl(n));
        emit("\n");
    } else if (k == N_UNOP) {
        g_expr(node_a(n));
    } else {
        g_expr(node_a(n));
        g_push();
        g_expr(node_b(n));
        g_scale("rax", g_size(node_type(n)));
        g_pop("rcx");
        g_line("add rax, rcx");
    }
}

// Multiplica reg por el tamaño del elemento
void g_scale(char *reg, int size) {
    if (size == 1) return;
    emit("    imul ");
    emit(reg);
    emit(", ");
    emit(reg);
    emit(", ");
    emit_int(size);
    emit("\n");
}

void g_cmp_zero() {
    g_op_imm("cmp", "rax", 0);
}

void g_assign(void *n) {
    void *l = node_a(n);
    int t = node_type(l);
    g_expr(node_b(n));
    if (node_kind(l) == N_ID) {
        g_store_id(t, node_decl(l));
        return;
    }
    g_push();
    g_addr(l);
    g_line("mov rdx, rax");
    g_pop("rax");
    g_line("mov rcx, rax");
    g_store_head(t);
    emit("[rdx]");
    g_store_tail(t);
    g_norm(t);
}

// && y ||: ls es el destino del cortocircuito
void g_logic(void *n, int op) {
    int ls = g_new_label();
    int le = g_new_label();
    char *jump = "je";
    int full = 1;
    int shortv = 0;
    if (op == T_OR) {
        jump = "jne";
        full = 0;
        shortv = 1;
    }
    g_expr(node_a(n));
    g_cmp_zero();
    g_jump(jump, ls);
    g_expr(node_b(n));
    g_cmp_zero();
    g_jump(jump, ls);
    g_op_imm("mov", "eax", full);
    g_jump("jmp", le);
    g_label_def(ls);
    g_op_imm("mov", "eax", shortv);
    g_label_def(le);
}

// Condición de salto para cada comparación; los punteros se comparan sin signo
char *g_cc(int op, int uns) {
    if (op == '<') {
        if (uns) return "b";
        return "l";
    }
    if (op == '>') {
        if (uns) return "a";
        return "g";
    }
    if (op == T_LE) {
        if (uns) return "be";
        return "le";
    }
    if (op == T_GE) {
        if (uns) return "ae";
        return "ge";
    }
    if (op == T_EQ) return "e";
    return "ne";
}

void g_compare(int op, int uns) {
    g_line("cmp rax, rcx");
    emit("    set");
    emit(g_cc(op, uns));
    emit(" al\n");
    g_line("movzx eax, al");
}

void g_add(int lt, int rt) {
    if (g_is_ptr(lt)) {
        g_scale("rcx", g_pointee(lt));
    } else if (g_is_ptr(rt)) {
        g_scale("rax", g_pointee(rt));
    }
    g_line("add rax, rcx");
    if (!g_is_ptr(lt) && !g_is_ptr(rt)) g_norm(T_INT);
}

void g_sub(int lt, int rt) {
    if (g_is_ptr(lt) && g_is_ptr(rt)) {
        g_line("sub rax, rcx");
        if (g_pointee(lt) > 1) {
            g_op_imm("mov", "rcx", g_pointee(lt));
            g_line("cqo");
            g_line("idiv rcx");
        }
        g_norm(T_INT);
    } else if (g_is_ptr(lt)) {
        g_scale("rcx", g_pointee(lt));
        g_line("sub rax, rcx");
    } else {
        g_line("sub rax, rcx");
        g_norm(T_INT);
    }
}

void g_binop(void *n) {
    int op = node_value(n);
    if (op == '=') {
        g_assign(n);
        return;
    }
    if (op == T_AND || op == T_OR) {
        g_logic(n, op);
        return;
    }
    int lt = node_type(node_a(n));
    int rt = node_type(node_b(n));
    g_expr(node_a(n));
    g_push();
    g_expr(node_b(n));
    g_line("mov rcx, rax");
    g_pop("rax");
    if (op == '+') g_add(lt, rt);
    else if (op == '-') g_sub(lt, rt);
    else if (op == '*') {
        g_line("imul rax, rcx");
        g_norm(T_INT);
    } else if (op == '/' || op == '%') {
        g_line("cqo");
        g_line("idiv rcx");
        if (op == '%') g_line("mov rax, rdx");
        g_norm(T_INT);
    } else {
        g_compare(op, g_is_ptr(lt) || g_is_ptr(rt));
    }
}

void g_unop(void *n) {
    int op = node_value(n);
    g_expr(node_a(n));
    if (op == '-') {
        g_line("neg rax");
        g_norm(T_INT);
    } else if (op == '!') {
        g_cmp_zero();
        g_line("sete al");
        g_line("movzx eax, al");
    } else if (op == '*') {
        g_line("mov rdx, rax");
        g_load_head(node_type(n));
        emit("[rdx]\n");
    }
}

// x++ / x--: el resultado es el valor anterior
void g_postfix(void *n) {
    int t = node_type(n);
    int step = 1;
    if (g_is_ptr(t)) step = g_pointee(t);
    g_addr(node_a(n));
    g_line("mov rdx, rax");
    g_load_head(t);
    emit("[rdx]\n");
    emit("    lea rcx, [rax");
    if (node_value(n) == T_DEC) emit("-");
    else emit("+");
    emit_int(step);
    emit("]\n");
    g_store_head(t);
    emit("[rdx]");
    g_store_tail(t);
}

void g_call(void *n) {
    int count = 0;
    void *a = node_a(n);
    while (a != 0) {
        g_expr(a);
        g_push();
        count = count + 1;
        a = node_next(a);
    }
    while (count > 0) {
        count = count - 1;
        g_pop(g_reg(count));
    }
    // La pila debe estar alineada a 16 bytes en el call
    int pad = g_depth % 2;
    if (pad) g_op_imm("sub", "rsp", 8);
    emit("    call _");
    emit(node_text(n));
    emit("\n");
    if (pad) g_op_imm("add", "rsp", 8);
    g_norm(node_type(n));
}

void g_expr(void *n) {
    int k = node_kind(n);
    if (k == N_NUM || k == N_CHR) {
        g_op_imm("mov", "rax", node_value(n));
    } else if (k == N_STR) {
        emit("    lea rax, [rel S");
        emit_int(node_value(n));
        emit("]\n");
    } else if (k == N_ID) {
        g_load_head(node_type(n));
        g_mem(node_decl(n));
        emit("\n");
    } else if (k == N_INDEX) {
        g_addr(n);
        g_line("mov rdx, rax");
        g_load_head(node_type(n));
        emit("[rdx]\n");
    } else if (k == N_CALL) {
        g_call(n);
    } else if (k == N_CAST) {
        g_expr(node_a(n));
        g_norm(node_type(n));
    } else if (k == N_UNOP) {
        g_unop(n);
    } else if (k == N_POSTFIX) {
        g_postfix(n);
    } else {
        g_binop(n);
    }
}

// ---------- sentencias ----------

void g_stmts(void *s) {
    while (s != 0) {
        g_stmt(s);
        s = node_next(s);
    }
}

void g_stmt(void *s) {
    int k = node_kind(s);
    if (k == N_DECL) {
        if (node_a(s) != 0) {
            g_expr(node_a(s));
            g_store_id(node_type(s), s);
        }
    } else if (k == N_EXPR_STMT) {
        g_expr(node_a(s));
    } else if (k == N_RETURN) {
        if (node_a(s) != 0) g_expr(node_a(s));
        g_jump("jmp", g_ret);
    } else if (k == N_BLOCK) {
        g_stmts(node_a(s));
    } else if (k == N_IF) {
        int lelse = g_new_label();
        g_expr(node_a(s));
        g_cmp_zero();
        g_jump("je", lelse);
        g_stmt(node_b(s));
        if (node_c(s) != 0) {
            int lend = g_new_label();
            g_jump("jmp", lend);
            g_label_def(lelse);
            g_stmt(node_c(s));
            g_label_def(lend);
        } else {
            g_label_def(lelse);
        }
    } else if (k == N_WHILE) {
        int ltop = g_new_label();
        int lend = g_new_label();
        g_label_def(ltop);
        g_expr(node_a(s));
        g_cmp_zero();
        g_jump("je", lend);
        g_stmt(node_b(s));
        g_jump("jmp", ltop);
        g_label_def(lend);
    }
}

// ---------- funciones ----------

void g_function(void *f) {
    g_depth = 0;
    g_frame = 0;
    g_slots(node_a(f));
    g_slots(node_b(f));
    int size = (g_frame + 15) / 16 * 16;
    g_ret = g_new_label();

    emit("\n; ");
    emit(type_name(node_type(f)));
    emit(" ");
    emit(node_text(f));
    emit("\nglobal _");
    emit(node_text(f));
    emit("\n_");
    emit(node_text(f));
    emit(":\n");
    g_line("push rbp");
    g_line("mov rbp, rsp");
    if (size > 0) g_op_imm("sub", "rsp", size);
    void *p = node_a(f);
    int i = 0;
    while (p != 0) {
        emit("    mov ");
        g_mem(p);
        emit(", ");
        emit(g_reg(i));
        emit("\n");
        i = i + 1;
        p = node_next(p);
    }
    g_stmts(node_a(node_b(f)));
    // Si se llega al final sin return, el valor es 0
    g_line("xor eax, eax");
    g_label_def(g_ret);
    g_line("mov rsp, rbp");
    g_line("pop rbp");
    g_line("ret");
}

// ---------- datos ----------

// Recorre todo el árbol: modo 0 numera los literales; modo 1 los emite
void g_strings(void *n, int emitting) {
    while (n != 0) {
        if (node_kind(n) == N_STR) {
            if (emitting) g_string_data(n);
            else {
                node_set_value(n, g_nstr);
                g_nstr = g_nstr + 1;
            }
        }
        g_strings(node_a(n), emitting);
        g_strings(node_b(n), emitting);
        g_strings(node_c(n), emitting);
        n = node_next(n);
    }
}

void g_string_data(void *n) {
    char *t = node_text(n);
    int open = 0;
    int first = 1;
    int i = 0;
    emit("S");
    emit_int(node_value(n));
    emit(": db ");
    while (t[i] != 0) {
        int c = t[i];
        if (c >= 32 && c < 127 && c != '"') {
            if (!open) {
                if (!first) emit(", ");
                emit("\"");
                open = 1;
            }
            emit_char(c);
        } else {
            if (open) {
                emit("\"");
                open = 0;
            }
            if (!first) emit(", ");
            if (c < 0) c = c + 256;
            emit_int(c);
        }
        first = 0;
        i = i + 1;
    }
    if (open) emit("\"");
    if (!first) emit(", ");
    emit("0\n");
}

int g_const(void *e) {
    int k = node_kind(e);
    if (k == N_UNOP) {
        if (node_value(e) == '-') return 0 - g_const(node_a(e));
        return g_const(node_a(e));
    }
    return node_value(e);
}

void g_global(void *d) {
    int t = node_type(d);
    void *init = node_a(d);
    emit("_");
    emit(node_text(d));
    emit(": ");
    if (t == T_INT) emit("dd ");
    else if (t == T_CHAR) emit("db ");
    else emit("dq ");
    if (init == 0) emit("0");
    else if (node_kind(init) == N_STR) {
        emit("S");
        emit_int(node_value(init));
    } else emit_int(g_const(init));
    emit("\n");
}

int g_defined(void *program, char *name) {
    void *it = node_a(program);
    while (it != 0) {
        if (node_kind(it) == N_FUNC && node_b(it) != 0 && str_eq(node_text(it), name)) return 1;
        it = node_next(it);
    }
    return 0;
}

// ¿Ya apareció un prototipo con este nombre antes de 'upto'?
int g_proto_before(void *program, void *upto, char *name) {
    void *it = node_a(program);
    while (it != upto) {
        if (node_kind(it) == N_FUNC && str_eq(node_text(it), name)) return 1;
        it = node_next(it);
    }
    return 0;
}

char *generate(void *program) {
    emit_reset();
    g_label = 0;
    g_nstr = 0;
    g_strings(program, 0);
    emit("; generado por tcc: NASM, sintaxis Intel, x86-64 Linux\n");

    void *it = node_a(program);
    while (it != 0) {
        if (node_kind(it) == N_FUNC && node_b(it) == 0) {
            if (!g_defined(program, node_text(it)) && !g_proto_before(program, it, node_text(it))) {
                emit("extern _");
                emit(node_text(it));
                emit("\n");
            }
        }
        it = node_next(it);
    }

    emit("\nsection .text\n");
    it = node_a(program);
    while (it != 0) {
        if (node_kind(it) == N_FUNC && node_b(it) != 0) g_function(it);
        it = node_next(it);
    }

    if (g_nstr > 0) {
        emit("\nsection .rodata\n");
        g_strings(program, 1);
    }

    emit("\nsection .data\n");
    it = node_a(program);
    while (it != 0) {
        if (node_kind(it) == N_DECL) g_global(it);
        it = node_next(it);
    }
    return emit_text();
}
