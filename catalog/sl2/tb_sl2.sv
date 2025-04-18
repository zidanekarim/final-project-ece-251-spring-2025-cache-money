//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-04-18
//     Module Name: tb_sl2
//     Description: Test bench for shift left by 2 (multiply by 4)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_SL2
`define TB_SL2
`timescale 1ns/1ps

`include "sl2.sv"

module tb_sl2;
    parameter int WIDTH = 32;

    reg  [WIDTH-1:0] A;
    wire [WIDTH-1:0] Y;

    sl2 #(.WIDTH(WIDTH)) uut (
        .A(A),
        .Y(Y)
    );

    initial begin
        $dumpfile("sl2.vcd");
        $dumpvars(0, tb_sl2);
    end

    initial begin
        $display("\n time(ns) |       A       |       Y");
        $monitor("%8t | 0x%0h | 0x%0h", $time, A, Y);
    end

    initial begin
        A = 32'h0000_0001; #10;  
        A = 32'h0000_FFFF; #10; 
        A = 32'h8000_0000; #10;  
        A = 32'h1234_5678; #10;  
        $finish;
    end

endmodule
`endif // TB_SL2