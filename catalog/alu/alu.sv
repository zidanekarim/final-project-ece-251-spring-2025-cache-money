//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim, Tyler Lee
// 
//     Create Date: 2025-04-18
//     Module Name: alu
//     Description: 32-bit RISC-based CPU alu (MIPS)
//
// Revision: 1.0
// see https://github.com/Caskman/MIPS-Processor-in-Verilog/blob/master/ALU32Bit.v
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`ifndef ALU
`define ALU


module alu #(parameter N = 8)
    (a, b, operation, result, sign);
    input [N-1:0] a, b;
    input logic sign;
    input [3:0] operation;
    output reg [N-1:0] result;

    

    always @(*)
    begin
        if (sign) begin 
            case(operation)
                4'b0000: result = $signed(a) + $signed(b);
                4'b0001: result = $signed(a) - $signed(b);
                4'b0010: result = $signed(a) * $signed(b);
                4'b0011: result = $signed(a) / $signed(b);
                4'b0100: result = a & b;
                4'b0101: result = a | b;
                4'b0110: result = ~a;
                4'b0111: result = a << b;
                4'b1000: result = a >> b;
                default: result = {N{1'b0}};
            endcase


        end
        else begin
            case(operation)
                4'b0000: result = a + b;
                4'b0001: result = a - b;
                4'b0010: result = a * b;
                4'b0011: result = a / b;
                4'b0100: result = a & b;
                4'b0101: result = a | b;
                4'b0110: result = ~a;
                4'b0111: result = a << b;
                4'b1000: result = a >> b;
                default: result = {N{1'b0}};
            endcase
        end 

    end

endmodule: alu

`endif    