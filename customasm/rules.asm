#fn instruction(instruction, regA, regB) => instruction`4 @ regA`2 @ regB`2

#subruledef reg {
    r{reg} => reg`2
}

#subruledef immed {
    ${value: u8} => value`8

    {value: u8} => value`8
}

#ruledef {
    hlttint => instruction(0x0, 0, 0)

    ld.imm {destReg: reg}, {srcImmed: immed} => instruction(0x1, destReg, 0) @ srcImmed

    ld.mem {destReg: reg}, {addrReg: reg} => instruction(0x2, destReg, addrReg)

    str {addrReg: reg}, {srcReg: reg} => instruction(0x3, addrReg, srcReg)

    cpy {destReg: reg}, {srcReg: reg} => instruction(0x4, destReg, srcReg)

    add {a: reg}, {b: reg} => instruction(0x5, a, b)

    sub {a: reg}, {b: reg} => instruction(0x6, a, b)

    mul {a: reg}, {b: reg} => instruction(0x7, a, b)

    lsl {a: reg}, {b: reg} => instruction(0x8, a, b)

    lsr {a: reg}, {b: reg} => instruction(0x9, a, b)

    and {a: reg}, {b: reg} => instruction(0xA, a, b)

    or {a: reg}, {b: reg} => instruction(0xB, a, b)

    xor {a: reg}, {b: reg} => instruction(0xC, a, b)

    jmp {addrReg: reg} => instruction(0xD, addrReg, 0)

    skpc => instruction(0xE, 0, 0)
}
