# Índice de pruebas unitarias

Pruebas con [Criterion](https://criterion.readthedocs.io) en `src/test/`. Se ejecutan con `make test` (un solo binario, `build/run_tests`) y con `make sanitize` (ASan/UBSan). Suite actual: **264 pruebas**. Cada prueba corre aislada, por lo que no dependen entre sí.

Notación: `suite::prueba`. Donde dice «tabla» la prueba recorre varios casos en un bucle.

## 1. Lexer

### `test_lexer_numbers.c` (suite `lexer_numbers`)
Literales numéricos: un dígito, cero, varios dígitos, rodeados de espacios, secuencias, seguidos de operador, lectura directa con `read_number`, ceros a la izquierda, y desbordamiento (`int_max`, `int_max_plus_one`, número enorme, candidato a envolver). Comprueba que tras un desbordamiento el lexer se recupera.

### `test_lexer_identifiers.c` (`lexer_identifiers`)
Identificadores: simples, con guion bajo inicial, con dígitos, mezcla de mayúsculas, una letra. Un prefijo o sufijo de palabra clave sigue siendo identificador. Parada en un carácter no válido, secuencias, cadenas (también vacía) y entrada vacía = `T_EOF`.

### `test_lexer_keywords.c` (`lexer_keywords`)
Las palabras clave (`int char void return if else while`), sensibilidad a mayúsculas, y tres fragmentos reales: cabecera de función, tipo puntero y sentencia `if/else/while`.

### `test_lexer_operators.c` (`lexer_operators`)
Operadores de uno y dos caracteres (tabla), `=` contra `==`, sin espacios, `<` seguido de `=` separado, una expresión completa. `++` y `--` ya **no** son tokens: se lexan como dos `+` o dos `-`. `[` y `]` se conservan como tokens sueltos.

### `test_lexer_chars.c` (`lexer_chars`)
Literales de carácter: letra, dígito, guion bajo, espacio, comilla doble, escapes (`\n \r \t \0 \' \\`), uso dentro de una expresión y varios seguidos.

### `test_lexer_strings.c` (`lexer_strings`)
Cadenas: los escapes se decodifican, `\"` no cierra la cadena y una barra final deja la cadena sin terminar.

### `test_lexer_lines.c` y `test_lexer_columns.c` (`lexer_lines`, `lexer_columns`)
Posiciones. Línea 1 para el primer token, los saltos de línea incrementan, CRLF cuenta como un salto, la línea del `T_EOF`, una cadena multilínea reporta su línea de inicio y `lexer_init` reinicia el contador. Columna 1 para el primer token, tokens en la misma línea, espacios iniciales, reinicio tras un salto, un operador de dos caracteres es un solo token, y literales de cadena y carácter.

### `test_lexer_errors.c` (`lexer_errors`)
Cadena sin cerrar (y su posición), comilla suelta, carácter sin cerrar, apóstrofo solo, escape al final del archivo. `T_EOF` es «pegajoso», los literales válidos siguen funcionando y el lexer se recupera tras `lexer_init`.

## 2. Volcado de tokens

### `test_token_dump.c` (`token_dump`)
Formato de `--tokens`: identificadores, una declaración, cadenas/caracteres/operadores, carácter desconocido, entrada multilínea, token de error y `token_category` para cada clase.

## 3. Parser

Las pruebas de expresiones, sentencias y nivel superior son tablas de macros que comparan el AST en forma compacta (S-expresión) con el esperado.

### `test_parser_expressions.c` (`parser_expr`)
- **Átomos:** número, identificador, carácter, cadena.
- **Precedencia y asociatividad:** `*` sobre `+`, resta asociativa por la izquierda, paréntesis, `||` por debajo de `&&`, igualdad contra relacionales, relacionales contra aditivos, `!=`, `<=`/`>`.
- **Unarios y asignación:** `!`, `*`, doble `**`, `!!`, `a * *b`, asignación por debajo de `||`, `*p = 1`.
- **Llamadas:** sin argumentos, con argumentos, anidadas, dentro de una expresión.
- **Casts:** `char`, puntero, doble puntero, sobre desreferencia, `*(int *)(p + 8) = 5`, como argumento.
- `positions`: línea y columna de los nodos.

### `test_parser_statements.c` (`parser_stmt`)
- **Declaraciones:** simple, con inicializador, puntero, doble puntero, `void*`.
- **Sentencias simples:** asignación, llamada, cast, desreferencia, `return` (vacío, con valor, con expresión).
- **Control de flujo:** `if`, `if/else`, `else` colgante, cadena `else if`, bloques, `return` dentro de `if`, `while` (simple, con bloque, anidado), declaración dentro de un bucle y secuencia de sentencias.
- `statements_are_linked_in_order` (lista enlazada en orden) e `if_without_else_has_null_c`.

### `test_parser_toplevel.c` (`parser_top`)
Programa vacío, un global, varios globales, función vacía, sin lista de parámetros, con parámetros, parámetros puntero, retorno puntero, prototipo, orden mixto y prototipo seguido de definición. También `type_encoding` (base + 1000 por puntero), posiciones, un programa válido sin errores, el programa de ejemplo y el volcado indentado del AST.

### `test_parser_errors.c` (`parser_err`)
- **Mensajes y posiciones:** expresión que falta, `;` que falta, `}` sin cerrar o sobrante, `)` que falta en `if` y en llamadas, carácter desconocido, `else` sin `if`, función sin cuerpo, parámetro sin nombre, lado izquierdo no asignable (incluido el resultado de un binario).
- **Recuperación:** varios errores reportados, el parser continúa tras una función mala, errores en bloques anidados, la sentencia posterior al error se conserva, token suelto a nivel superior, lista de parámetros mala con el cuerpo analizado igual.
- **Control:** error del lexer reportado una sola vez, número demasiado grande, tope de 20 errores, el registro se reinicia entre análisis, nombre del archivo en el mensaje.
- `removed_constructs_are_syntax_errors`: `i++`, `i--`, `a[0]`, `%`, `-a`, `+a`, `f(void)`, asignación encadenada o dentro de argumentos, bloque suelto y declaración como cuerpo de `if`/`while` dan error.

## 4. Tabla de símbolos

### `test_symtab.c` (`symtab`)
Declarar y buscar, un ámbito interior oculta al exterior y desaparece al cerrarse, la búsqueda local ignora el exterior, y la marca de «definido».

## 5. Análisis semántico

Todas usan `sema_helpers.h`: parsean sin errores de sintaxis y comprueban el número y el texto de los errores semánticos.

### `test_sema_types.c` (`sema_types`)
Tipo inferido de cada expresión: literales, variables, aritmética, aritmética de punteros, desreferencia y cast, llamadas, comparaciones y lógicos, asignación y `type_name`.

### `test_sema_errors.c` (`sema_err`)
Identificador o función no declarados, llamar a algo que no es función, usar una función como valor, número y tipo de argumentos, tipos de asignación, operandos inválidos, desreferenciar un no puntero o `void*`, división entre cero, condición no escalar, sin errores en cascada y varios errores en una misma sentencia.

### `test_sema_decls.c` (`sema_decl`)
- **Ámbitos:** programa válido, uso antes de declarar, redeclaración en el mismo ámbito, ocultamiento permitido, fin de ámbito de bloques de `while` y `if`, choque entre parámetro y local.
- **Tipos y valores:** variable o parámetro `void`, tipo del inicializador, inicializador global constante, un inicializador local ve el nombre exterior.
- **Funciones:** prototipo y definición, firmas en conflicto, función definida dos veces, comprobación de `return`, recursión y anotaciones (`decl`, `value` global), y el máximo de 6 parámetros.

## 6. Generador de código

Compilan un programa real con el pipeline completo (`scripts/cc.sh`: `cpp`, `tcc`, `nasm`, `ld`), lo ejecutan y comprueban el código de salida o la salida estándar.

### `test_codegen_basic.c` (`codegen`)
Retorno de una constante, caer al final de `main` devuelve 0, aritmética (incluido el resto y el negativo escritos sin `%` ni `-` unario), división con signo hacia cero, `int` envuelve a 32 bits, comparaciones, cortocircuito de `&&` y `||` (con una función con efecto lateral), `if/else` y `while`, ámbitos locales, `char` con signo y truncamiento, y sentencias de asignación.

### `test_codegen_calls.c` (`codegen_calls`)
Orden de los argumentos, seis argumentos, llamadas anidadas con operandos pendientes, recursión, prototipo y definición, función `void` con globales, parámetros `char` y puntero, `main(argc, argv)` y alineación de la pila a 16 bytes en cada llamada.

### `test_codegen_memory.c` (`codegen_mem`)
Globales (`int`, `char`, cadena, sin inicializar), acceso a cadenas, aritmética de punteros escalada por el tamaño, escritura a través de punteros, buffer de `char`, puntero a puntero, diferencia de punteros, comparación con nulo y `alloc` devuelve memoria en ceros.

### `test_codegen_runtime.c` (`codegen_rt`)
Runtime propio (`lib.c`): `print_str` con escapes, `print_int`, funciones de cadenas, una asignación de 3 MB y el ejemplo `examples/hello.c` completo.

## 7. Integración

### `test_selfhost.c` (`selfhost`)
`fixed_point_and_behavior`: tcc0 (gcc) compila a tcc1, tcc1 compila a tcc2, el ensamblador de ambas etapas es idéntico, tcc2 es estático (sin libc), reporta un error semántico (código 256) y sin argumentos sale con 512. Es una sola prueba porque Criterion aísla cada una.

### `test_install.c` (`install`)
`installed_driver_builds_and_runs`: `make install` en un `DESTDIR` temporal, compila y ejecuta `hello.c` con el comando instalado (también con `-S`), el uso sin argumentos falla y `make uninstall` lo deja limpio.

## Resumen

| Área | Archivos | Pruebas |
|------|----------|----------------|
| Lexer | 9 | 78 |
| Volcado de tokens | 1 | 7 |
| Parser | 4 | 99 |
| Tabla de símbolos | 1 | 4 |
| Semántico | 3 | 40 |
| Generador | 4 | 34 |
| Integración | 2 | 2 |
