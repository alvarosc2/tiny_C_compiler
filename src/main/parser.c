#include "tokens.h"
#include "lexer.h"
#include "ast.h"
#include "runtime.h"
#include "parser.h"

// Estado del parser. Todo lleva prefijo p_ para no chocar con libc.
void *p_cur;     // token actual
int p_count;     // tokens consumidos
int p_last_err;  // valor de p_count en el último error (suprime cascadas)
int p_errors;    // errores reportados
int p_stop;      // 1 al superar el límite de errores

void *p_expression();
void *p_assignment();
void *p_unary();
void *p_statement();
void *p_block();

// ---------- tokens y errores ----------

int p_kind() {
    if (p_stop) return T_EOF;
    return token_kind(p_cur);
}

char *p_token_name(int k) {
    if (k == T_EOF) return "fin de archivo";
    if (k == T_ID) return "identificador";
    if (k == T_NUM) return "numero";
    if (k == T_STR) return "cadena";
    if (k == T_CHRLIT) return "caracter";
    if (k == T_INT) return "'int'";
    if (k == T_CHAR) return "'char'";
    if (k == T_VOID) return "'void'";
    if (k == T_RETURN) return "'return'";
    if (k == T_IF) return "'if'";
    if (k == T_ELSE) return "'else'";
    if (k == T_WHILE) return "'while'";
    if (k == T_EQ) return "'=='";
    if (k == T_NE) return "'!='";
    if (k == T_LE) return "'<='";
    if (k == T_GE) return "'>='";
    if (k == T_AND) return "'&&'";
    if (k == T_OR) return "'||'";
    if (k == T_INC) return "'++'";
    if (k == T_DEC) return "'--'";
    char *s = alloc(4);
    s[0] = '\'';
    s[1] = k;
    s[2] = '\'';
    s[3] = 0;
    return s;
}

// Descripción del token actual para los mensajes
char *p_found() {
    int k = p_kind();
    if (k == T_ID) return str_cat("identificador '", str_cat(token_text(p_cur), "'"));
    return p_token_name(k);
}

void p_report(int line, int col, char *msg) {
    report_error(line, col, msg);
    p_errors = p_errors + 1;
    p_last_err = p_count;
    if (p_errors >= 20) {
        report_error(line, col, "demasiados errores");
        p_stop = 1;
    }
}

// Solo un error por posición de token: evita errores en cascada
void p_error(char *msg) {
    if (p_stop) return;
    if (p_count == p_last_err) return;
    p_report(token_line(p_cur), token_col(p_cur), msg);
}

void p_expected(char *what) {
    p_error(str_cat("se esperaba ", str_cat(what, str_cat(" y se encontro ", p_found()))));
}

// Siguiente token del lexer; los T_ERROR se reportan aquí y nunca llegan al parser
void *p_fetch() {
    void *t = next_token();
    while (token_kind(t) == T_ERROR) {
        p_report(token_line(t), token_col(t), token_text(t));
        t = next_token();
    }
    return t;
}

void p_next() {
    if (p_kind() == T_EOF) return;
    p_count = p_count + 1;
    p_cur = p_fetch();
}

int p_expect(int k) {
    if (p_kind() == k) {
        p_next();
        return 1;
    }
    p_expected(p_token_name(k));
    return 0;
}

void *p_node(int kind) {
    return node_new(kind, token_line(p_cur), token_col(p_cur));
}

int p_is_type(int k) {
    return k == T_INT || k == T_CHAR || k == T_VOID;
}

// ---------- tipos ----------

int p_stars(int base) {
    int t = base;
    while (p_kind() == '*') {
        t = t + TYPE_PTR_UNIT;
        p_next();
    }
    return t;
}

int p_type() {
    int base = p_kind();
    p_next();
    return p_stars(base);
}

// ---------- expresiones ----------

void *p_primary() {
    int k = p_kind();
    int line = token_line(p_cur);
    int col = token_col(p_cur);
    if (k == T_NUM) {
        void *n = node_new(N_NUM, line, col);
        node_set_value(n, token_value(p_cur));
        p_next();
        return n;
    }
    if (k == T_CHRLIT) {
        void *n = node_new(N_CHR, line, col);
        node_set_value(n, token_value(p_cur));
        p_next();
        return n;
    }
    if (k == T_STR) {
        void *n = node_new(N_STR, line, col);
        node_set_text(n, token_text(p_cur));
        p_next();
        return n;
    }
    if (k == T_ID) {
        char *name = token_text(p_cur);
        p_next();
        if (p_kind() != '(') {
            void *n = node_new(N_ID, line, col);
            node_set_text(n, name);
            return n;
        }
        void *call = node_new(N_CALL, line, col);
        node_set_text(call, name);
        p_next();
        void *head = 0;
        void *tail = 0;
        if (p_kind() != ')') {
            int more = 1;
            while (more) {
                void *arg = p_assignment();
                if (arg == 0) return 0;
                if (head == 0) head = arg;
                else node_set_next(tail, arg);
                tail = arg;
                if (p_kind() == ',') p_next();
                else more = 0;
            }
        }
        if (!p_expect(')')) return 0;
        node_set_a(call, head);
        return call;
    }
    p_error(str_cat("se esperaba una expresion y se encontro ", p_found()));
    return 0;
}

