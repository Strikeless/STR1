#include "../lib/rules.asm"

ld.imm r0, data

ld.prg r3, r0
ld.prg r2, r0
ld.prg r1, r0
ld.prg r0, r0

hlttint

data:
    #d 137`8
