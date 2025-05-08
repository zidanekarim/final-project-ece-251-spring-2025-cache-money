//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-05-08
//     Module Name: tb_controller
//     Description: Test bench for controller
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module tb_controller;

    logic [5:0] op, funct;
    logic zero;
    logic memtoreg, memwrite, pcsrc, alusrc;
    logic regdst, regwrite, jump;
    logic [3:0] alucontrol;

    // Instantiate the controller
    controller dut (
        .op(op), .funct(funct), .zero(zero),
        .memtoreg(memtoreg), .memwrite(memwrite),
        .pcsrc(pcsrc), .alusrc(alusrc),
        .regdst(regdst), .regwrite(regwrite),
        .jump(jump), .alucontrol(alucontrol)
    );

    initial begin
        op = 6'b000000; funct = 6'b100000; zero = 0; #5;
        $display("R-type ADD: alucontrol=%b regdst=%b regwrite=%b memtoreg=%b memwrite=%b alusrc=%b pcsrc=%b jump=%b",
                  alucontrol, regdst, regwrite, memtoreg, memwrite, alusrc, pcsrc, jump);

        op = 6'b100011; funct = 6'bxxxxxx; zero = 0; #5;
        $display("LW: alucontrol=%b regdst=%b regwrite=%b memtoreg=%b memwrite=%b alusrc=%b pcsrc=%b jump=%b",
                  alucontrol, regdst, regwrite, memtoreg, memwrite, alusrc, pcsrc, jump);

        op = 6'b101011; funct = 6'bxxxxxx; zero = 0; #5;
        $display("SW: alucontrol=%b regdst=%b regwrite=%b memtoreg=%b memwrite=%b alusrc=%b pcsrc=%b jump=%b",
                  alucontrol, regdst, regwrite, memtoreg, memwrite, alusrc, pcsrc, jump);

        op = 6'b000100; funct = 6'bxxxxxx; zero = 0; #5;
        $display("BEQ (zero=0): pcsrc=%b", pcsrc);

        op = 6'b000100; funct = 6'bxxxxxx; zero = 1; #5;
        $display("BEQ (zero=1): pcsrc=%b", pcsrc);

        op = 6'b000010; funct = 6'bxxxxxx; zero = 0; #5;
        $display("JUMP: jump=%b", jump);

        $finish;
    end

    initial begin
        $dumpfile("controller.vcd");
        $dumpvars(0, tb_controller);
    end

endmodule