void *p_postfix(void *e) {
    int more = 1;
    while (more) {
        int k = p_kind();
        if (k == '[') {
            void *n = p_node(N_INDEX);
            p_next();
            void *idx = p_expression();
            if (idx == 0) return 0;
            if (!p_expect(']')) return 0;
            node_set_a(n, e);
            node_set_b(n, idx);
            e = n;
        } else if (k == T_INC || k == T_DEC) {
            void *n = p_node(N_POSTFIX);
            node_set_value(n, k);
            p_next();
            node_set_a(n, e);
            e = n;
        } else {
            more = 0;
        }
    }
    return e;
}

void *p_unary() {
    int k = p_kind();
    if (k == '+' || k == '-' || k == '!' || k == '*') {
        void *n = p_node(N_UNOP);
        node_set_value(n, k);
        p_next();
        void *operand = p_unary();
        if (operand == 0) return 0;
        node_set_a(n, operand);
        return n;
    }
    if (k == '(') {
        // Tras '(' un tipo indica cast; si no, es una expresión entre paréntesis
        void *n = p_node(N_CAST);
        p_next();
        if (p_is_type(p_kind())) {
            node_set_type(n, p_type());
            if (!p_expect(')')) return 0;
            void *operand = p_unary();
            if (operand == 0) return 0;
            node_set_a(n, operand);
            return n;
        }
        void *inner = p_expression();
        if (inner == 0) return 0;
        if (!p_expect(')')) return 0;
        return p_postfix(inner);
    }
    void *e = p_primary();
    if (e == 0) return 0;
    return p_postfix(e);
}

// Niveles: 0 ||, 1 &&, 2 igualdad, 3 relacional, 4 aditivo, 5 multiplicativo
int p_level_op(int level, int k) {
    if (level == 0) return k == T_OR;
    if (level == 1) return k == T_AND;
    if (level == 2) return k == T_EQ || k == T_NE;
    if (level == 3) return k == '<' || k == '>' || k == T_LE || k == T_GE;
    if (level == 4) return k == '+' || k == '-';
    return k == '*' || k == '/' || k == '%';
}

void *p_binary(int level) {
    if (level == 6) return p_unary();
    void *left = p_binary(level + 1);
    while (left != 0 && p_level_op(level, p_kind())) {
        void *n = p_node(N_BINOP);
        node_set_value(n, p_kind());
        p_next();
        void *right = p_binary(level + 1);
        if (right == 0) return 0;
        node_set_a(n, left);
        node_set_b(n, right);
        left = n;
    }
    return left;
}

int p_is_lvalue(void *n) {
    int k = node_kind(n);
    if (k == N_ID || k == N_INDEX) return 1;
    return k == N_UNOP && node_value(n) == '*';
}

void *p_assignment() {
    void *left = p_binary(0);
    if (left == 0) return 0;
    if (p_kind() != '=') return left;
    void *n = p_node(N_BINOP);
    node_set_value(n, '=');
    if (!p_is_lvalue(left)) p_error("el lado izquierdo de '=' no es asignable");
    p_next();
    void *right = p_assignment();
    if (right == 0) return 0;
    node_set_a(n, left);
    node_set_b(n, right);
    return n;
}

void *p_expression() {
    return p_assignment();
}

// ---------- declaraciones y sentencias ----------

// Después de "type identifier": ("=" expression)? ";"
void *p_decl_rest(int line, int col, int type, char *name) {
    void *d = node_new(N_DECL, line, col);
    node_set_type(d, type);
    node_set_text(d, name);
    if (p_kind() == '=') {
        p_next();
        void *init = p_expression();
        if (init == 0) return 0;
        node_set_a(d, init);
    }
    if (!p_expect(';')) return 0;
    return d;
}

void *p_local_decl() {
    int line = token_line(p_cur);
    int col = token_col(p_cur);
    int type = p_type();
    if (p_kind() != T_ID) {
        p_expected("un identificador");
        return 0;
    }
    char *name = token_text(p_cur);
    p_next();
    return p_decl_rest(line, col, type, name);
}

// Salta hasta después de ';' o antes de '}'
void p_sync_stmt() {
    int done = 0;
    while (!done) {
        int k = p_kind();
        if (k == T_EOF || k == '}') done = 1;
        else if (k == ';') {
            p_next();
            done = 1;
        } else p_next();
    }
}

