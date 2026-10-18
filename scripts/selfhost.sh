#!/bin/sh
# Construye el compilador completo (sin libc) usando un compilador existente:
#   scripts/selfhost.sh build/tcc build/stage1
# Deja en el directorio de salida: <modulo>.i, .s, .o y el ejecutable 'tcc'.
set -e
root=$(cd "$(dirname "$0")/.." && pwd)
cc=$1
out=$2
mkdir -p "$out"
objs=
for f in src/main/lexer src/main/ast src/main/symtab src/main/sema src/main/codegen \
         src/main/parser src/self/tcc_main src/runtime/lib; do
    name=$(basename "$f")
    cpp -P -nostdinc -I "$root/src/main" -I "$root/src/runtime" "$root/$f.c" > "$out/$name.i"
    "$cc" --asm "$out/$name.i" > "$out/$name.s"
    nasm -f elf64 "$out/$name.s" -o "$out/$name.o"
    objs="$objs $out/$name.o"
done
nasm -f elf64 "$root/src/runtime/start.asm" -o "$out/start.o"
ld "$out/start.o" $objs -o "$out/tcc"
