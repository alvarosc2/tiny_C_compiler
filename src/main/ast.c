#include "ast.h"
#include "runtime.h"

void *node_new(int kind, int line, int col) {
    char *p = alloc(NODE_SIZE);
    *(int *)(p + 0) = kind;
    *(int *)(p + NODE_LINE_OFF) = line;
    *(int *)(p + NODE_COL_OFF) = col;
    return p;
}

int node_kind(void *n) { return *(int *)((char *)n + 0); }
int node_line(void *n) { return *(int *)((char *)n + NODE_LINE_OFF); }
int node_col(void *n) { return *(int *)((char *)n + NODE_COL_OFF); }
int node_value(void *n) { return *(int *)((char *)n + NODE_VALUE_OFF); }
void *node_a(void *n) { return *(void **)((char *)n + NODE_A_OFF); }
void *node_b(void *n) { return *(void **)((char *)n + NODE_B_OFF); }
void *node_c(void *n) { return *(void **)((char *)n + NODE_C_OFF); }
void *node_next(void *n) { return *(void **)((char *)n + NODE_NEXT_OFF); }
char *node_text(void *n) { return *(char **)((char *)n + NODE_TEXT_OFF); }
int node_type(void *n) { return *(int *)((char *)n + NODE_TYPE_OFF); }
void *node_decl(void *n) { return *(void **)((char *)n + NODE_DECL_OFF); }

void node_set_value(void *n, int v) { *(int *)((char *)n + NODE_VALUE_OFF) = v; }
void node_set_a(void *n, void *v) { *(void **)((char *)n + NODE_A_OFF) = v; }
void node_set_b(void *n, void *v) { *(void **)((char *)n + NODE_B_OFF) = v; }
void node_set_c(void *n, void *v) { *(void **)((char *)n + NODE_C_OFF) = v; }
void node_set_next(void *n, void *v) { *(void **)((char *)n + NODE_NEXT_OFF) = v; }
void node_set_text(void *n, char *v) { *(char **)((char *)n + NODE_TEXT_OFF) = v; }
void node_set_type(void *n, int v) { *(int *)((char *)n + NODE_TYPE_OFF) = v; }
void node_set_decl(void *n, void *v) { *(void **)((char *)n + NODE_DECL_OFF) = v; }

int type_base(int t) { return t - t / TYPE_PTR_UNIT * TYPE_PTR_UNIT; }
int type_ptrs(int t) { return t / TYPE_PTR_UNIT; }
