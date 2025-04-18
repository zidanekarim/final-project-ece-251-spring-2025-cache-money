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
    label_table = {}
    current_index = 0
    pending_label = None

    for line in lines:
        line = line.strip()
        if not line or line.startswith('#'):
            continue
        parts = line.split()
        if len(parts) < 1:
            print(f"Error: No instruction found in line {line}")
            continue

        print(f"Parsing line: {line}")

        if parts[0].endswith(":"):
            pending_label = parts[0][:-1]
            print(f"Label found: {pending_label}")
            parts = parts[1:]
            if not parts:
                continue

        if parts[0].startswith("."):
            directive = parts[0][1:]
            if directive in ["data", "text", "global", "org", "end"]:
                print(f"{directive.capitalize()} directive found.")
            else:
                print(f"Error: Unknown directive '{directive}'")
                break
            if pending_label:
                label_table[pending_label] = current_index
            instruction = {
                "opcode": None,
                "type": None,
                "funct": None, 
                "registers": None,
                "immediate": None,
                "label": pending_label,
                "endLabel": None,
                "directive": directive,
            }
            parsed_lines.append(instruction)
            pending_label = None
            current_index += 1
            continue

        if len(parts) > 1 and parts[1].startswith("."):
            directive = parts[1][1:]
            if directive in ["data", "text", "global", "org", "end"]:
                print(f"{directive.capitalize()} directive found.")
            else:
                print(f"Error: Unknown directive '{directive}'")
                break
            if pending_label:
                label_table[pending_label] = current_index
            instruction = {
                "opcode": None,
                "type": None,
                "funct": None, 
                "registers": None,
                "immediate": None,
                "label": pending_label,
                "endLabel": None,
                "directive": directive,
            }
            parsed_lines.append(instruction)
            pending_label = None
            current_index += 1
            continue

        # Parse opcode
        opcode = parts[0]
        if opcode not in OPCODES_CONST:
            print(f"Error: Unknown opcode '{opcode}'")
            continue

        register_arr = []
        immediate = None
        endLabel = None
        for reg in parts[1:]:
            if ',' in reg and reg.count(',') > 1:
                reg = reg.split(',')
                for r in reg:
                    r = r.strip()
                    if r.startswith("$"):
                        r = r.rstrip(",")
                        if r not in REGISTERS_CONST:
                            print(f"Error: Unknown register '{r}'")
                            continue
                        register_arr.append(REGISTERS_CONST[r])
                    elif r.isdigit() or (r[0] == '-' and r[1:].isdigit()):
                        immediate = int(r)
                        print(f"Immediate value: {immediate}")
                        if immediate < -32768 or immediate > 32767:
                            print(f"Error: Immediate value '{immediate}' out of range")
                            continue
                    elif r.startswith('#'):
                        break
                    elif ')' in r and '(' in r:
                        offset, base = r.replace(')', '').split('(')
                        immediate = int(offset)
                        base = base.strip()
                        if base not in REGISTERS_CONST:
                            print(f"Error: Unknown base register '{base}'")
                            continue
                        register_arr.append(REGISTERS_CONST[base])
                break 

            reg = reg.strip()
            if reg.startswith("$"):
                reg = reg.rstrip(",")
                if reg not in REGISTERS_CONST:
                    print(f"Error: Unknown register '{reg}'")
                    continue
                register_arr.append(REGISTERS_CONST[reg])
            elif reg.isdigit() or (reg[0] == '-' and reg[1:].isdigit()):
                immediate = int(reg)
                print(f"Immediate value: {immediate}")
                if immediate < -32768 or immediate > 32767:
                    print(f"Error: Immediate value '{immediate}' out of range")
                    continue
            elif reg.startswith('#'):
                break
            elif ')' in reg and '(' in reg:
                offset, base = reg.replace(')', '').split('(')
                immediate = int(offset)
                base = base.strip()
                if base not in REGISTERS_CONST:
                    print(f"Error: Unknown base register '{base}'")
                    continue
                register_arr.append(REGISTERS_CONST[base])

            elif reg.endswith(":"):
                endLabel = reg[:-1]

        if len(register_arr) > 3:
            print(f"Error: Too many registers in line {line}")
            continue

        instruction = {
            "opcode": OPCODES_CONST[opcode][0],
            "type": OPCODES_CONST[opcode][1],
            "funct": OPCODES_CONST[opcode][2] if OPCODES_CONST[opcode][1] == 'R' else None,
            "registers": register_arr,
            "immediate": immediate,
            "label": None,
            "endLabel": endLabel,
            "directive": None,
        }

        if pending_label:
            label_table[pending_label] = current_index
            instruction["label"] = pending_label
            pending_label = None

        parsed_lines.append(instruction)
        current_index += 1

    print("Label Table:")
    for label, idx in label_table.items():
        print(f"{label}: {idx}")

    return (parsed_lines, label_table)



