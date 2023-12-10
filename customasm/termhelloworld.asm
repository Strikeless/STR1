#include "lib/rules.asm"
#include "lib/peripherals.asm"

ld.imm r0, 1 ; Constant 1
ld.imm r1, message ; Message address
ld.imm r2, 255 - MESSAGE_LEN ; Maximum value of a word - the length of the message

print_char:
    ld.prg r3, r1 ; Load character from message to r3
    str.imm P_TERMINAL, r3 ; Print the character by storing it in the terminal peripheral

    add r1, r0 ; Add 1 to the character index/address

    add r2, r0 ; Add 1 to r2, so that it overflows when all characters have been iterated
    skpc ; Skip the next jump if a carry occurred due to overflow
    jmp.imm print_char ; Jump back to the beginning of the loop to print the next character

hlttint ; Halt the microprocessor

message:
    #d "Hello, world!"
MESSAGE_LEN = $ - message
