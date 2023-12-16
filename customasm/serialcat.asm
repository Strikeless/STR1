#include "lib/rules.asm"
#include "lib/peripherals.asm"

ld.imm r3, cat_loop
ld.imm r2, P_SERIAL
ld.imm r1, P_TERMINAL

cat_loop:
    ld.mem r0, r2 ; Load data from the serial peripheral to r0
    str.reg r1, r0 ; Store the data in r0 in the terminal peripheral
    jmp.reg r3 ; Jump back to the beginning of the loop
