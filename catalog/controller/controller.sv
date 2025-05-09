//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-05-08
//     Module Name: controller
//     Description: 32-bit RISC-based CPU controller (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CONTROLLER
`define CONTROLLER

`timescale 1ns/100ps

`include "../maindec/maindec.sv"
`include "../aludec/aludec.sv"

module controller
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [5:0] op, funct,
    input  logic       zero,
    output logic       memtoreg, memwrite,
    output logic       pcsrc, alusrc,
    output logic       regdst, regwrite,
    output logic       jump,
    output logic [3:0] alucontrol
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [1:0] aluop;
    logic       branch;
    
    // CPU main decoder
    maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);
    // CPU's ALU decoder
    aludec  ad(aluop, funct, alucontrol);

  assign pcsrc = branch & zero;

endmodule

`endif // CONTROLLER
