//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-04-18
//     Module Name: tb_clock
//     Description: Test bench for clock generator
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_CLOCK
`define TB_CLOCK

`timescale 1ns/100ps

module tb_clock;
    parameter real PERIOD = 10.0;

    reg  enable = 0;
    wire clk;

    clock #(.PERIOD(PERIOD)) uut (
        .ENABLE(enable),
        .CLOCK (clk)
    );

    initial begin
        $dumpfile("clock.vcd");
        $dumpvars(0, tb_clock);
    end

    initial begin
        $monitor("%0t ns | ENABLE=%b | CLK=%b", $time, enable, clk);
    end

    initial begin
        #0   enable = 0;   
        #10  enable = 1;   
        #100 enable = 0;   
        #10  $finish;      
    end

endmodule

`endif // TB_CLOCK