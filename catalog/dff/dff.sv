//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim, Tyler Lee
// 
//     Create Date: 2025-04-18
//     Module Name: dff
//     Description: 32 bit D flip flop
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DFF
`define DFF

`timescale 1ns/100ps

module dff
    //
    // ---------------- DECLARATIONS OF PORT IN/OUT & DATA TYPES ----------------
    //
(
  input logic clk,
  input logic rst,
  input logic enable,
  input logic d,
  output logic q
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
  always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
      q <= 0; // Synchronous reset
    end else if (enable) begin
      q <= d; // Data is loaded only when enable is high
    end
  end
endmodule : dff
`endif // dff