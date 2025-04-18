//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-04-18
//     Module Name: tb_signext
//     Description: Test bench for sign extender
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_SIGNEXT
`define TB_SIGNEXT
`timescale 1ns/1ps

`include "signext.sv"

module tb_signext;
    parameter IN_WIDTH  = 16;
    parameter OUT_WIDTH = 32;

    reg  [IN_WIDTH-1:0]   A;
    wire [OUT_WIDTH-1:0]  Y;

    signext #(
        .IN_WIDTH(IN_WIDTH),
        .OUT_WIDTH(OUT_WIDTH)
    ) uut (
        .A(A),
        .Y(Y)
    );

    initial begin
        $dumpfile("signext.vcd");
        $dumpvars(0, tb_signext);
    end

    initial begin
        $display("\n time(ns) |    A (hex)   |    Y (hex)");
        $monitor("%8t | %4h         | %8h", $time, A, Y);
    end

    initial begin
        A = 16'h0000; #10;  // zero
        A = 16'h7FFF; #10;  // max positive
        A = 16'h8000; #10;  // min negative
        A = 16'hFFFF; #10;  // –1
        $finish;
    end

endmodule
`endif // TB_SIGNEXT