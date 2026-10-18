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
type        ::= ("int" | "char" | "void") "*"* ;
```

Los punteros se expresan con `"*"*` en lugar de la regla recursiva por la izquierda `pointer_type ::= type "*"`, que un parser descendente no puede implementar directamente.

Con esto ya puedes implementar punteros, que son esenciales para manejar memoria, strings y estructuras internas del compilador.

## 5. Bloques y sentencias

```Text
block       ::= "{" statement* "}" ;

statement   ::= declaration
              | simple ;

simple      ::= expression ("=" expression)? ";"       /* la asignación solo existe como sentencia */
              | return_statement
              | if_statement
              | while_statement ;

body        ::= block | simple ;                        /* cuerpo de if/while: sin declaraciones */

return_statement ::= "return" expression? ";" ;

if_statement     ::= "if" "(" expression ")" body ("else" body)? ;

while_statement  ::= "while" "(" expression ")" body ;
```

## 6. Expresiones

```Text
expression  ::= logical_or ;

logical_or  ::= logical_and ("||" logical_and)* ;
logical_and ::= equality ("&&" equality)* ;
equality    ::= relational (("==" | "!=") relational)* ;
relational  ::= additive (("<" | ">" | "<=" | ">=") additive)* ;
additive    ::= multiplicative (("+" | "-") multiplicative)* ;
multiplicative ::= unary (("*" | "/") unary)* ;

