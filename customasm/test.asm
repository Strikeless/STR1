#include "rules.asm"

ld.imm r0, 255
ld.imm r1, 1
ld.imm r3, dec_loop

dec_loop:
    sub r0, r1
    jmp r3
