#!/bin/sh
# Compila un .c con tcc hasta un ejecutable (sin libc):
#   scripts/cc.sh entrada.c salida
# Deja los intermedios junto a la salida: salida.i, salida.s y salida.o
set -e
root=$(cd "$(dirname "$0")/.." && pwd)
in=$1
out=$2
cpp -P -nostdinc -I "$root/src/runtime" "$in" > "$out.i"
"$root/build/tcc" --asm "$out.i" > "$out.s"
nasm -f elf64 "$out.s" -o "$out.o"
ld "$out.o" "$root/build/runtime/start.o" "$root/build/runtime/lib.o" -o "$out"
