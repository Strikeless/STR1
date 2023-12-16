#include "../lib/rules.asm"
#include "../lib/peripherals.asm"

; A "reference" implementation of the serialdisplay program.
;
; Cycles taken (with breakpoint): 985604

; r0 = Constant 1
; r1 = X
; r2 = Y

ld.imm r0, 1

y_loop:
    str.imm P_SERIAL, r2 ; Store the Y coordinate we're about to draw to to serial

    x_loop:
        ; Load a byte from serial to r3
        ld.imm r3, P_SERIAL
        ld.mem r3, r3

        str.imm P_DISPLAY_COLOR, r3 ; Store the loaded byte as the display's color

        add r1, r0 ; Add 1 to our X coordinate tracker
        str.imm P_DISPLAY_X, r1 ; Update the display's X coordinate

        ; Load a pointer to x_loop for the next jump, as we may not 
        ; use jmp.imm due to it being a 2-byte instruction after skpc.
        ld.imm r3, x_loop
        skpc ; Exit x_loop if the X addition carried (thus the line is complete)...
        jmp.reg r3 ; ...or else jump back to the beginning of x_loop
    
    add r2, r0 ; Add 1 to our Y coordinate tracker
    str.imm P_DISPLAY_Y, r2 ; Update the display's Y coordinate

    ; Load a pointer to y_loop for the next jump, as we may not 
    ; use jmp.imm due to it being a 2-byte instruction after skpc.
    ld.imm r3, y_loop
    skpc ; Exit y_loop if the Y addition carried (thus the line is complete)...
    jmp.reg r3 ; ...or else jump back to the beginning of y_loop

; At last, trigger a breakpoint and halt the microprocessor
str.imm P_BREAKPOINT, r0
hlttint 
