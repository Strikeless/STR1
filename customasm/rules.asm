#fn instruction(instruction, regA, regB) => instruction`4 @ regA`2 @ regB`2
#fn immediate(immediate) => immediate`8

#ruledef {
    hlttint => instruction(0x0, 0, 0)

    ld.imm r{destReg}, {srcImmed} => instruction(0x1, destReg, 0) @ immediate(srcImmed)

    ld.mem r{destReg}, r{addrReg} => instruction(0x2, destReg, addrReg)

    str r{addrReg}, r{srcReg} => instruction(0x3, addrReg, srcReg)

    cpy r{destReg}, r{srcReg} => instruction(0x4, destReg, srcReg)

    add r{a}, r{b} => instruction(0x5, a, b)

    sub r{a}, r{b} => instruction(0x6, a, b)

    mul r{a}, r{b} => instruction(0x7, a, b)

    lsl r{a}, r{b} => instruction(0x8, a, b)

    lsr r{a}, r{b} => instruction(0x9, a, b)

    and r{a}, r{b} => instruction(0xA, a, b)

    or r{a}, r{b} => instruction(0xB, a, b)

    xor r{a}, r{b} => instruction(0xC, a, b)

    jmp r{addrReg} => instruction(0xD, addrReg, 0)
}
