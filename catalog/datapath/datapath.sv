//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-05-08
//     Module Name: datapath
//     Description: 32-bit RISC-based CPU datapath (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DATAPATH
`define DATAPATH

`timescale 1ns/100ps

`include "../regfile/regfile.sv"
`include "../alu/alu.sv"
`include "../dff/dff.sv"
`include "../adder/adder.sv"
`include "../sl2/sl2.sv"
`include "../mux2/mux2.sv"
`include "../signext/signext.sv"

module datapath
    #(parameter n = 32)(
    input  logic        clk, reset,
    input  logic        memtoreg, pcsrc,
    input  logic        alusrc, regdst,
    input  logic        regwrite, jump,
    input  logic [3:0]  alucontrol,
    output logic        zero,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instr,
    output logic [(n-1):0] aluout, writedata,
    input  logic [(n-1):0] readdata
);
    logic [4:0]  writereg;
    logic [(n-1):0] pcnext, pcnextbr, pcplus4, pcbranch;
    logic [(n-1):0] signimm, signimmsh;
    logic [(n-1):0] srca, srcb;
    logic [(n-1):0] result;
    logic jr;

    assign jr = (instr[31:26] == 6'b000000) && (instr[5:0] == 6'b001000); // jr detection

    dff #(n) pcreg(clk, reset, 1'b1, pcnext, pc);
    adder pcadd1(pc, 32'b100, pcplus4);
    sl2 immsh(signimm, signimmsh);
    adder pcadd2(pcplus4, signimmsh, pcbranch);
    mux2 #(n) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);

    // mux for jump or jr
    logic [n-1:0] jumpdest;
    assign jumpdest = jr ? srca : {pcplus4[31:28], instr[25:0], 2'b00};
    mux2 #(n) pcmux(pcnextbr, jumpdest, jump, pcnext);

    regfile rf(clk, regwrite, instr[25:21], instr[20:16], writereg, result, srca, writedata);

    logic jal;
    assign jal = (instr[31:26] == 6'b000011);

    //mux2 #(5) wrmux(instr[20:16], instr[15:11], regdst, writereg);
    assign writereg = jal ? 5'd31 : (regdst ? instr[15:11] : instr[20:16]);

    signext se(instr[15:0], signimm);
    mux2 #(n) srcbmux(writedata, signimm, alusrc, srcb);

    alu alu(clk, srca, srcb, alucontrol, aluout, 1'b1, zero);

    assign result = jal ? pcplus4 : (memtoreg ? readdata : aluout);
endmodule

`endif // DATAPATH