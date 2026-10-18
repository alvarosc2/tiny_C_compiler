#include "tokens.h"
#include "ast.h"
#include "runtime.h"
#include "symtab.h"
#include "sema.h"

// Prefijo s_ en todo para no chocar con libc.
int s_errors;   // errores reportados
int s_stop;     // 1 al superar el límite de errores
int s_ret;      // tipo de retorno de la función en curso

int s_expr(void *n);
void s_stmt(void *s);

// ---------- errores y mensajes ----------

void s_report(void *n, char *msg) {
    if (s_stop) return;
    s_errors = s_errors + 1;
    report_error(node_line(n), node_col(n), msg);
    if (s_errors >= 20) {
        report_error(node_line(n), node_col(n), "demasiados errores");
        s_stop = 1;
    }
}

// a 'x' c
char *s_q(char *a, char *x, char *c) {
    return str_cat(a, str_cat("'", str_cat(x, str_cat("'", c))));
}

// a 'x' b 'y'
char *s_q2(char *a, char *x, char *b, char *y) {
    return s_q(a, x, str_cat(b, s_q("", y, "")));
}

char *s_itoa(int n) {
    if (n < 10) {
        char *d = alloc(2);
        d[0] = '0' + n;
        d[1] = 0;
        return d;
    }
    return str_cat(s_itoa(n / 10), s_itoa(n % 10));
}

char *s_count(int n, char *word) {
    char *s = str_cat(s_itoa(n), str_cat(" ", word));
    if (n != 1) s = str_cat(s, "s");
    return s;
}

char *s_op_name(int k) {
    if (k == T_EQ) return "==";
    if (k == T_NE) return "!=";
    if (k == T_LE) return "<=";
    if (k == T_GE) return ">=";
    if (k == T_AND) return "&&";
    if (k == T_OR) return "||";
    if (k == T_INC) return "++";
    if (k == T_DEC) return "--";
    char *s = alloc(2);
    s[0] = k;
    s[1] = 0;
    return s;
}

// ---------- tipos ----------

char *type_name(int t) {
    if (t == TY_ERR) return "<error>";
    char *s = "void";
    int base = type_base(t);
    if (base == T_INT) s = "int";
    if (base == T_CHAR) s = "char";
    int n = type_ptrs(t);
    while (n > 0) {
        s = str_cat(s, "*");
        n = n - 1;
    }
    return s;
}

int s_is_int(int t) {
    return t == T_INT || t == T_CHAR;
}

int s_is_ptr(int t) {
    return t > 0 && type_ptrs(t) > 0;
}

int s_is_scalar(int t) {
    return s_is_int(t) || s_is_ptr(t);
}

int s_is_void_ptr(int t) {
    return t == T_VOID + TYPE_PTR_UNIT;
}

// Dos punteros son compatibles si son iguales o alguno es void*
int s_ptr_compat(int a, int b) {
    return a == b || s_is_void_ptr(a) || s_is_void_ptr(b);
}

// 0 o (puntero)0: constante de puntero nulo
int s_is_null(void *e) {
    if (node_kind(e) == N_NUM) return node_value(e) == 0;
    if (node_kind(e) == N_CAST && s_is_ptr(node_type(e))) return s_is_null(node_a(e));
    return 0;
}

// ¿Se puede asignar un valor de tipo src (expresión e) a un destino dst?
int s_assignable(int dst, int src, void *e) {
    if (dst == TY_ERR || src == TY_ERR) return 1;
    if (s_is_int(dst) && s_is_int(src)) return 1;
    if (s_is_ptr(dst) && s_is_ptr(src)) return s_ptr_compat(dst, src);
    if (s_is_ptr(dst) && s_is_int(src)) return s_is_null(e);
    return 0;
}

int s_set(void *n, int t) {
    node_set_type(n, t);
    return t;
}

int s_fail(void *n, char *msg) {
    s_report(n, msg);
    return s_set(n, TY_ERR);
}

int s_list_len(void *list) {
    int n = 0;
    while (list != 0) {
        n = n + 1;
        list = node_next(list);
    }
    return n;
}

// ---------- expresiones ----------

int s_id(void *n) {
    void *sym = sym_lookup(node_text(n));
    if (sym == 0) {
        return s_fail(n, s_q("identificador ", node_text(n), " no declarado"));
    }
    node_set_decl(n, sym_decl(sym));
    if (sym_kind(sym) == SYM_FUNC) {
        return s_fail(n, s_q("", node_text(n), " es una funcion, no una variable"));
    }
    return s_set(n, sym_type(sym));
}

