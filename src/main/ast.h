#ifndef AST_H
#define AST_H

/* Tipos de nodo del AST */
#define N_PROGRAM   1
#define N_FUNC      2
#define N_PARAM     3
#define N_DECL      4
#define N_BLOCK     5
#define N_IF        6
#define N_WHILE     7
#define N_RETURN    8
#define N_EXPR_STMT 9
#define N_BINOP     10
#define N_UNOP      11
#define N_CAST      12
#define N_INDEX     13
#define N_POSTFIX   14
#define N_CALL      15
#define N_ID        16
#define N_STR       17
#define N_NUM       18
#define N_CHR       19

/* Layout del nodo (LP64), 72 bytes:
   kind@0 line@4 col@8 value@12 a@16 b@24 c@32 next@40 text@48 type@56 decl@64
   decl no es un hijo: lo llena el análisis semántico (N_ID y N_CALL apuntan
   a la declaración resuelta) y los recorridos del árbol lo ignoran. */
#define NODE_SIZE       72
#define NODE_LINE_OFF   4
#define NODE_COL_OFF    8
#define NODE_VALUE_OFF  12
#define NODE_A_OFF      16
#define NODE_B_OFF      24
#define NODE_C_OFF      32
#define NODE_NEXT_OFF   40
#define NODE_TEXT_OFF   48
#define NODE_TYPE_OFF   56
#define NODE_DECL_OFF   64

/* Un tipo es el tipo base (T_INT, T_CHAR, T_VOID) + 1000 por nivel de puntero */
#define TYPE_PTR_UNIT 1000

/* Tipo de una expresión con error semántico: silencia errores en cascada */
#define TY_ERR (-1)

void *node_new(int kind, int line, int col);

int node_kind(void *n);
int node_line(void *n);
int node_col(void *n);
int node_value(void *n);
void *node_a(void *n);
void *node_b(void *n);
void *node_c(void *n);
void *node_next(void *n);
char *node_text(void *n);
int node_type(void *n);
void *node_decl(void *n);

void node_set_value(void *n, int v);
void node_set_a(void *n, void *v);
void node_set_b(void *n, void *v);
void node_set_c(void *n, void *v);
void node_set_next(void *n, void *v);
void node_set_text(void *n, char *v);
void node_set_type(void *n, int v);
void node_set_decl(void *n, void *v);

int type_base(int t);
int type_ptrs(int t);

#endif
