//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-04-18
//     Module Name: tb_adder
//     Description: Test bench for simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps

module tb_adder;
    parameter int WIDTH = 32;
    reg  [WIDTH-1:0] a, b;
    wire [WIDTH-1:0] y;

    // dump & monitor
    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, tb_adder);
        $display("\n time(ns) |       A       |       B       |       Y");
        $monitor("%8t | 0x%0h | 0x%0h | 0x%0h", $time, a, b, y);
    end

    initial begin
        a = 0;            b = 0;            #10;
        a = 1;            b = 1;            #10;
        a = 'hFFFFFFFF;   b = 1;            #10;
        a = 'h7FFFFFFF;   b = 1;            #10;
        a = 'hFFFFFFFF;   b = 'hFFFFFFFF;   #10;
        $finish;
    end

    // instantiate DUT (adder.sv must be compiled alongside)
    adder #(.WIDTH(WIDTH)) uut (
        .A(a), .B(b), .Y(y)
    );
endmodule