int s_call(void *n) {
    char *name = node_text(n);
    void *sym = sym_lookup(name);
    void *arg = node_a(n);
    if (sym == 0 || sym_kind(sym) != SYM_FUNC) {
        while (arg != 0) {
            s_expr(arg);
            arg = node_next(arg);
        }
        if (sym == 0) return s_fail(n, s_q("funcion ", name, " no declarada"));
        return s_fail(n, s_q("", name, " no es una funcion"));
    }
    void *fn = sym_decl(sym);
    node_set_decl(n, fn);
    void *param = node_a(fn);
    int i = 1;
    while (arg != 0) {
        int at = s_expr(arg);
        if (param != 0) {
            int pt = node_type(param);
            if (!s_assignable(pt, at, arg)) {
                s_report(arg, str_cat(str_cat("argumento ", str_cat(s_itoa(i), " de ")),
                         s_q2(str_cat("'", str_cat(name, "': no se puede convertir ")),
                              type_name(at), " a ", type_name(pt))));
            }
            param = node_next(param);
        }
        arg = node_next(arg);
        i = i + 1;
    }
    int want = s_list_len(node_a(fn));
    int got = s_list_len(node_a(n));
    if (want != got) {
        s_report(n, str_cat(s_q("la funcion ", name, " espera "),
                 str_cat(s_count(want, "argumento"), str_cat(" y recibe ", s_count(got, "argumento")))));
    }
    return s_set(n, sym_type(sym));
}

int s_cast(void *n) {
    int to = node_type(n);
    int from = s_expr(node_a(n));
    if (from == TY_ERR || to == T_VOID) return to;
    if (!s_is_scalar(from)) {
        s_report(n, s_q2("no se puede convertir ", type_name(from), " a ", type_name(to)));
    }
    return to;
}

int s_unop(void *n) {
    int op = node_value(n);
    int t = s_expr(node_a(n));
    if (t == TY_ERR) return s_set(n, TY_ERR);
    if (op == '*') {
        if (!s_is_ptr(t) || s_is_void_ptr(t)) {
            return s_fail(n, s_q("no se puede desreferenciar ", type_name(t), ""));
        }
        return s_set(n, t - TYPE_PTR_UNIT);
    }
    if (op == '!') {
        if (!s_is_scalar(t)) {
            return s_fail(n, s_q("operando invalido para '!': ", type_name(t), ""));
        }
        return s_set(n, T_INT);
    }
    if (!s_is_int(t)) {
        return s_fail(n, s_q(str_cat("operando invalido para ", s_q("", s_op_name(op), ": ")),
                             type_name(t), ""));
    }
    return s_set(n, T_INT);
}

int s_lvalue(void *n) {
    int k = node_kind(n);
    if (k == N_ID || k == N_INDEX) return 1;
    return k == N_UNOP && node_value(n) == '*';
}

int s_postfix(void *n) {
    void *e = node_a(n);
    int t = s_expr(e);
    if (t == TY_ERR) return s_set(n, TY_ERR);
    char *op = s_op_name(node_value(n));
    if (!s_lvalue(e)) {
        return s_fail(n, s_q("el operando de ", op, " debe ser una variable modificable"));
    }
    if (!s_is_int(t) && !(s_is_ptr(t) && !s_is_void_ptr(t))) {
        return s_fail(n, s_q(str_cat("operando invalido para ", s_q("", op, ": ")),
                             type_name(t), ""));
    }
    return s_set(n, t);
}

int s_index(void *n) {
    int bt = s_expr(node_a(n));
    int it = s_expr(node_b(n));
    if (bt == TY_ERR || it == TY_ERR) return s_set(n, TY_ERR);
    if (!s_is_ptr(bt) || s_is_void_ptr(bt)) {
        return s_fail(n, s_q("no se puede indexar ", type_name(bt), ""));
    }
    if (!s_is_int(it)) {
        return s_fail(n, s_q("el indice debe ser entero, no ", type_name(it), ""));
    }
    return s_set(n, bt - TYPE_PTR_UNIT);
}

int s_bad_operands(void *n, int op, int lt, int rt) {
    return s_fail(n, str_cat(s_q("operandos invalidos para ", s_op_name(op), ": "),
                             s_q2("", type_name(lt), " y ", type_name(rt))));
}

