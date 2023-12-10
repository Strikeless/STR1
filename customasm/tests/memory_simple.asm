#include "../lib/rules.asm"

ld.imm r0, 137 ; Load 137 to r0

ld.imm r3, 1 ; Load 1 to r3
str.reg r3, r0 ; Store r0(137) to memory at r3(1)

; Load memory at r3(1) to all of the registers
ld.mem r0, r3
ld.mem r1, r3
ld.mem r2, r3
ld.mem r3, r3

hlttint
