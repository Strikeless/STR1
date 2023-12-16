#include "../lib/rules.asm"
#include "../lib/peripherals.asm"

; An optimized version of the serialdisplay program's reference implementation
; with some small additional features that haven't been backported to the reference.
;
; The main optimization technique used is lessening the use of immediates in x_loop.
;
; This does not make use of any "risky" assumptions / optimizations, yet still 
; provides a minor performance improvement. It definitely is still far from 
; perfect, but I wasn't able to find any easy optimizations immediately.
;
; Cycles taken (No HICOLOR, LOOPING nor LINE_WIDTH_CUE): 855812
; Cycles taken (HICOLOR, no LOOPING nor LINE_WIDTH_CUE): 1183492

; r0 = Constant 1
; r1 = X
; mem[r0] = Y

LOOPING = false
HICOLOR = true
LINE_WIDTH_CUE = false

ld.imm r0, 1

; Request the first line 

y_loop:
    ; Pre-load registers for x_loop that won't have a different starting value for each iteration
    ld.imm r2, P_SERIAL

    ; Store the Y coordinate we're about to draw to to serial
    ; NOTE: on the first line, r3 hasn't yet been set so it should be 0,
    ;       and on later lines r3 hasn't been overridden since using it for Y.
    str.reg r2, r3 

    #if LINE_WIDTH_CUE {
        ld.mem r1, r2 ; Load a byte from serial to the X coordinate tracker.
    }

    x_loop:
        ld.mem r3, r2 ; Load a byte from serial to r3
        str.imm P_DISPLAY_COLOR, r3 ; Store the loaded byte as the display's color

        #if HICOLOR {
            ld.mem r3, r2 ; Load another byte from serial to r3
            str.imm P_DISPLAY_COLOR_HIGH, r3 ; Store the loaded byte as the display's color high-byte
        }

        add r1, r0 ; Add 1 to our X coordinate tracker
        str.imm P_DISPLAY_X, r1 ; Update the display's X coordinate

        ; Load a pointer to x_loop for the next jump, as we may not 
        ; use jmp.imm due to it being a 2-byte instruction after skpc.
        ld.imm r3, x_loop
        skpc ; Exit x_loop if the X addition carried (thus the line is complete)...
        jmp.reg r3 ; ...or else jump back to the beginning of x_loop
    
    ld.mem r3, r0 ; Load the Y coordinate from memory to r3
    
    add r3, r0 ; Add 1 to our Y coordinate tracker that'll be used on the next line
    str.imm P_DISPLAY_Y, r3 ; Update the display's Y coordinate

    str.reg r0, r3 ; Store the Y coordinate back to memory

    #if LOOPING {
        jmp.imm y_loop
    }
    #else {
        ; Load a pointer to y_loop for the next jump, as we may not 
        ; use jmp.imm due to it being a 2-byte instruction after skpc.
        ld.imm r2, y_loop
        skpc ; Exit y_loop if looping and the Y addition carried (thus the line is complete)...
        jmp.reg r2 ; ...or else jump back to the beginning of y_loop
    }

; At last, trigger a breakpoint and halt the microprocessor.
; This is unreachable if looping, thus the conditional compilation.
#if !LOOPING {
    str.imm P_BREAKPOINT, r0
    hlttint 
}
