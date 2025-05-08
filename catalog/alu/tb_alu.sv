//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-05-08
//     Module Name: tb_alu
//     Description: Test bench for simple behavorial ALU
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module tb_alu;

    parameter N = 8;

    logic [N-1:0] a, b;
    logic [3:0] operation;
    logic sign;
    logic [N-1:0] result;

    alu #(N) dut (
        .a(a),
        .b(b),
        .operation(operation),
        .sign(sign),
        .result(result)
    );

    initial begin
        // Unsigned tests
        sign = 0;

        a = 8'd10; b = 8'd3;

        operation = 4'b0000; #5; $display("UNSIGNED ADD:  %0d + %0d = %0d", a, b, result);
        operation = 4'b0001; #5; $display("UNSIGNED SUB:  %0d - %0d = %0d", a, b, result);
        operation = 4'b0010; #5; $display("UNSIGNED MUL:  %0d * %0d = %0d", a, b, result);
        operation = 4'b0011; #5; $display("UNSIGNED DIV:  %0d / %0d = %0d", a, b, result);
        operation = 4'b0100; #5; $display("UNSIGNED AND:  %0b & %0b = %0b", a, b, result);
        operation = 4'b0101; #5; $display("UNSIGNED OR:   %0b | %0b = %0b", a, b, result);
        operation = 4'b0110; #5; $display("UNSIGNED NOT: ~%0b = %0b", a, result);
        operation = 4'b0111; #5; $display("UNSIGNED SHL:  %0b << %0d = %0b", a, b, result);
        operation = 4'b1000; #5; $display("UNSIGNED SHR:  %0b >> %0d = %0b", a, b, result);

        // Signed tests
        sign = 1;

        a = -8'sd10; b = 8'sd3;

        operation = 4'b0000; #5; $display("SIGNED ADD:  %0d + %0d = %0d", $signed(a), $signed(b), $signed(result));
        operation = 4'b0001; #5; $display("SIGNED SUB:  %0d - %0d = %0d", $signed(a), $signed(b), $signed(result));
        operation = 4'b0010; #5; $display("SIGNED MUL:  %0d * %0d = %0d", $signed(a), $signed(b), $signed(result));
        operation = 4'b0011; #5; $display("SIGNED DIV:  %0d / %0d = %0d", $signed(a), $signed(b), $signed(result));
        operation = 4'b0100; #5; $display("SIGNED AND:  %0b & %0b = %0b", a, b, result);
        operation = 4'b0101; #5; $display("SIGNED OR:   %0b | %0b = %0b", a, b, result);
        operation = 4'b0110; #5; $display("SIGNED NOT: ~%0b = %0b", a, result);
        operation = 4'b0111; #5; $display("SIGNED SHL:  %0b << %0d = %0b", a, b, result);
        operation = 4'b1000; #5; $display("SIGNED SHR:  %0b >> %0d = %0b", a, b, result);

        $finish;
    end

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, tb_alu);
    end

endmodule