lines = parse_file(get_args())
parsed_lines_return = parse_lines(lines)
parsed_lines, label_table = parsed_lines_return


if not parsed_lines:
    print("No valid instructions found.")
    sys.exit(1)
else:
    print("Valid instructions found.")
    
    print("Parsed instructions:")
    for instruction in parsed_lines:
        print(instruction)

def assemble(parsed_lines, label_table):
    machine_code = []

    for i, instr in enumerate(parsed_lines):
        if instr["directive"]:
            continue 

        opcode = instr["opcode"]
        instr_type = instr["type"]

        if instr_type == "R":
            rd = instr["registers"][0] if len(instr["registers"]) > 0 else 0
            rs = instr["registers"][1] if len(instr["registers"]) > 1 else 0
            rt = instr["registers"][2] if len(instr["registers"]) > 2 else 0
            shamt = 0  # idk if we ever need to use for our assembler
            funct = instr["funct"]
            code = (opcode << 26) | (rs << 21) | (rt << 16) | (rd << 11) | (shamt << 6) | funct 
            # this is basically shifting the bits to the left and ORing them together, which is like a bitmask to follow the MIPS instruction format
            # opcode: 6 bits, rs: 5 bits, rt: 5 bits, rd: 5 bits, shamt: 5 bits, funct: 6 bits

        elif instr_type == "I":
            rt = instr["registers"][0] if len(instr["registers"]) > 0 else 0
            rs = instr["registers"][1] if len(instr["registers"]) > 1 else 0
            imm = instr["immediate"] if instr["immediate"] is not None else 0

            if instr["endLabel"]: 
                target_index = label_table.get(instr["endLabel"])
                if target_index is None:
                    print(f"Error: Label {instr['endLabel']} not found.")
                    continue
                imm = target_index - (i + 1)  # relative address so we subtract the current index + 1 (next instruction) from the label index, grows downward

            imm &= 0xFFFF  # mask to 16 bits, 1 hex digit = 4 bits, so 4 hex digits = 16 bits
            # this is to ensure the immediate value fits in 16 bits, since MIPS uses 16 bit signed integers
            code = (opcode << 26) | (rs << 21) | (rt << 16) | imm
            # opcode: 6 bits, rs: 5 bits, rt: 5 bits, immediate: 16 bits
        elif instr_type == "J":
            if instr["endLabel"] is None:
                print(f"Error: J-type instruction missing label.")
                continue
            target_index = label_table.get(instr["endLabel"])
            if target_index is None:
                print(f"Error: Label {instr['endLabel']} not found.")
                continue
            address = target_index  
            code = (opcode << 26) | (address & 0x03FFFFFF)
            # opcode: 6 bits, address (immediate or register): 26 bits
            # note the 0x03FFFFFF is maximum value for signed 26 bits, so we are masking the address to fit in 26 bits
            # maybe switch to unsigned since its an address? not really sure

        else:
            print(f"Unknown instruction type at line {i}")
            continue

        machine_code.append(code) # storing machine code array

    return machine_code

with open("program.dat", "w") as f:
    for code in assemble(parsed_lines, label_table):
        f.write(f"{code:08x}\n")  