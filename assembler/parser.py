import os
import subprocess
import sys

OPCODES_CONST = {
    # operation: [opcode, type, funct], funct for R-type instructions
    
    # R-type instructions (opcode = 0)
    "add"   : [0x00, 'R', 0x20],
    "addu"  : [0x00, 'R', 0x21],
    "sub"   : [0x00, 'R', 0x22],
    "subu"  : [0x00, 'R', 0x23],
    "and"   : [0x00, 'R', 0x24],
    "or"    : [0x00, 'R', 0x25],
    "xor"   : [0x00, 'R', 0x26],
    "nor"   : [0x00, 'R', 0x27],
    "slt"   : [0x00, 'R', 0x2A],
    "sltu"  : [0x00, 'R', 0x2B],
    "sll"   : [0x00, 'R', 0x00],
    "srl"   : [0x00, 'R', 0x02],
    "sra"   : [0x00, 'R', 0x03],
    "jr"    : [0x00, 'R', 0x08],
    "mult"  : [0x00, 'R', 0x18],
    "multu" : [0x00, 'R', 0x19],
    "div"   : [0x00, 'R', 0x1A],
    "mfhi"  : [0x00, 'R', 0x10],
    "mflo"  : [0x00, 'R', 0x12],

    # I-type instructions
    "addi"  : [0x08, 'I'],
    "addiu" : [0x09, 'I'],
    "andi"  : [0x0C, 'I'],
    "ori"   : [0x0D, 'I'],
    "xori"  : [0x0E, 'I'],
    "slti"  : [0x0A, 'I'],
    "sltiu" : [0x0B, 'I'],
    "lw"    : [0x23, 'I'],
    "sw"    : [0x2B, 'I'],
    "lb"    : [0x20, 'I'],
    "lbu"   : [0x24, 'I'],
    "lh"    : [0x21, 'I'],
    "lhu"   : [0x25, 'I'],
    "sb"    : [0x28, 'I'],
    "sh"    : [0x29, 'I'],
    "lui"   : [0x0F, 'I'],
    "beq"   : [0x04, 'I'],
    "bne"   : [0x05, 'I'],
    "blez"  : [0x06, 'I'],
    "bgtz"  : [0x07, 'I'],
    "bltz"  : [0x01, 'I'],
    "bgez"  : [0x01, 'I'],  

    # J-type instructions
    "j"     : [0x02, 'J'],
    "jal"   : [0x03, 'J']
}




REGISTERS_CONST = {
    "$zero": 0,
    "$at": 1,
    "$v0": 2,
    "$v1": 3,
    "$a0": 4,
    "$a1": 5,
    "$a2": 6,
    "$a3": 7,
    "$t0": 8,
    "$t1": 9,
    "$t2": 10,
    "$t3": 11,
    "$t4": 12,
    "$t5": 13,
    "$t6": 14,
    "$t7": 15,
    "$s0": 16,
    "$s1": 17,
    "$s2": 18,
    "$s3": 19,
    "$s4": 20,
    "$s5": 21,
    "$s6": 22,
    "$s7": 23,
    "$t8": 24,
    "$t9": 25,
    "$k0": 26, # reservd for kernel
    "$k1": 27, # reservd for kernel
    "$gp": 28,
    "$sp": 29,
    "$fp": 30,
    "$ra": 31,
    
}

def get_args():
    if len(sys.argv) != 2:
        print("Usage: python3 assembler.py <filename.asm>")
        sys.exit(1)
    filename = sys.argv[1]
    if not os.path.isfile(filename):
        print(f"File {filename} does not exist.")
        sys.exit(1)
    if not filename.endswith(".asm"):
        print("File must have .asm extension.")
        sys.exit(1)
    return filename

def parse_file(filename):
    with open(filename, 'r') as file:
        lines = file.readlines()
    return lines

def parse_lines(lines):
    parsed_lines = []
    for line in lines:
        line = line.strip()
        if not line or line.startswith("#"):  # ignore empty lines and comments
            continue
        parts = line.split()
        if len(parts) < 1:
            print(f"Error: No instruction found in line {line}")
            continue
        if len(parts) > 4:
            print(f"Error: Too many arguments in line {line}")
            continue
        

        if parts[0].endswith(":"):
            label = parts[0][:-1]
        if parts[0].startswith("."):
            directive = parts[0][1:]
            if directive == "data":
                print("Data directive found.")
                continue
            elif directive == "text":
                print("Text directive found.")
                continue
            elif directive == "global":
                print("Global directive found.")
                continue
            elif directive == "org":
                print("Org directive found.")
                continue
            elif directive == "end":
                print("End directive found.")
                continue
            else:
                print(f"Error: Unknown directive '{directive}'")
                continue
        if label is not None:
            parts = parts[1:]
        opcode = parts[0]
        if opcode not in OPCODES_CONST:
            print(f"Error: Unknown opcode '{opcode}'")
            continue
        register_arr = parts[1]
        if len(register_arr) > 3:
            print(f"Error: Too many registers in line {line}")
            continue




        if opcode not in opcodes:
            print(f"Error: Unknown opcode '{opcode}'")
            continue
        parsed_lines.append(parts)
    return parsed_lines


lines = parse_file(get_args())
parsed_lines = parse_lines(lines)

if not parsed_lines:
    print("No valid instructions found.")
    sys.exit(1)
else:
    print("Valid instructions found.")
    print(parsed_lines)

    