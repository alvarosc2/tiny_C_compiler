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

.PHONY: all build test run sanitize memcheck format clean help

all: build

build: $(TARGET)

$(TARGET): $(OBJ_MAIN)
	$(CC) $(CFLAGS) $^ -o $@

$(BUILD)/main/%.o: src/main/%.c | $(BUILD)/main
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

# Un solo binario Criterion con todos los test_*.c
$(TEST_BIN): $(SRC_TEST) $(OBJ_LIB) | $(BUILD)
	$(CC) $(CFLAGS) $^ -o $@ -lcriterion

$(BUILD) $(BUILD)/main:
	mkdir -p $@

test: $(TEST_BIN)
	./$(TEST_BIN)

run: build
	./$(TARGET)

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
	@echo "run       compila y ejecuta"
	@echo "sanitize  tests con ASan/UBSan"
	@echo "memcheck  tests bajo valgrind"
	@echo "format    clang-format"
	@echo "clean     borra build/"

-include $(OBJ_MAIN:.o=.d)
