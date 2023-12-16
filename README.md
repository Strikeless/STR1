# STR1
A crappy 8-bit homebrew microprocessor design implemented in [Digital](https://github.com/hneemann/digital).

## Features
* A whopping 16 instructions!
* Separate program memory and memory with up to 256 addresses!
* No external IO to get in your way!
* A single instruction for branching with the carry flag!
* "Great" performance with the mess of an independent PC adder!
* Free microcode written with a private microassembler!

## Use cases
uhh

## The microcode
The microcode for the Digital implementation can be found in the DigitalImpl/microcode directory,
both in source and assembled Intel HEX form.

Even though the microcode source is provided, it is mostly useless besides for reading how it is implemented.
This is due to the microassembler it is made for being my own microassembler that I have not released publically,
due to it being very incomplete and poorly written.

I will most likely not be finishing nor releasing the microassembler, however I am working on a Rust library
for implementing microcode, and I will most likely create a standalone, retargetable microassembler based on it,
which I will be releasing publically when/if it becomes usable.

## The ALU
Avoid looking at the ALU. You will be dissappointed and disgusted.

## Things I certainly should've done differently
* The goal of most instructions taking only one word of program memory
    * This means most instructions can be executed in only a single clock cycle
    * This is very limiting on the amount of instructions and registers
    * The microprocessor's capabilities suffered greatly from the fact that there may only be 16 instructions
        * Incredibly limited branching
        * Limited arithmetic and bitwise operations
        * No stack, interrupts, etc
    * More complex operations become trickier due to only having 4 registers
    * Maybe this wouldn't have been so bad if a word was 16-bits...
* The way instruction fetch is done
    * The "next fetch mode" means that registers are accessible on the first cycle of an instruction, yet can still be made available in later cycles
    * The entire instruction fetching is a great pile of mess
    * The "next fetch mode" has caused so much headache
    * The "PCM_ONECARRY" (```PC = PC + 1 + CARRY```) PC mode is such a bad way of branching, and it doesn't even work as intended if the next instruction takes more than one byte of program memory
* The ALU
    * This ALU is just a paste from my earlier, even crappier microprocessor design
    * Most of it's functions aren't even used due to the tiny instruction set
    * A 74181 would've done just fine, and it wouldn't have been such a mess
