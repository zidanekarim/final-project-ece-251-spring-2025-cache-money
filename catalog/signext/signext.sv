//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-04-18
//     Module Name: signext
//     Description: 16 to 32 bit sign extender
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef SIGNEXT
`define SIGNEXT
`timescale 1ns/1ps

module signext #(
    parameter IN_WIDTH  = 16,   // width of input A
    parameter OUT_WIDTH = 32    // width of output Y
)(
    input  logic [IN_WIDTH-1:0]  A,
    output logic [OUT_WIDTH-1:0] Y
);
    assign Y = {{(OUT_WIDTH-IN_WIDTH){A[IN_WIDTH-1]}}, A};

endmodule
`endif // SIGNEXT