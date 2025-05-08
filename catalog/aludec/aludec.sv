//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-05-08
//     Module Name: aludec
//     Description: 32-bit RISC ALU decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALUDEC
`define ALUDEC

`timescale 1ns/100ps

module aludec
    //
    // ---------------- PORT DEFINITIONS ----------------
    //

    #(parameter n = 32)( 
        input logic [1:0] aluop, // ALU operation code
        input logic [5:0] funct, // function code
        output logic [3:0] alucontrol // ALU control signal
    );

    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

      // ALU Control Legend 
    localparam ALU_ADD   = 4'b0000;
    localparam ALU_SUB   = 4'b0001;
    localparam ALU_AND   = 4'b0100;
    localparam ALU_OR    = 4'b0101;
    localparam ALU_NOR   = 4'b0110;
    localparam ALU_SLL   = 4'b0111;
    localparam ALU_SRL   = 4'b1000;
    localparam ALU_XOR   = 4'b1001;
    localparam ALU_MULT  = 4'b0010;
    localparam ALU_MFLO  = 4'b1110;
    localparam ALU_MFHI  = 4'b1111;
    localparam ALU_INVALID = 4'bxxxx;

    always @(*) begin
        case (aluop)
            2'b00: alucontrol = ALU_ADD;       // lw/sw/addi
            2'b01: alucontrol = ALU_SUB;       // beq
            2'b10: begin                       // R-type decode
                case (funct)
                    6'b100000: alucontrol = ALU_ADD;     // add
                    6'b100010: alucontrol = ALU_SUB;     // sub
                    6'b100100: alucontrol = ALU_AND;     // and
                    6'b100101: alucontrol = ALU_OR;      // or
                    6'b100111: alucontrol = ALU_NOR;     // nor
                    6'b000000: alucontrol = ALU_SLL;     // sll
                    6'b000010: alucontrol = ALU_SRL;     // srl
                    6'b100110: alucontrol = ALU_XOR;     // xor
                    6'b011000: alucontrol = ALU_MULT;    // mult
                    6'b010000: begin                     // mfhi
                        alucontrol = ALU_MFHI;
                    end
                    6'b010010: begin                     // mflo
                        alucontrol = ALU_MFLO;
                    end
                    default: alucontrol = ALU_INVALID;
                endcase
            end
            default: alucontrol = ALU_INVALID;
        endcase
    end


endmodule

`endif // ALUDEC