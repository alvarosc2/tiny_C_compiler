CC       ?= gcc
CFLAGS   ?= -std=gnu11 -Wall -Wextra -g -O0
BUILD    := build
TARGET   := $(BUILD)/tcc

SRC_MAIN := $(wildcard src/main/*.c)
SRC_TEST := $(wildcard src/test/*.c)
OBJ_MAIN := $(patsubst src/main/%.c,$(BUILD)/main/%.o,$(SRC_MAIN))
# main.o se excluye de los tests porque define main()
OBJ_LIB  := $(filter-out $(BUILD)/main/main.o,$(OBJ_MAIN))
TEST_BIN := $(BUILD)/run_tests
RT_DIR   := $(BUILD)/runtime
RT_OBJ   := $(RT_DIR)/start.o $(RT_DIR)/lib.o

.PHONY: all build test run lex ast types asm exe selfcheck runtime sanitize memcheck format clean help

all: build

build: $(TARGET)

$(TARGET): $(OBJ_MAIN)
	$(CC) $(CFLAGS) $^ -o $@

$(BUILD)/main/%.o: src/main/%.c | $(BUILD)/main
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

# Un solo binario Criterion con todos los test_*.c
$(TEST_BIN): $(SRC_TEST) $(OBJ_LIB) | $(BUILD) $(TARGET) $(RT_OBJ)
	$(CC) $(CFLAGS) $^ -o $@ -lcriterion

$(BUILD) $(BUILD)/main:
	mkdir -p $@

test: $(TEST_BIN)
	./$(TEST_BIN)

run: build
	./$(TARGET) $(FILE)

# Tokens que produce el lexer: make lex FILE=examples/sample.c
lex: build
	./$(TARGET) --tokens $(or $(FILE),examples/sample.c)

# AST que produce el parser: make ast FILE=examples/sample.c
ast: build
	./$(TARGET) --ast $(or $(FILE),examples/sample.c)

# AST con tipos tras el analisis semantico
types: build
	./$(TARGET) --types $(or $(FILE),examples/sample.c)

# Runtime propio sin libc: start.asm (NASM) + lib.c (compilado con tcc)
runtime: $(RT_OBJ)

$(RT_DIR):
	mkdir -p $@

$(RT_DIR)/start.o: src/runtime/start.asm | $(RT_DIR)
	nasm -f elf64 $< -o $@

$(RT_DIR)/lib.o: src/runtime/lib.c src/runtime/rt.h $(TARGET) | $(RT_DIR)
	cpp -P -nostdinc -I src/runtime $< > $(RT_DIR)/lib.i
	./$(TARGET) --asm $(RT_DIR)/lib.i > $(RT_DIR)/lib.s
	nasm -f elf64 $(RT_DIR)/lib.s -o $@

# Ensamblador NASM que genera tcc: make asm FILE=examples/hello.c
asm: build
	cpp -P -nostdinc -I src/runtime $(or $(FILE),examples/hello.c) > $(BUILD)/asm.i
	./$(TARGET) --asm $(BUILD)/asm.i

# Ejecutable: make exe FILE=examples/hello.c OUT=build/hello  (luego ./build/hello)
exe: build runtime
	scripts/cc.sh $(or $(FILE),examples/hello.c) $(or $(OUT),$(BUILD)/a.out)

# El compilador verifica su propio codigo (preprocesado con cpp -P)
SELF_SRC := lexer ast symtab sema codegen parser
selfcheck: build
	@for f in $(SELF_SRC); do \
		cpp -P -nostdinc -I src/main src/main/$$f.c > build/$$f.i && \
		./$(TARGET) build/$$f.i || exit 1; \
		echo "ok $$f.c"; \
	done

# Tests con AddressSanitizer + UBSan (recompila desde cero)
sanitize:
	$(MAKE) clean
	ASAN_OPTIONS=detect_leaks=0 $(MAKE) test CFLAGS="$(CFLAGS) -fsanitize=address,undefined -fno-omit-frame-pointer"
	$(MAKE) clean

memcheck: $(TEST_BIN)
	valgrind --leak-check=full --error-exitcode=1 ./$(TEST_BIN) --no-early-exit

format:
	clang-format -i src/main/*.c src/main/*.h src/test/*.c

clean:
	rm -rf $(BUILD)

help:
	@echo "build     compila el compilador ($(TARGET))"
	@echo "test      compila y corre las pruebas Criterion"
	@echo "run       analiza un archivo: make run FILE=archivo.c"
	@echo "lex       muestra los tokens (default examples/sample.c)"
	@echo "ast       muestra el AST (default examples/sample.c)"
	@echo "asm       muestra el ensamblador NASM generado"
	@echo "exe       compila a ejecutable: make exe FILE=x.c OUT=build/x"
	@echo "types     muestra el AST con tipos"
	@echo "selfcheck verifica el propio codigo fuente del compilador"
	@echo "sanitize  tests con ASan/UBSan"
	@echo "memcheck  tests bajo valgrind"
	@echo "format    clang-format"
	@echo "clean     borra build/"

-include $(OBJ_MAIN:.o=.d)
