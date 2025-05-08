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

module alu #(parameter N = 32)(
    input  logic clk,
    input  logic [31:0] a, b,
    input  [3:0] alucontrol,
    output logic [31:0] result,
    input  logic sign,
    output logic zero
);

     logic [2*N-1:0] mult_result;
    logic [N-1:0] hi_reg, lo_reg;

    assign zero = (result == 0);

    always @(*) begin
        mult_result = 0;
        result = 0;

        case (alucontrol)
            4'b0000: result = sign ? $signed(a) + $signed(b) : a + b;
            4'b0001: result = sign ? $signed(a) - $signed(b) : a - b;
            4'b0010: begin 
                mult_result = sign ? $signed(a) * $signed(b) : a * b;
                result = mult_result[N-1:0]; 
            end
            4'b0011: result = sign ? $signed(a) / $signed(b) : a / b;
            4'b0100: result = a & b;
            4'b0101: result = a | b;
            4'b0110: result = ~a;
            4'b0111: result = a << b;
            4'b1000: result = a >> b;
            4'b1110: result = lo_reg; 
            4'b1111: result = hi_reg; 
            default: result = {N{1'b0}};
        endcase
    end

    //  update to hi/lo on mult
    always_ff @(posedge clk) begin
        if (alucontrol == 4'b0010) begin
            hi_reg <= mult_result[2*N-1:N];
            lo_reg <= mult_result[N-1:0];
        end
    end

endmodule

`endif