int s_assign(void *n) {
    void *l = node_a(n);
    void *r = node_b(n);
    int lt = s_expr(l);
    int rt = s_expr(r);
    if (lt == TY_ERR || rt == TY_ERR) return s_set(n, TY_ERR);
    if (!s_assignable(lt, rt, r)) {
        return s_fail(n, s_q2("no se puede asignar ", type_name(rt), " a ", type_name(lt)));
    }
    return s_set(n, lt);
}

int s_binop(void *n) {
    int op = node_value(n);
    if (op == '=') return s_assign(n);
    void *l = node_a(n);
    void *r = node_b(n);
    int lt = s_expr(l);
    int rt = s_expr(r);
    if (lt == TY_ERR || rt == TY_ERR) return s_set(n, TY_ERR);

    if (op == '+' || op == '-') {
        if (s_is_int(lt) && s_is_int(rt)) return s_set(n, T_INT);
        int pt = 0;
        if (s_is_ptr(lt) && s_is_int(rt)) pt = lt;
        if (s_is_int(lt) && s_is_ptr(rt) && op == '+') pt = rt;
        if (pt != 0) {
            if (s_is_void_ptr(pt)) {
                return s_fail(n, "aritmetica sobre 'void*' no permitida");
            }
            return s_set(n, pt);
        }
        if (op == '-' && s_is_ptr(lt) && lt == rt) {
            if (s_is_void_ptr(lt)) {
                return s_fail(n, "aritmetica sobre 'void*' no permitida");
            }
            return s_set(n, T_INT);
        }
        return s_bad_operands(n, op, lt, rt);
    }
    if (op == '*' || op == '/' || op == '%') {
        if (!s_is_int(lt) || !s_is_int(rt)) return s_bad_operands(n, op, lt, rt);
        if (op != '*' && node_kind(r) == N_NUM && node_value(r) == 0) {
            s_report(r, "division entre cero");
        }
        return s_set(n, T_INT);
    }
    if (op == T_AND || op == T_OR) {
        if (!s_is_scalar(lt) || !s_is_scalar(rt)) return s_bad_operands(n, op, lt, rt);
        return s_set(n, T_INT);
    }
    // Comparaciones: enteros, punteros compatibles, o puntero contra nulo
    if (s_is_int(lt) && s_is_int(rt)) return s_set(n, T_INT);
    if (s_is_ptr(lt) && s_is_ptr(rt) && s_ptr_compat(lt, rt)) return s_set(n, T_INT);
    if (op == T_EQ || op == T_NE) {
        if (s_is_ptr(lt) && s_is_null(r)) return s_set(n, T_INT);
        if (s_is_ptr(rt) && s_is_null(l)) return s_set(n, T_INT);
    }
    return s_bad_operands(n, op, lt, rt);
}

int s_expr(void *n) {
    int k = node_kind(n);
    if (k == N_NUM || k == N_CHR) return s_set(n, T_INT);
    if (k == N_STR) return s_set(n, T_CHAR + TYPE_PTR_UNIT);
    if (k == N_ID) return s_id(n);
    if (k == N_CALL) return s_call(n);
    if (k == N_CAST) return s_cast(n);
    if (k == N_UNOP) return s_unop(n);
    if (k == N_POSTFIX) return s_postfix(n);
    if (k == N_INDEX) return s_index(n);
    return s_binop(n);
}

// ---------- declaraciones ----------

// Constante: literal, o + / - aplicado a una constante
int s_is_const(void *e) {
    int k = node_kind(e);
    if (k == N_NUM || k == N_CHR || k == N_STR) return 1;
    if (k == N_UNOP && (node_value(e) == '+' || node_value(e) == '-')) {
        return s_is_const(node_a(e));
    }
    return 0;
}

// El identificador entra en ámbito después de su inicializador
void s_decl(void *d, int global) {
    int t = node_type(d);
    char *name = node_text(d);
    node_set_value(d, global);
    if (t == T_VOID) {
        s_report(d, s_q("la variable ", name, " no puede ser de tipo void"));
    }
    void *init = node_a(d);
    if (init != 0) {
        int it = s_expr(init);
        if (global && !s_is_const(init)) {
            s_report(init, s_q("el inicializador de ", name, " debe ser una constante"));
        } else if (t != T_VOID && !s_assignable(t, it, init)) {
            s_report(init, s_q2("no se puede inicializar ", type_name(t), " con ", type_name(it)));
        }
    }
    if (sym_lookup_local(name) != 0) {
        s_report(d, s_q("", name, " ya esta declarado en este ambito"));
        return;
    }
    if (t == T_VOID) t = TY_ERR;
    sym_declare(name, t, SYM_VAR, d);
}

