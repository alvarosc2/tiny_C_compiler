# Guía de construcción

Cómo reconstruir este compilador desde cero a partir de [specification.md](./specification.md) y [indice-de-pruebas.md](./indice-de-pruebas.md). Está pensada para una persona o para un grupo de agentes: cada fase tiene entradas, entregables y una **puerta** (comando que debe pasar) antes de empezar la siguiente.

## 1. Documentos y su papel

| Documento | Qué aporta |
|-----------|------------|
| `specification.md` | Gramática, AST, reglas semánticas, generador, auto-alojamiento. El **Apéndice A** fija los formatos exactos (mensajes, volcados) |
| `indice-de-pruebas.md` | Qué debe comprobar cada prueba |
| `src/test/` | Las pruebas de aceptación ejecutables (ver sección 3) |
| Esta guía | Orden, puertas y criterio final |

Ante un conflicto, manda el Apéndice A sobre el resto del texto, y las pruebas de aceptación sobre ambos.

## 2. Herramientas y entorno

`gcc` (solo para tcc0), `make`, `cpp`, `nasm`, `ld`, `libcriterion-dev`, Linux x86-64. Opcionales: `valgrind`, `clang-format`. Directorios: `src/main/` (compilador), `src/runtime/` (runtime sin libc), `src/self/` (`main` del auto-alojado), `src/test/`, `scripts/`, `examples/`, `seed/`, `docs/`.

## 3. Reglas de trabajo

1. **Pruebas congeladas.** `src/test/` es el criterio de aceptación. Quien implementa no las modifica ni las vuelve más laxas. Si una prueba parece incorrecta, se reporta y la decide el humano o el agente revisor.
2. **Una fase a la vez.** No se empieza una fase sin que la puerta de la anterior pase.
3. **Nombres y prototipos fijos.** Las interfaces están en los `.h` de la especificación (`lexer_init`, `next_token`, `parse`, `analyze`, `generate`, ...). Los offsets del token (24 bytes) y del nodo (72 bytes) son contrato.
4. **Dos niveles de código.** El código de `src/main/` (menos `main.c`, `runtime.c`, `ast_dump.c`, `token_dump.c`) debe escribirse en el **subconjunto de bootstrap** (sección 8 y 8.3.1): solo `int`, `char`, `void` y punteros; sin `struct`, `enum`, `static`, `for`, `p[i]`, `++`, `%`, `-` unario, ni libc. `main.c`, `runtime.c` y los volcados son solo para gcc y pueden usar C normal.
5. **Prefijos.** `p_` parser, `s_` sema, `g_` generador. Los prototipos exigen nombres de parámetros.
6. **Mensajes.** Sin acentos, exactamente como en el Apéndice A.

## 4. Fases

Cada fase indica qué pruebas del índice cubre. Se ejecutan con `make test` (todo) o con el binario de pruebas filtrando por suite: `build/run_tests --filter 'lexer_*/*'`.

### Fase 0. Esqueleto
- **Hacer:** `Makefile` (targets: `build test run lex ast types asm exe runtime selfhost selfcheck seed from-seed install uninstall dist sanitize memcheck format clean help`), `.gitignore`, `tokens.h` (solo `#define`, sin `enum`), `runtime.c/h` (servicios para gcc: `alloc`, `copy_mem`, `str_eq`, `str_cat`, registro de errores `report_error`/`error_log`/`error_quiet`, búfer `emit*`).
- **Detalles del Makefile:** `-std=gnu11 -Wall -Wextra -g -O0`; un único binario Criterion `build/run_tests` con todos los `test_*.c` enlazados con todos los objetos menos `main.o`; el compilador y el runtime van como prerrequisitos *order-only* (`|`) del binario de pruebas, para que `$^` no los pase al enlazador; dependencias `-MMD -MP`.
- **Puerta:** `make build` sin avisos.

### Fase 1. Lexer
- **Entregables:** `lexer.c/h`, `token_dump.c/h`.
- **Pruebas:** `lexer_*` y `token_dump` (85).
- **Puntos delicados:** `read_number` detecta desbordamiento de `int` de 32 bits (`numero demasiado grande`) sin que el cálculo mismo desborde; `T_EOF` es «pegajoso» (seguir pidiendo tokens devuelve `T_EOF`); `lexer_init` reinicia línea y columna; las cadenas decodifican `\n \t \r \\ \"`; `++` y `--` **no** son tokens; `[`, `]` y `%` sí lo son (sin uso).
- **Puerta:** `make test` filtrado a `lexer_*` y `token_dump_*`.

### Fase 2. AST y parser
- **Entregables:** `ast.c/h` (acceso por offsets), `ast_dump.c/h`, `parser.c/h`.
- **Pruebas:** `parser_expr`, `parser_stmt`, `parser_top`, `parser_err` (99).
- **Puntos delicados:** descenso recursivo con un solo token de anticipación; asignación solo como sentencia; cuerpos de `if`/`while` sin declaraciones; recuperación de errores y tope de 20 (Apéndice A.7); las pruebas comparan la S-expresión (Apéndice A.3), así que el orden de hijos importa.
- **Puerta:** las suites anteriores más `parser_*`.

