//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-04-18
//     Module Name: clock
//     Description: Clock generator; duty cycle = 50%
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CLOCK
`define CLOCK

`timescale 1ns/100ps

module clock #(
    parameter real PERIOD = 10.0    
)(
    input  wire ENABLE,             
    output reg  CLOCK = 0          
);

    localparam real HALF = PERIOD / 2.0;

    initial begin
        forever begin
            wait (ENABLE);
            while (ENABLE) begin
                #(HALF) CLOCK = ~CLOCK;
            end
            CLOCK = 0;
        end
    end

endmodule

`endif // CLOCK