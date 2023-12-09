#include "lib/rules.asm"
#include "lib/peripherals.asm"

ld.imm r3, forward_loop
ld.imm r2, P_SERIAL
ld.imm r1, P_TERMINAL

forward_loop:
    ld.mem r0, r2
    str.reg r1, r0
    jmp.reg r3
