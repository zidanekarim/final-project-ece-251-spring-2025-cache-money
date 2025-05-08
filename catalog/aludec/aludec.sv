//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
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
        input logic [1:0] ALUOp, // ALU operation code
        input logic [5:0] funct, // function code
        output logic [3:0] ALUControl // ALU control signal
    );

    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 4'b0000; // add (for lw/sw)
            2'b01: ALUControl = 4'b0001; // sub (for beq)
            2'b10: begin                 // R-type, check funct
                case (funct)
                    6'b100000: ALUControl = 4'b0000; // add
                    6'b100010: ALUControl = 4'b0001; // sub
                    6'b100100: ALUControl = 4'b0100; // and
                    6'b100101: ALUControl = 4'b0101; // or
                    6'b100111: ALUControl = 4'b0110; // nor (~a)
                    6'b000000: ALUControl = 4'b0111; // sll
                    6'b000010: ALUControl = 4'b1000; // srl
                    6'b100110: ALUControl = 4'b0010; // xor (bonus baddie)
                    6'b011000: ALUControl = 4'b0010; // mult (alias for * slay)
                    6'b011010: ALUControl = 4'b0011; // div (alias for / yas)
                    default:   ALUControl = 4'b1111; // INVALID. Like my GPA rn 💀
                endcase
            end
            default: ALUControl = 4'b1111; // Invalid ALUOp
        endcase
    end

endmodule

`endif // ALUDEC