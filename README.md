# STR1
A crappy 8-bit homebrew microprocessor design implemented in [Digital](https://github.com/hneemann/digital).

## Features
* A whopping 15 instructions!
* Separate program memory and memory with up to 256 addresses!
* No external IO to get in your way!
* A single instruction for branching with the carry flag!
* Great performance with the mess of an independent PC adder!
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
