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


module alu #(parameter N = 32)
    (clk, a, b, alucontrol, result, sign, zero);
    input logic clk;
    input [N-1:0] a, b;
    input logic sign;
    input logic zero;
    input [3:0] alucontrol;
    output reg [N-1:0] result;

    logic [N+N-1:0] HiLo;
    logic Hi, Lo;

    assign zero = (result == 0) ? 1'b1 : 1'b0; // Set zero flag if result is zero
    

    always @(posedge clk)  // Use posedge clk to trigger the operation
    begin
        if (sign) begin 
            case(alucontrol)
                4'b0000: result = $signed(a) + $signed(b);
                4'b0001: result = $signed(a) - $signed(b);
                4'b0010: begin
                    HiLo = $signed(a) * $signed(b);
                    Hi = HiLo[N-1:N/2];
                    Lo = HiLo[N/2-1:0];
                    result = Lo;
                end
                4'b0011: begin 
                    HiLo = $signed(a) / $signed(b);
                    Hi = HiLo[N-1:N/2];
                    Lo = HiLo[N/2-1:0];
                    result = Lo;
                end
                4'b0100: result = a & b;
                4'b0101: result = a | b;
                4'b0110: result = ~a;
                4'b0111: result = a << b;
                4'b1000: result = a >> b;
                default: result = {N{1'b0}};
            endcase


        end
        else begin
            case(alucontrol)
                4'b0000: result = a + b;
                4'b0001: result = a - b;
                4'b0010: begin
                    HiLo = a * b;
                    Hi = HiLo[N-1:N/2];
                    Lo = HiLo[N/2-1:0];
                    result = Lo;
                end
                4'b0011: begin 
                    HiLo =  a / b;
                    Hi = HiLo[N-1:N/2];
                    Lo = HiLo[N/2-1:0];
                    result = Lo;
                end
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