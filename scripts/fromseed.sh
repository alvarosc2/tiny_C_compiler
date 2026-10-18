#!/bin/sh
# Arranca sin gcc: ensambla y enlaza el ensamblador guardado en seed/ y con
# ese compilador reconstruye todo. Deja el resultado en el directorio dado.
#   scripts/fromseed.sh build/fromseed
set -e
root=$(cd "$(dirname "$0")/.." && pwd)
out=$1
mkdir -p "$out/seed"
objs=
for s in "$root"/seed/*.s; do
    name=$(basename "$s" .s)
    nasm -f elf64 "$s" -o "$out/seed/$name.o"
    objs="$objs $out/seed/$name.o"
done
nasm -f elf64 "$root/src/runtime/start.asm" -o "$out/seed/start.o"
ld "$out/seed/start.o" $objs -o "$out/seed/tcc"
"$root/scripts/selfhost.sh" "$out/seed/tcc" "$out/stage"
for s in "$root"/seed/*.s; do
    cmp "$s" "$out/stage/$(basename "$s")"
done
echo "from-seed OK: el compilador reconstruido desde seed/ reproduce el seed"