void s_param(void *p) {
    int t = node_type(p);
    char *name = node_text(p);
    if (t == T_VOID) {
        s_report(p, s_q("el parametro ", name, " no puede ser de tipo void"));
        t = TY_ERR;
    }
    if (sym_lookup_local(name) != 0) {
        s_report(p, s_q("", name, " ya esta declarado en este ambito"));
        return;
    }
    sym_declare(name, t, SYM_VAR, p);
}

int s_same_signature(void *a, void *b) {
    if (node_type(a) != node_type(b)) return 0;
    void *pa = node_a(a);
    void *pb = node_a(b);
    while (pa != 0 && pb != 0) {
        if (node_type(pa) != node_type(pb)) return 0;
        pa = node_next(pa);
        pb = node_next(pb);
    }
    return pa == 0 && pb == 0;
}

// ---------- sentencias ----------

void s_cond(void *e) {
    int t = s_expr(e);
    if (t != TY_ERR && !s_is_scalar(t)) {
        s_report(e, s_q("la condicion debe ser escalar, no ", type_name(t), ""));
    }
}

void s_return(void *s) {
    void *e = node_a(s);
    if (e == 0) {
        if (s_ret != T_VOID) {
            s_report(s, s_q("se esperaba un valor de retorno de tipo ", type_name(s_ret), ""));
        }
        return;
    }
    int t = s_expr(e);
    if (s_ret == T_VOID) {
        s_report(s, "una funcion void no puede retornar un valor");
        return;
    }
    if (!s_assignable(s_ret, t, e)) {
        s_report(e, s_q2("no se puede retornar ", type_name(t),
                         " en una funcion que retorna ", type_name(s_ret)));
    }
}

void s_stmts(void *s) {
    while (s != 0) {
        s_stmt(s);
        s = node_next(s);
    }
}

// Cuerpo de if/while: ámbito propio aunque no sea un bloque
void s_sub(void *s) {
    st_push();
    s_stmt(s);
    st_pop();
}

void s_stmt(void *s) {
    int k = node_kind(s);
    if (k == N_DECL) s_decl(s, 0);
    else if (k == N_EXPR_STMT) s_expr(node_a(s));
    else if (k == N_RETURN) s_return(s);
    else if (k == N_IF) {
        s_cond(node_a(s));
        s_sub(node_b(s));
        if (node_c(s) != 0) s_sub(node_c(s));
    } else if (k == N_WHILE) {
        s_cond(node_a(s));
        s_sub(node_b(s));
    } else if (k == N_BLOCK) {
        st_push();
        s_stmts(node_a(s));
        st_pop();
    }
}

// ---------- funciones y programa ----------

void s_function(void *f) {
    char *name = node_text(f);
    void *body = node_b(f);
    void *prev = sym_lookup_local(name);
    if (prev != 0) {
        if (sym_kind(prev) != SYM_FUNC) {
            s_report(f, s_q("", name, " ya esta declarado en este ambito"));
        } else {
            if (!s_same_signature(sym_decl(prev), f)) {
                s_report(f, s_q("declaracion de ", name, " en conflicto con la anterior"));
            }
            if (body != 0) {
                if (sym_defined(prev)) s_report(f, s_q("la funcion ", name, " ya esta definida"));
                sym_set_defined(prev, 1);
            }
        }
    } else {
        void *sym = sym_declare(name, node_type(f), SYM_FUNC, f);
        if (body != 0) sym_set_defined(sym, 1);
    }

    // Parámetros y cuerpo comparten ámbito
    st_push();
    void *p = node_a(f);
    while (p != 0) {
        s_param(p);
        p = node_next(p);
    }
    if (body != 0) {
        s_ret = node_type(f);
        s_stmts(node_a(body));
    }
    st_pop();
}

int analyze(void *program) {
    st_reset();
    s_errors = 0;
    s_stop = 0;
    s_ret = T_VOID;
    void *item = node_a(program);
    while (item != 0) {
        if (node_kind(item) == N_FUNC) s_function(item);
        else s_decl(item, 1);
        item = node_next(item);
    }
    return s_errors;
}
