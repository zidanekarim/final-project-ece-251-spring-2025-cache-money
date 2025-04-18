//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-04-18
//     Module Name: tb_mux2
//     Description: Test bench for 2 to 1 multiplexer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_MUX2
`define TB_MUX2

`timescale 1ns/100ps

`include "../clock/clock.sv"

module tb_mux2;
    parameter n = 32;             

    logic            s;
    logic [n-1:0]    d0, d1;
    logic [n-1:0]    y;
    logic            enable;
    wire             clk;

    // dump all signals
    initial begin
        $dumpfile("mux2.vcd");
        $dumpvars(0, tb_mux2);
    end

    initial begin
        s      = 0;
        d0     = 'hAAAAAAAA;
        d1     = 'h55555555;
        enable = 1;

        #10  s = 0;    
        #20  s = 1;    
        #100 enable = 0; 
        #5   $finish;
    end

    mux2 #(.n(n)) uut (
        .S  (s),
        .D0 (d0),
        .D1 (d1),
        .Y  (y)
    );

    clock clkgen (
        .ENABLE(enable),
        .CLOCK (clk)
    );
endmodule

`endif // TB_MUX2