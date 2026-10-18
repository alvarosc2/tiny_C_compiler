#!/bin/sh
# Driver instalado: compila un .c (subconjunto de tinyc, sin libc) a un ejecutable.
#   tinyc [-S] [-o salida] entrada.c
# Las rutas son relativas a la ubicacion de este script (<prefijo>/bin/tinyc),
# asi que la instalacion se puede mover o usar con DESTDIR.
set -e
self=$(readlink -f "$0")
root=$(dirname "$(dirname "$self")")
tcc=$root/libexec/tinyc/tcc
lib=$root/lib/tinyc
inc=$root/include/tinyc

usage() {
    echo "uso: tinyc [-S] [-o salida] entrada.c" >&2
    echo "  -S  solo genera ensamblador NASM (entrada.s)" >&2
    exit 2
}

asm_only=0
out=
in=
while [ $# -gt 0 ]; do
    case $1 in
        -S) asm_only=1 ;;
        -o) shift; [ $# -gt 0 ] || usage; out=$1 ;;
        -h|--help) usage ;;
        -*) echo "tinyc: opcion desconocida: $1" >&2; usage ;;
        *) [ -z "$in" ] || usage; in=$1 ;;
    esac
    shift
done
[ -n "$in" ] || usage
base=${in%.c}
[ -n "$out" ] || out=$base
[ "$asm_only" = 0 ] || [ "$out" != "$base" ] || out=$base.s

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

cpp -P -nostdinc -I "$inc" "$in" > "$tmp/prog.i"
if [ "$asm_only" = 1 ]; then
    "$tcc" --asm "$tmp/prog.i" > "$out"
    exit 0
fi
"$tcc" --asm "$tmp/prog.i" > "$tmp/prog.s"
nasm -f elf64 "$tmp/prog.s" -o "$tmp/prog.o"
ld "$tmp/prog.o" "$lib/start.o" "$lib/lib.o" -o "$out"
