//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-04-18
//     Module Name: sl2
//     Description: shift left by 2 (multiply by 4)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef SL2
`define SL2
`timescale 1ns/1ps

module sl2 #(
    parameter int WIDTH = 32   
)(
    input  logic [WIDTH-1:0] A, 
    output logic [WIDTH-1:0] Y 
);

    assign Y = A << 2;

endmodule
`endif // SL2