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
        input logic [1:0] aluop, // ALU operation code
        input logic [5:0] funct, // function code
        output logic [3:0] alucontrol // ALU control signal
    );

    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

    
    always @(*) begin
        case (aluop)
            2'b00: alucontrol = 4'b0000; // add (for lw/sw)
            2'b01: alucontrol = 4'b0001; // sub (for beq)
            2'b10: begin                 // R-type, check funct
                case (funct)
                    6'b100000: alucontrol = 4'b0000; 
                    6'b100010: alucontrol = 4'b0001; 
                    6'b100100: alucontrol = 4'b0100; 
                    6'b100101: alucontrol = 4'b0101; 
                    6'b100111: alucontrol = 4'b0110; 
                    6'b000000: alucontrol = 4'b0111; 
                    6'b000010: alucontrol = 4'b1000; 
                    6'b100110: alucontrol = 4'b0010; 
                    6'b011000: alucontrol = 4'b0010; 
                    6'b011010: alucontrol = 4'b0011; 
                    default:   alucontrol = 4'b1111; 
                endcase
            end
            default: alucontrol = 4'b1111; // Invalid ALUOp
        endcase
    end

endmodule

`endif // ALUDEC