unary       ::= ("!" | "*") unary
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
string_literal  ::= "\"" (escape | [^"\\])* "\"" ;   /* escapes: \n \t \r \\ \" ; otro \x produce x */
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

unary       ::= ("!" | "*") unary
              | "(" type ")" unary                              /* cast */
              | primary ;

primary     ::= identifier | number | string_literal | char_literal
              | "(" expression ")" | function_call ;
```

| Extensión | Motivo |
|-----------|--------|
| Prototipos | Declarar funciones externas (`alloc`, `memcpy`, `isalpha`, ...) sin `#include` de libc. |
| Cast `(type) expr` | Leer/escribir campos de token: `*(int *)(p + 8) = x`. |
| `char_literal` | `'"'`, `'_'`, `'\n'`, `'0'`. Valor de tipo `int`. |
| Tokens extra | `'...'` en el lexer. |

### 8.3 Restricciones de estilo para el código del compilador

- Solo `int`, `char`, `void` y punteros. Sin `struct`, `enum`, `union`, `typedef`, `static`, `const`.
- Constantes con `#define` (ver `src/main/tokens.h`).
- Estructuras de datos como bloques de memoria con offsets fijos (ej. token: `kind@0`, `text@8`, `value@16`, tamaño 24).
- Sin `for`, `do`, `switch`, `break`, `continue`, `&`, `|`, `?:`: usar `while`/`if`.

### 8.3.1 Construcciones eliminadas en la revisión de la gramática

Medidas sobre el AST del propio compilador, estas construcciones no aportaban nada, así que se quitaron. Todas dan error de sintaxis:

| Eliminado | Se escribe como |
|-----------|-----------------|
| `p[i]` | `*(p + i)` |
| `x++`, `x--` | `x = x + 1`, `x = x - 1` |
| `a % b` | `a - a / b * b` |
| `-x`, `+x` unarios | `0 - x` |
| `f(void)` | `f()` |
| asignación dentro de expresiones (`a = b = c`, `f(a = 1)`) | una sentencia por asignación |
| bloque suelto `{ ... }` como sentencia | solo como cuerpo de función, `if` o `while` |
| declaración como cuerpo de `if`/`while` sin llaves | usar `{ ... }` |

Los caracteres `[`, `]` y `%` siguen siendo tokens del lexer, pero el parser los rechaza.
- Variables globales declaradas con tipo e inicializador opcional constante.
- Un solo archivo de salida por compilación; el enlazado lo hace `cc`/`ld`.

### 8.4 ABI objetivo

`int` de 4 bytes, `char` de 1, punteros de 8 (LP64, x86‑64 Linux). Los tests con gcc y el compilador propio deben coincidir en estos tamaños.

### 8.5 Etapas de bootstrap

1. **Stage 0**: gcc compila `src/main/` → `build/tcc`.
2. **Stage 1**: `build/tcc` compila `src/main/` → `build/tcc1`.
3. **Stage 2**: `build/tcc1` compila `src/main/` → `build/tcc2`.
4. Criterio de éxito: `tcc1` y `tcc2` producen salida idéntica y pasan los mismos tests.

## 9. Especificación del parser

El parser consume el flujo de tokens del lexer (`next_token()`), valida que siga la gramática de las secciones 1‑8 y construye un árbol de sintaxis abstracta (AST). No comprueba tipos ni declaraciones: eso corresponde al análisis semántico.

### 9.1 Método

Descenso recursivo con un token de anticipación (`peek`). Hay una función por regla de la gramática.

- **Función o declaración:** ambas empiezan con `type identifier`. Tras leerlos, `(` indica función o prototipo; `=` o `;` indica declaración.
- **Cast o paréntesis:** tras `(`, si el siguiente token es `int`, `char` o `void` es un cast; si no, es una expresión entre paréntesis.
- **Llamada:** un `identifier` seguido de `(`.
- **Niveles binarios** (`||` hasta `*`): un bucle `while` por nivel, con asociatividad izquierda.
- **Asignación:** solo como sentencia (`expression "=" expression ";"`). El lado izquierdo debe ser un l‑value: `N_ID` o `N_UNOP` con `*`. Si no, es un error. Se representa como `N_EXPR_STMT` con un `N_BINOP '='`.
- **Cuerpo de `if`/`while`:** un bloque o una sentencia simple; nunca una declaración.

### 9.2 Nodos del AST

Todos los nodos miden 72 bytes y usan offsets fijos (LP64), igual que los tokens:

```Text
kind@0  line@4  col@8  value@12  a@16  b@24  c@32  next@40  text@48  type@56  decl@64
```

`decl` lo rellena el análisis semántico (sección 10); no es un hijo y los recorridos lo ignoran.

| Nodo | Campos |
|------|--------|
| `N_PROGRAM` | `a` = primera función o declaración |
| `N_FUNC` | `text` = nombre, `type` = retorno, `a` = parámetros, `b` = bloque (nulo en un prototipo) |
| `N_PARAM`, `N_DECL` | `text` = nombre, `type`, `a` = inicializador (puede ser nulo). En `N_DECL`, `value` = 1 si es global (tras sema) |
| `N_BLOCK` | `a` = primera sentencia |
| `N_IF` | `a` = condición, `b` = then, `c` = else (puede ser nulo) |
| `N_WHILE` | `a` = condición, `b` = cuerpo |
| `N_RETURN` | `a` = expresión (puede ser nula) |
| `N_EXPR_STMT` | `a` = expresión |
| `N_BINOP` | `value` = token del operador, `a` = izquierda, `b` = derecha |
| `N_UNOP` | `value` = token del operador, `a` = operando |
| `N_CAST` | `type` = tipo destino, `a` = operando |
| `N_CALL` | `text` = nombre, `a` = primer argumento |
| `N_ID`, `N_STR` | `text` |
| `N_NUM`, `N_CHR` | `value` |

Las listas (sentencias, parámetros, argumentos y elementos del programa) se enlazan con `next`. `line` y `col` se copian del token que origina el nodo.

### 9.3 Representación de tipos

`type` es un entero: el tipo base (`T_INT`, `T_CHAR` o `T_VOID`) más el nivel de punteros multiplicado por 1000. Por ejemplo, `char *` es `T_CHAR + 1000`.

### 9.4 Errores

El parser reporta **varios errores** en una sola pasada, con recuperación en modo pánico:

- Formato: `archivo:línea:columna: error: mensaje`, por ejemplo `se esperaba ')' y se encontro ';'`. Los mensajes van sin acentos, igual que los del lexer.
- Un token `T_ERROR` del lexer se reporta con su propio mensaje y no genera un segundo error.
- Tras un error, el parser descarta tokens hasta un punto de sincronización:
  - dentro de un bloque: después de `;`, o antes de `}`;
  - a nivel de programa: antes de la siguiente palabra clave de tipo.
- No se reportan errores derivados mientras se sincroniza: tras un error, se suprimen los siguientes hasta consumir al menos un token.
- El número de errores se acumula. Si es mayor que cero, `parse` devuelve el árbol pero el compilador termina con código de salida 1 sin generar código.
- Límite de 20 errores; después se detiene con el mensaje `demasiados errores`.

### 9.5 Interfaz

```Text
void *parse(char *source);     /* devuelve N_PROGRAM, nunca nulo */
int   parse_error_count();     /* errores acumulados */
```

- Los nodos se manipulan con `node_new`, `node_kind`, `node_a`, `node_b`, `node_c`, `node_next`, `node_text`, `node_value`, `node_type`, `node_line`, `node_col` y los `node_set_*` correspondientes (`ast.h`).
- Los errores se emiten con `report_error(línea, col, mensaje)` (`runtime.h`), que escribe en stderr y los acumula en `error_log()`. `set_source_name` fija el nombre de archivo mostrado.
- Todas las funciones internas del parser llevan el prefijo `p_` para no chocar con símbolos de libc.
- Los `T_ERROR` del lexer se reportan al leerlos y nunca llegan a las reglas del parser.
- Las funciones de análisis devuelven nulo al fallar; bloques y programa siempre devuelven un nodo.

Uso desde la línea de comandos:

```Text
tcc archivo.c            análisis sintáctico y semántico; reporta errores (código de salida 1 si hay)
tcc --tokens archivo.c   volcado de tokens        (make lex)
tcc --ast archivo.c      volcado del AST con sangría y línea:columna   (make ast)
tcc --types archivo.c    análisis semántico y AST con tipos            (make types)
tcc --asm archivo.c      ensamblador NASM (sección 11)                 (make asm)
```

### 9.6 Fuera de alcance

`for`, `do`, `switch`, `break`, `continue`, `struct`, `enum` y arreglos declarados quedan excluidos. La gramática ya se revisó y simplificó: ver la sección 8.3.1 para las construcciones eliminadas.

## 10. Análisis semántico

### 10.1 Interfaz

```Text
int   analyze(void *program);  /* devuelve el número de errores */
char *type_name(int t);        /* "int", "char*", "<error>" */
```

`analyze` recorre el AST tras un `parse` sin errores. Escribe en cada expresión su tipo (`node_type`; `N_CAST` conserva el tipo destino), guarda en `decl` de cada `N_ID` y `N_CALL` la declaración resuelta, y marca `N_DECL.value` = 1 si es global. `TY_ERR` (-1) es el tipo de una expresión errónea y silencia errores derivados. Si hay errores de sintaxis, el compilador no ejecuta el análisis semántico. Misma política de errores que el parser (varios errores, límite de 20, sin acentos). El código vive en `symtab.c` (tabla de símbolos con ámbitos) y `sema.c` (prefijo `s_`), dentro del subconjunto de la sección 8.

### 10.2 Ámbitos

- Los globales viven en el ámbito 0. Parámetros y cuerpo de una función comparten ámbito; cada bloque de `if`/`while` abre uno nuevo.
- Todo se declara antes de usarse; las funciones externas necesitan prototipo.
- Redeclarar un nombre en el mismo ámbito es error; ocultar uno de un ámbito exterior es válido.
- El inicializador de una variable local se analiza **antes** de declararla (`int a = a;` usa el `a` exterior). Es una desviación respecto a C.
- Una variable o parámetro de tipo `void` es error.

### 10.3 Tipos

| Expresión | Tipo |
|-----------|------|
| `N_NUM`, `N_CHR` | `int` |
| `N_STR` | `char*` |
| `int`/`char` entre sí con `+ - * /` | `int` |
| `puntero ± int`, `int + puntero` | el del puntero |
| `puntero - puntero` (mismo tipo) | `int` |
| `< > <= >= == != && \|\| !` | `int` |
| `*p` | tipo apuntado (`p` no puede ser `void*`) |
| llamada | tipo de retorno |
| asignación (sentencia) | tipo del lado izquierdo |

Aritmética sobre `void*`, `puntero + puntero` y `* /` con punteros son errores. `/` con una constante `0` es error `division entre cero`.

**Asignabilidad** (asignación, inicialización, argumentos y `return`): `int` y `char` son intercambiables; puntero a puntero si son iguales o alguno es `void*`; puntero ← `int` solo con la constante nula (`0` o `(puntero)0`); `int` ← puntero es error. Las comparaciones aceptan enteros, punteros compatibles o puntero contra constante nula. Las condiciones de `if`/`while` deben ser escalares (entero o puntero).

### 10.4 Funciones

- Usar el nombre de una función como valor, o llamar a algo que no es función, es error.
- Se verifican la cantidad y los tipos de los argumentos.
- Un prototipo seguido de una definición con la misma firma es válido; firma distinta: `declaracion de 'f' en conflicto con la anterior`; dos cuerpos: `la funcion 'f' ya esta definida`.
- `return` debe ser coherente con el tipo de la función: una función `void` no retorna valor y una no-`void` exige uno.
- El inicializador de un global debe ser constante (literal, o `+`/`-` aplicado a uno).

### 10.5 Verificación del propio compilador

`make selfcheck` preprocesa con `cpp -P` los fuentes del compilador (`lexer`, `ast`, `symtab`, `sema`, `parser`) y los pasa por `tcc`, comprobando que el código cumple el subconjunto y supera su propio análisis semántico.

## 11. Generación de código

### 11.1 Salida y herramientas

`generate(program)` (`codegen.c`) recibe un AST sin errores y devuelve ensamblador **NASM, sintaxis Intel, x86-64 Linux**, pensado para leerse. `tcc --asm` lo escribe en la salida estándar.

```Text
fuente.c -> cpp -P -> tcc --asm -> nasm -f elf64 -> ld -> ejecutable
                                                    ^
                                   build/runtime/start.o + lib.o
```

- No se usa libc ni el enlazador dinámico: se enlaza con `ld` directamente y el punto de entrada es `_start` (`src/runtime/start.asm`).
- `scripts/cc.sh entrada.c salida` ejecuta toda la cadena y deja `salida.i`, `salida.s` y `salida.o` para inspeccionarlos (`make exe FILE=... OUT=...`).
- Todos los símbolos de C se emiten con prefijo `_` (`main` es `_main`) para no chocar con registros ni mnemónicos de NASM. Las etiquetas internas son `L<n>` (control de flujo) y `S<n>` (cadenas), que no pueden coincidir con símbolos de C.

### 11.2 Runtime propio (`src/runtime/`)

Sin dependencia de la libc: lo mínimo que necesita el compilador para ejecutarse a sí mismo.

| Archivo | Contenido |
|---------|-----------|
| `start.asm` | `_start` (llama a `main(argc, argv)` y sale con su resultado) y las llamadas al sistema `sys_exit`, `sys_write`, `sys_read`, `sys_open`, `sys_close`, `sys_map` |
| `lib.c` | Compilado con el propio `tcc`: `alloc` (bloques de 1 MiB con `mmap`, memoria en ceros, nunca se libera), `copy_mem`, `str_len`, `str_eq`, `str_cat`, `print_char`, `print_str`, `print_int` |
| `rt.h` | Prototipos de todo lo anterior (`#include "rt.h"`) |

No se prioriza la eficiencia ni la elegancia: `str_eq` y `str_len` son bucles simples y `alloc` no libera.

### 11.3 Convenciones

- **ABI**: System V AMD64. Argumentos en `rdi, rsi, rdx, rcx, r8, r9`; retorno en `rax`. **Máximo 6 parámetros por función** (error semántico `la funcion 'f' no puede tener mas de 6 parametros`), así que nunca se pasan argumentos por la pila.
- **Pila alineada a 16 bytes** en cada `call`: el generador cuenta los `push` pendientes y, si son impares, reserva 8 bytes alrededor de la llamada.
- **Tamaños**: `char` 1 byte (con signo), `int` 4, puntero 8.
- **Valores**: toda expresión deja su resultado en `rax`, normalizado: `int` y `char` con el signo extendido a 64 bits (`movsxd`, `movsx`). Los `int` envuelven a 32 bits.
- **Máquina de pila**: una operación binaria evalúa el operando izquierdo, hace `push rax`, evalúa el derecho, y deja `rax` = izquierdo y `rcx` = derecho. No se optimiza.
- **Aritmética de punteros**: el desplazamiento se multiplica por el tamaño del tipo apuntado; `p - q` divide entre ese tamaño. Los punteros se comparan sin signo.
- **Locales y parámetros**: una ranura de 8 bytes cada uno en `[rbp-N]`, sin reutilizar entre bloques, accedida con el ancho de su tipo. El desplazamiento se guarda en `N_DECL.value`/`N_PARAM.value` como `-N`; en un global `value` es 1.
- **Globales**: sección `.data` (`dd`, `db` o `dq`), con la constante de su inicializador, o 0. Las cadenas van en `.rodata`; `N_STR.value` guarda el número `S<n>`.
- **Función sin `return` final**: devuelve 0 (como `main` en C).
- **Control de flujo**: `if`/`while` con saltos a etiquetas; `&&` y `||` con cortocircuito.

### 11.4 Cadenas

El lexer decodifica los escapes `\n`, `\t`, `\r`, `\\` y `\"`; cualquier otro `\x` produce `x`. No existe `\0` en cadenas (terminaría la cadena). El generador las emite como `db "texto", 10, 0`.

### 11.5 Fuera de alcance por ahora

Más de 6 parámetros, optimización de registros, enteros de 64 bits, `&` (dirección de), arreglos y compatibilidad general con C. El objetivo es un compilador que se compile a sí mismo.

## 12. Auto-alojamiento

### 12.1 Etapas

```Text
tcc0  gcc + libc   (src/main/*.c, runtime.c, main.c)   herramienta de arranque y depuración
tcc1  tcc0 compila los fuentes subconjunto + runtime propio   -> ejecutable estático, sin libc
tcc2  tcc1 compila los mismos fuentes                          -> debe ser idéntico a tcc1
```

`make selfhost` ejecuta `scripts/selfhost.sh` dos veces y compara con `cmp` el ensamblador de cada módulo en `build/stage1` y `build/stage2`: si coincide, el compilador alcanzó el punto fijo. `test_selfhost.c` lo comprueba en `make test`.

### 12.2 Qué se compila

| Módulo | Contenido |
|--------|-----------|
| `lexer`, `ast`, `symtab`, `sema`, `codegen`, `parser` | El compilador (`src/main`), sin libc |
| `src/self/tcc_main.c` | `main` mínimo: `tcc [--check \| --asm] archivo.c` |
| `src/runtime/lib.c` | Runtime propio: memoria, cadenas, archivos, errores, búfer de salida |
| `src/runtime/start.asm` | `_start` y llamadas al sistema |

Cada módulo se preprocesa con `cpp -P -nostdinc -I src/main -I src/runtime`, se traduce a `.s`, se ensambla con `nasm` y todo se enlaza con `ld`.

### 12.3 Sustitutos de la biblioteca estándar

| Libc (tcc0) | Propio (`lib.c`) |
|-------------|------------------|
| `calloc` | `alloc` (`mmap`, memoria en ceros) |
| `memcpy` | `copy_mem` |
| `strcmp` / `strlen` / concatenación | `str_eq` / `str_len` / `str_cat` |
| `snprintf("%d")` | `int_to_str` |
| `fopen`/`fread` | `read_file` (`sys_open`, `sys_read`, `sys_close`) |
| `fputs(stderr)`/`fwrite` | `write_all` sobre `sys_write` |
| mensajes de error | `report_error`, `error_log`, `error_quiet`, `set_source_name` |
| `realloc` del búfer de salida | `emit*` con crecimiento por duplicación |

### 12.4 Diferencias entre tcc0 y tcc1

tcc1 solo ofrece `--check` y `--asm`. `--tokens`, `--ast` y `--types` (`token_dump.c`, `ast_dump.c`, `main.c`) existen solo en tcc0 porque usan libc y estructuras fuera del subconjunto. Ambas etapas generan exactamente el mismo ensamblador.

### 12.4 Semilla de arranque

`make seed` guarda en `seed/` el ensamblador de stage2 (8 archivos `.s`). `make from-seed` (`scripts/fromseed.sh`) ensambla y enlaza esa semilla con `nasm` y `ld`, sin gcc, y con ese compilador reconstruye todo; el resultado debe ser idéntico a `seed/`. Hay que ejecutar `make seed` y versionar `seed/` cada vez que cambie el compilador o la gramática. Siguen haciendo falta `cpp`, `nasm` y `ld`.

## 13. Instalación y distribución

`make install` (`PREFIX=/usr/local`, `DESTDIR` vacío por defecto) instala el compilador de stage2 (estático, sin libc) y el runtime precompilado:

| Archivo | Destino |
|---------|---------|
| `tcc` | `$PREFIX/libexec/tinyc/tcc` |
| `start.o`, `lib.o` | `$PREFIX/lib/tinyc/` |
| `rt.h` | `$PREFIX/include/tinyc/` |
| `scripts/tinyc.sh` | `$PREFIX/bin/tinyc` |

El driver `tinyc [-S] [-o salida] entrada.c` ejecuta `cpp -P`, `tcc --asm`, `nasm` y `ld` con rutas relativas a su propia ubicación, así que la instalación es reubicable. `-S` solo escribe el ensamblador. `NAME` cambia el nombre del comando y de los directorios. `make uninstall` lo quita.

`make dist` crea `build/tinyc-VERSION.tar.gz` (fuentes, documentación, ejemplos, scripts y `seed/`, sin objetos). Para construir e instalar desde el tarball sin gcc:

```Text
make from-seed
make install STAGE=build/fromseed/stage
```

Dependencias en tiempo de ejecución: `cpp`, `nasm` y `ld`.

## Apéndice A. Formatos exactos

Las pruebas comparan texto literal, así que estos formatos son parte del contrato. Todo el texto de mensajes va **sin acentos** y en español.

### A.1 Mensajes de error

Formato: `archivo:línea:columna: error: mensaje` más salto de línea, en `stderr` y acumulado en `error_log()`. El nombre por defecto es `<entrada>` (`set_source_name` lo cambia). Línea y columna empiezan en 1; un tab cuenta como una columna; `\r\n` cuenta como un solo salto.

**Léxicos** (los reporta el parser, una sola vez, en la posición del token inválido):

| Mensaje | Caso |
|---------|------|
| `numero demasiado grande` | literal que no cabe en `int` de 32 bits con signo (máx. 2147483647) |
| `cadena sin cerrar` | falta la `"` final, o termina en `\` |
| `caracter sin cerrar` | falta la `'` final |

Un carácter desconocido (`@`) no es un error léxico: llega como token y el parser dice `se esperaba ... y se encontro '@'`.

**Sintácticos:**

| Mensaje | Notas |
|---------|-------|
| `se esperaba X y se encontro Y` | `X` es la descripción de lo esperado (`';'`, `')'`, `'{'`, `un tipo`, `un identificador`, `'}'`, `'{' o ';'`) |
| `se esperaba una expresion y se encontro Y` | |
| `se esperaba una declaracion o funcion y se encontro Y` | a nivel de programa |
| `el lado izquierdo de '=' no es asignable` | solo `N_ID` y `*e` son l-values |
| `demasiados errores` | tras el error número 20 el análisis se detiene |

`Y` (lo encontrado) se escribe así: `fin de archivo`, `identificador 'nombre'`, `numero`, `cadena`, `caracter`, las palabras clave y operadores de varios caracteres entre comillas simples (`'int'`, `'else'`, `'<='`, `'&&'`), y cualquier otro carácter también entre comillas simples (`';'`, `'@'`). Solo se informa un error por posición de token.

**Semánticos** (`T` es un nombre de tipo de A.4; los nombres van entre comillas simples):

| Mensaje | Posición |
|---------|----------|
| `identificador 'x' no declarado` | el identificador |
| `funcion 'f' no declarada` | la llamada |
| `'x' no es una funcion` | la llamada |
| `'f' es una funcion, no una variable` | el identificador |
| `la funcion 'f' espera N argumento(s) y recibe M argumento(s)` | la llamada; singular si N o M valen 1 (`1 argumento`, `0 argumentos`) |
| `argumento K de 'f': no se puede convertir 'T1' a 'T2'` | el argumento; K desde 1 |
| `no se puede asignar 'T1' a 'T2'` | el `=` |
| `operandos invalidos para 'op': 'T1' y 'T2'` | el operador |
| `operando invalido para '!': 'T'` | el operador |
| `aritmetica sobre 'void*' no permitida` | el operador |
| `no se puede desreferenciar 'T'` | el `*` |
| `division entre cero` | el literal `0` del divisor |
| `la condicion debe ser escalar, no 'T'` | la condición |
| `no se puede convertir 'T1' a 'T2'` | un cast inválido |
| `la variable 'x' no puede ser de tipo void` / `el parametro 'x' no puede ser de tipo void` | la declaración |
| `'x' ya esta declarado en este ambito` | la declaración |
| `no se puede inicializar 'T1' con 'T2'` | el inicializador |
| `el inicializador de 'x' debe ser una constante` | el inicializador (global) |
| `declaracion de 'f' en conflicto con la anterior` | la función |
| `la funcion 'f' ya esta definida` | la función |
| `la funcion 'f' no puede tener mas de 6 parametros` | la función |
| `una funcion void no puede retornar un valor` | el `return` |
| `se esperaba un valor de retorno de tipo 'T'` | el `return` |
| `no se puede retornar 'T1' en una funcion que retorna 'T2'` | la expresión devuelta |

Posición de un nodo: la de su primer carácter, salvo `N_BINOP` (el operador) y `N_FUNC` (el tipo de retorno). `N_BLOCK` es la `{`; `N_EXPR_STMT` el inicio de la expresión; `N_CALL` el nombre; `N_CAST` el `(`; `N_UNOP` el operador.

### A.2 Volcado de tokens (`--tokens`)

Una línea por token: `L:C: <Categoría> detalle`. La última es `<Fin>`.

| Categoría | Detalle |
|-----------|---------|
| `Identificador` | ` nombre` |
| `Numero` | ` valor` |
| `Cadena` | ` "texto"` (ya con escapes decodificados, sin volver a escapar) |
| `Caracter` | ` 'c' (código)` si el código está entre 32 y 126; si no ` (código)` |
| `PalabraClave`, `Operador` | ` texto` (`while`, `<=`, `+`) |
| `Error` | ` mensaje` |
| `Fin` | nada |
| `Desconocido` | un carácter que no es operador: ` c` |

`%`, `[` y `]` se clasifican como `Operador`. Ejemplo: `1:15: <Operador> <=`.

### A.3 Volcado del AST

**Etiquetas** (comunes a `--ast`, `--types` y la S-expresión):

| Nodo | Etiqueta |
|------|----------|
| `N_PROGRAM` | `Program` |
| `N_FUNC` | `Func T nombre` (con cuerpo) o `Proto T nombre` (prototipo) |
| `N_PARAM` / `N_DECL` | `Param T nombre` / `Decl T nombre` |
| `N_BLOCK`, `N_IF`, `N_WHILE`, `N_RETURN`, `N_EXPR_STMT` | `Block`, `If`, `While`, `Return`, `ExprStmt` |
| `N_BINOP` / `N_UNOP` | `Binop op` / `Unop op` |
| `N_CAST` | `Cast T` |
| `N_CALL` | `Call nombre` |
| `N_ID` | `Id nombre` |
| `N_STR` | `Str "texto"` (texto ya decodificado, sin reescapar) |
| `N_NUM` / `N_CHR` | `Num valor` / `Chr código` |

En la etiqueta, `T` se escribe como la base (`int`, `char`, `void`) seguida de un `*` por nivel de puntero, **sin espacio** (`char*`, `int**`).

**S-expresión** (`ast_sexpr`, la que usan las pruebas): `(Etiqueta hijo hijo ...)`, con un espacio antes de cada hijo y ninguno tras el nombre si no hay hijos. Los hijos se recorren en el orden de las ranuras `a`, `b`, `c` y, dentro de cada ranura, por la lista `next`. Ejemplos:

```Text
(Program (Func void f (Block (ExprStmt (Binop = (Id a) (Num 1))))))
(If (Id a) (ExprStmt (Id b)) (ExprStmt (Id c)))
(Decl int x (Binop + (Num 1) (Num 2)))
(Call f (Num 1) (Binop + (Id x) (Num 2)))
(Cast char* (Id p))
```

**Volcado con sangría** (`--ast`): una línea por nodo, dos espacios por nivel de profundidad, `etiqueta` + **dos espacios** + `(L:C)`:

```Text
Program  (1:1)
  Decl int g  (1:1)
    Num 1  (1:9)
  Func int f  (3:1)
    Param int a  (3:7)
    Block  (3:14)
```

**Con tipos** (`--types`, tras el análisis): igual, pero toda expresión, excepto `Cast`, añade ` : T` a la etiqueta (`Binop <= : int  (4:9)`). Las sentencias y declaraciones no llevan tipo.

### A.4 Nombres de tipo

`type_name(t)`: `int`, `char`, `void`, seguidos de un `*` por puntero (`char*`, `void**`); el tipo de error es `<error>`. Codificación numérica: base (`T_INT`=260, `T_CHAR`=261, `T_VOID`=262) + 1000 por nivel de puntero; `TY_ERR` = -1.

### A.5 Línea de comandos de `tcc`

`tcc [--check | --tokens | --ast | --types | --asm] archivo.c` (sin opción es `--check`). Códigos de salida: `0` sin errores, `1` errores de sintaxis o semánticos (o archivo ilegible), `2` uso incorrecto (sin archivo, sobran argumentos u opción desconocida). La salida normal va a `stdout` y los errores a `stderr`. `--tokens` no analiza la sintaxis; `--ast` no ejecuta el análisis semántico; `--asm` y `--types` lo ejecutan antes. El tcc auto-alojado (stage1/2) solo ofrece `--check` y `--asm`, y sin argumentos sale con `2`.

### A.6 Forma del ensamblador generado

Primera línea: `; generado por tcc: NASM, sintaxis Intel, x86-64 Linux`. Luego `section .text`; cada función con el comentario `; T nombre`, `global _nombre` y `_nombre:`, y al final `section .data` (globales) y `section .rodata` (cadenas, etiquetas `S<n>`). Las etiquetas de control son `L<n>`. Los detalles de registros, pila y convenciones están en la sección 11.3. Las pruebas no comparan el texto del ensamblador sino el **comportamiento** del ejecutable, con una excepción: el auto-alojamiento exige que el ensamblador de dos etapas sea **idéntico byte a byte**, así que el generador debe ser determinista (sin direcciones, fechas ni orden de tablas hash).

### A.7 Reglas de recuperación de errores

- El parser reporta como máximo un error por token y sigue analizando; para en 20 errores (`demasiados errores`).
- Sincronización: dentro de un bloque, avanza hasta después de `;` o hasta antes de `}`; a nivel de programa, hasta una palabra clave de tipo.
- Un error de sintaxis impide ejecutar el análisis semántico.
- Un error de tipo produce el tipo `<error>`, que silencia los errores derivados (sin cascada).
- Tras un error semántico no se genera código.