### Fase 3. Tabla de símbolos y análisis semántico
- **Entregables:** `symtab.c/h`, `sema.c/h`.
- **Pruebas:** `symtab`, `sema_types`, `sema_err`, `sema_decl` (44).
- **Puntos delicados:** el inicializador local se analiza antes de declarar la variable; `TY_ERR` silencia errores derivados; puntero ← `int` solo con la constante nula; máximo 6 parámetros.
- **Puerta:** `make test` hasta `sema_*`. Además, `make selfcheck` debe pasar cuando existan los módulos del compilador (lexer, ast, symtab, sema, parser): el compilador debe aceptar **su propio código** (esto detecta usos fuera del subconjunto).

### Fase 4. Generador de código y runtime
- **Entregables:** `codegen.c/h`, `src/runtime/{start.asm,lib.c,rt.h}`, `scripts/cc.sh`, `src/main/main.c`.
- **Pruebas:** `codegen`, `codegen_calls`, `codegen_mem`, `codegen_rt` (34). Cada una compila de verdad con `cpp`, `tcc`, `nasm` y `ld`, así que son más lentas.
- **Puntos delicados:** máquina de pila con el resultado en `rax`; alineación de la pila a 16 bytes en cada llamada; aritmética de punteros escalada; `main` sin `return` devuelve 0; símbolos con prefijo `_`.
- **Puerta:** `make test` completo, y `make exe FILE=examples/hello.c OUT=build/hello && build/hello` imprime los factoriales.

### Fase 5. Auto-alojamiento
- **Entregables:** `src/self/tcc_main.c` (`main` mínimo con `--check` y `--asm`), `scripts/selfhost.sh`, ampliación de `lib.c` (`read_file`, `write_all`, `int_to_str`, `report_error`, `emit*`, `print_*`), target `selfhost`.
- **Pruebas:** `selfhost`.
- **Puerta:** `make selfhost` imprime `auto-alojamiento OK`: tcc0 → tcc1 → tcc2 y los `.s` de las dos últimas etapas son idénticos; el binario es estático y no tiene símbolos sin resolver.

### Fase 6. Empaquetado
- **Entregables:** `scripts/tinyc.sh`, `scripts/fromseed.sh`, targets `install`, `uninstall`, `dist`, `seed`, `from-seed`.
- **Pruebas:** `install`.
- **Puerta:** `make seed && make from-seed` reproduce `seed/`; y desde el tarball de `make dist` se construye e instala sin gcc.

## 5. Criterio de aceptación final

Todos deben cumplirse:

1. `make test`: **264/264** pruebas, 0 fallos.
2. `make sanitize`: las mismas pruebas con ASan/UBSan, sin errores.
3. `make selfcheck`: el compilador acepta sus propios fuentes.
4. `make selfhost`: punto fijo.
5. `make from-seed`: reconstrucción sin gcc idéntica a `seed/`.
6. `make dist` genera el tarball y `make install DESTDIR=...` produce un `tinyc` que compila y ejecuta `examples/hello.c`.
7. Una búsqueda de `++`, `--`, `%`, `[`, `(void)` y libc en los fuentes del subconjunto no devuelve usos.

## 6. Organización sugerida para varios agentes

| Rol | Hace | No hace |
|-----|------|---------|
| Implementador (uno por fase) | Escribe el código de la fase hasta pasar su puerta | Tocar `src/test/`, saltarse la puerta |
| Revisor | Compara el código con la especificación, busca usos fuera del subconjunto, ejecuta `selfcheck` | Corregir sin avisar |
| Integrador | Mantiene el `Makefile`, ejecuta las puertas y el criterio final, resuelve conflictos entre fases | Cambiar interfaces sin actualizar la especificación |

Las fases son secuenciales por dependencia (cada una usa la anterior), pero el implementador de la fase N+1 puede empezar leyendo las pruebas y la especificación mientras la fase N termina. Para repartir trabajo en paralelo dentro de una fase, los puntos naturales de corte son: análisis de expresiones contra sentencias en el parser; `sema_types`/`sema_err` contra `sema_decl`; llamadas contra memoria en el generador.

## 7. Trampas conocidas

- **Criterion aísla cada prueba:** no pueden compartir estado, y una sola prueba larga (`selfhost`) es preferible a varias que dependan entre sí.
- **Pruebas parametrizadas con punteros a cadenas se caen:** usar tablas estáticas recorridas con un bucle.
- **Orden de enlazado:** el binario de pruebas no debe recibir el binario `tcc` ni `main.o`.
- **`make sanitize` deja objetos con ASan:** termina con `make clean` antes de volver a `make test`.
- **`cpp -P` borra los comentarios `//`:** por eso los fuentes del subconjunto pueden llevarlos, pero no se pueden usar macros con argumentos en ese código.
- **Columnas de los errores:** cambian si cambia el texto de una prueba (por ejemplo `f(void)` frente a `f()`); revisar la posición de la regla del Apéndice A.1 antes de «arreglar» una expectativa.
- **Determinismo:** el generador no puede depender de punteros, fechas ni orden de tablas; si no, el punto fijo falla.
- **Los números de nodo** (`N_*`) y de token (`T_*`) están en la especificación (9.2 y `tokens.h`); renumerarlos exige actualizar el volcado, que usa `kind >= N_BINOP` para distinguir expresiones.

## 8. Qué queda fuera

Preprocesador, ensamblador y enlazador propios (hoy `cpp`, `nasm`, `ld`); más de 6 parámetros; `struct`, `enum`, arreglos, `for`, `switch`; optimización; otros destinos (16 bits, modo protegido). La especificación los trata como trabajo futuro.
