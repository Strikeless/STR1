#include "lib/rules.asm"
#include "lib/peripherals.asm"

ld.imm r0, 1 ; Constant 1
ld.imm r1, message ; Message address
ld.imm r2, 255 - MESSAGE_LEN

print_char:
    ld.imm.reg r3, r1 ; TODO: Make this chaos of an instruction into reality
    str.imm P_TERMINAL, r3

    add r2, r1
    add r0, r1

    skpc
    jmp.imm print_char

hlttint

message:
    #d "Hello, world!"
MESSAGE_LEN = $ - message
