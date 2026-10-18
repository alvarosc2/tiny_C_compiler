# Gramática mínima para un compilador C auto‑hosteable

Esta gramática está escrita en un estilo cercano a EBNF, pero simplificada para que puedas implementarla sin dolores de cabeza.

## 1. Programa

```Text
program     ::= (function | declaration)* ;
```

## 2. Funciones

```Text
function    ::= type identifier "(" parameters? ")" block ;
parameters  ::= parameter ("," parameter)* ;
parameter   ::= type identifier ;
```

## 3. Declaraciones

```Text
declaration ::= type declarator ("=" expression)? ";" ;
declarator  ::= identifier ;
```

## 4. Tipos soportados (mínimos)

```Text
type        ::= "int" | "char" | "void" | pointer_type ;
pointer_type ::= type "*" ;
```

Con esto ya puedes implementar punteros, que son esenciales para manejar memoria, strings y estructuras internas del compilador.

## 5. Bloques y sentencias

```Text
block       ::= "{" statement* "}" ;

statement   ::= declaration
              | expression ";"
              | return_statement
              | if_statement
              | while_statement
              | block ;

return_statement ::= "return" expression? ";" ;

if_statement     ::= "if" "(" expression ")" statement ("else" statement)? ;

while_statement  ::= "while" "(" expression ")" statement ;
```

## 6. Expresiones

```Text
expression  ::= assignment ;

assignment  ::= logical_or ("=" assignment)? ;

logical_or  ::= logical_and ("||" logical_and)* ;
logical_and ::= equality ("&&" equality)* ;
equality    ::= relational (("==" | "!=") relational)* ;
relational  ::= additive (("<" | ">" | "<=" | ">=") additive)* ;
additive    ::= multiplicative (("+" | "-") multiplicative)* ;
multiplicative ::= unary (("*" | "/" | "%") unary)* ;

unary       ::= ("+" | "-" | "!" | "*") unary
              | primary ;

primary     ::= identifier
              | number
              | string_literal
              | "(" expression ")"
              | function_call ;

function_call ::= identifier "(" arguments? ")" ;
arguments      ::= expression ("," expression)* ;
```

## 7. Tokens básicos

```Text
identifier      ::= [a-zA-Z_][a-zA-Z0-9_]* ;
number          ::= [0-9]+ ;
string_literal  ::= "\"" .*? "\"" ;
char_literal    ::= "'" ( [^'\\] | "\\" [nrt0'\\] ) "'" ;
```

## 8. Subconjunto para bootstrap

Para que el compilador pueda compilarse a sí mismo, el código de `src/main/` debe escribirse **solo** con lo que la gramática (secciones 1‑7 más las extensiones de abajo) soporta. Los tests (`src/test/`) y `main.c` quedan fuera: se compilan siempre con gcc.

### 8.1 Preprocesado externo

El compilador no implementa preprocesador. Antes de compilar, `make selfhost` ejecuta `cpp -P` sobre cada `.c`, lo que resuelve `#include`, `#define` (por ejemplo `tokens.h`) y elimina los comentarios. Por eso `enum`, `static` y `struct` quedan fuera del código fuente del compilador.

### 8.2 Extensiones mínimas a la gramática

```Text
declaration ::= type declarator ("=" expression)? ";"
              | type identifier "(" parameters? ")" ";" ;     /* prototipo */

type        ::= "int" | "char" | "void" | pointer_type ;       /* sin cambios */

unary       ::= ("+" | "-" | "!" | "*") unary
              | "(" type ")" unary                              /* cast */
              | postfix ;

postfix     ::= primary ("[" expression "]" | "++" | "--")* ;

primary     ::= identifier | number | string_literal | char_literal
              | "(" expression ")" | function_call ;
```

| Extensión | Motivo |
|-----------|--------|
| Prototipos | Declarar funciones externas (`alloc`, `memcpy`, `isalpha`, ...) sin `#include` de libc. |
| Cast `(type) expr` | Leer/escribir campos de token: `*(int *)(p + 8) = x`. |
| `p[i]` | Acceso a `src[pos]`. Equivale a `*(p + i)`. |
| `++` / `--` postfijos | Usados en `advance()` (`src[pos++]`). |
| `char_literal` | `'"'`, `'_'`, `'\n'`, `'0'`. Valor de tipo `int`. |
| Tokens extra | `[`, `]`, `++`, `--`, `'...'` en el lexer. |

### 8.3 Restricciones de estilo para el código del compilador

- Solo `int`, `char`, `void` y punteros. Sin `struct`, `enum`, `union`, `typedef`, `static`, `const`.
- Constantes con `#define` (ver `src/main/tokens.h`).
- Estructuras de datos como bloques de memoria con offsets fijos (ej. token: `kind@0`, `text@8`, `value@16`, tamaño 24).
- Sin `for`, `do`, `switch`, `break`, `continue`, `&`, `|`, `?:`: usar `while`/`if`.
- Variables globales declaradas con tipo e inicializador opcional constante.
- Un solo archivo de salida por compilación; el enlazado lo hace `cc`/`ld`.

### 8.4 ABI objetivo

`int` de 4 bytes, `char` de 1, punteros de 8 (LP64, x86‑64 Linux). Los tests con gcc y el compilador propio deben coincidir en estos tamaños.

### 8.5 Etapas de bootstrap

1. **Stage 0**: gcc compila `src/main/` → `build/tcc`.
2. **Stage 1**: `build/tcc` compila `src/main/` → `build/tcc1`.
3. **Stage 2**: `build/tcc1` compila `src/main/` → `build/tcc2`.
4. Criterio de éxito: `tcc1` y `tcc2` producen salida idéntica y pasan los mismos tests.