void *p_block() {
    void *b = p_node(N_BLOCK);
    p_next();
    void *head = 0;
    void *tail = 0;
    while (p_kind() != '}' && p_kind() != T_EOF) {
        void *s = p_statement();
        if (s == 0) {
            p_sync_stmt();
        } else {
            if (head == 0) head = s;
            else node_set_next(tail, s);
            tail = s;
        }
    }
    p_expect('}');
    node_set_a(b, head);
    return b;
}

void *p_statement() {
    int k = p_kind();
    if (p_is_type(k)) return p_local_decl();
    if (k == '{') return p_block();
    if (k == T_RETURN) {
        void *r = p_node(N_RETURN);
        p_next();
        if (p_kind() != ';') {
            void *e = p_expression();
            if (e == 0) return 0;
            node_set_a(r, e);
        }
        if (!p_expect(';')) return 0;
        return r;
    }
    if (k == T_IF) {
        void *n = p_node(N_IF);
        p_next();
        if (!p_expect('(')) return 0;
        void *cond = p_expression();
        if (cond == 0) return 0;
        if (!p_expect(')')) return 0;
        void *then_s = p_statement();
        if (then_s == 0) return 0;
        node_set_a(n, cond);
        node_set_b(n, then_s);
        if (p_kind() == T_ELSE) {
            p_next();
            void *else_s = p_statement();
            if (else_s == 0) return 0;
            node_set_c(n, else_s);
        }
        return n;
    }
    if (k == T_WHILE) {
        void *n = p_node(N_WHILE);
        p_next();
        if (!p_expect('(')) return 0;
        void *cond = p_expression();
        if (cond == 0) return 0;
        if (!p_expect(')')) return 0;
        void *body = p_statement();
        if (body == 0) return 0;
        node_set_a(n, cond);
        node_set_b(n, body);
        return n;
    }
    void *n = p_node(N_EXPR_STMT);
    void *e = p_expression();
    if (e == 0) return 0;
    if (!p_expect(';')) return 0;
    node_set_a(n, e);
    return n;
}

// ---------- funciones y programa ----------

// Parámetros, ya consumido '('. Termina antes de ')'. "void" solo = sin parámetros
void *p_params() {
    void *head = 0;
    void *tail = 0;
    int more = 1;
    while (more) {
        if (!p_is_type(p_kind())) {
            p_expected("un tipo");
            return head;
        }
        void *prm = p_node(N_PARAM);
        int base = p_kind();
        p_next();
        if (base == T_VOID && head == 0 && p_kind() == ')') return 0;
        node_set_type(prm, p_stars(base));
        if (head == 0) head = prm;
        else node_set_next(tail, prm);
        tail = prm;
        if (p_kind() != T_ID) {
            p_expected("un identificador");
            return head;
        }
        node_set_text(prm, token_text(p_cur));
        p_next();
        if (p_kind() == ',') p_next();
        else more = 0;
    }
    return head;
}

// Después de "type identifier", con '(' como token actual
void *p_function(int line, int col, int type, char *name) {
    void *f = node_new(N_FUNC, line, col);
    node_set_type(f, type);
    node_set_text(f, name);
    p_next();
    if (p_kind() != ')') node_set_a(f, p_params());
    p_expect(')');
    if (p_kind() == ';') {
        p_next();
        return f;
    }
    if (p_kind() == '{') {
        node_set_b(f, p_block());
        return f;
    }
    p_expected("'{' o ';'");
    return f;
}

void *p_external() {
    int line = token_line(p_cur);
    int col = token_col(p_cur);
    int type = p_type();
    if (p_kind() != T_ID) {
        p_expected("un identificador");
        return 0;
    }
    char *name = token_text(p_cur);
    p_next();
    if (p_kind() == '(') return p_function(line, col, type, name);
    return p_decl_rest(line, col, type, name);
}

void p_sync_top() {
    while (p_kind() != T_EOF && !p_is_type(p_kind())) p_next();
}

void *parse(char *source) {
    lexer_init(source);
    error_log_reset();
    p_count = 0;
    p_last_err = 0 - 1;
    p_errors = 0;
    p_stop = 0;
    p_cur = p_fetch();

    void *prog = node_new(N_PROGRAM, 1, 1);
    void *head = 0;
    void *tail = 0;
    while (p_kind() != T_EOF) {
        if (p_is_type(p_kind())) {
            void *item = p_external();
            if (item == 0) {
                p_sync_top();
            } else {
                if (head == 0) head = item;
                else node_set_next(tail, item);
                tail = item;
            }
        } else {
            p_error(str_cat("se esperaba una declaracion o funcion y se encontro ", p_found()));
            p_next();
            p_sync_top();
        }
    }
    node_set_a(prog, head);
    return prog;
}

int parse_error_count() {
    return p_errors;
}
