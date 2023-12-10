#include "lib/rules.asm"

ld.imm r0, $255 ; Starting value
ld.imm r1, $1 ; How much to increase/decrease value at once
ld.imm r3, dec_loop ; dec_loop pointer

dec_loop:
    sub r0, r1 ; Subtract r1 from r0
    skpc ; Skip the next instruction if carry flag was set
    jmp.reg r3 ; Jump back to the beginning of dec_loop

add r0, r1 ; Add r1 back to r0 now that r0 underflowed

ld.imm r3, inc_loop ; Make r3 point to inc_loop

inc_loop:
    add r0, r1 ; Add r1 to r0
    skpc ; Skip the next instruction if carry flag was set
    jmp.reg r3 ; Jump back to the beginning of inc_loop

hlttint ; Halt the processor
