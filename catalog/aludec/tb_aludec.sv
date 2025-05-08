//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-05-08
//     Module Name: tb_aludec
//     Description: Test bench for simple behavorial ALU decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module tb_aludec;

    logic [1:0] ALUOp;
    logic [5:0] funct;
    logic [3:0] ALUControl;

    // Instantiate DUT
    aludec dut (
        .ALUOp(ALUOp),
        .funct(funct),
        .ALUControl(ALUControl)
    );

    initial begin
        // LW/SW: ADD
        ALUOp = 2'b00; funct = 6'bxxxxxx; #5;
        $display("ALUOp=%b funct=%b --> ALUControl=%b (ADD)", ALUOp, funct, ALUControl);

        // BEQ: SUB
        ALUOp = 2'b01; funct = 6'bxxxxxx; #5;
        $display("ALUOp=%b funct=%b --> ALUControl=%b (SUB)", ALUOp, funct, ALUControl);

        // R-type: ADD
        ALUOp = 2'b10; funct = 6'b100000; #5;
        $display("R-type ADD: funct=%b --> ALUControl=%b", funct, ALUControl);

        // R-type: SUB
        funct = 6'b100010; #5;
        $display("R-type SUB: funct=%b --> ALUControl=%b", funct, ALUControl);

        // R-type: AND
        funct = 6'b100100; #5;
        $display("R-type AND: funct=%b --> ALUControl=%b", funct, ALUControl);

        // R-type: OR
        funct = 6'b100101; #5;
        $display("R-type OR : funct=%b --> ALUControl=%b", funct, ALUControl);

        // R-type: NOR
        funct = 6'b100111; #5;
        $display("R-type NOR: funct=%b --> ALUControl=%b", funct, ALUControl);

        // R-type: SLL
        funct = 6'b000000; #5;
        $display("R-type SLL: funct=%b --> ALUControl=%b", funct, ALUControl);

        // R-type: SRL
        funct = 6'b000010; #5;
        $display("R-type SRL: funct=%b --> ALUControl=%b", funct, ALUControl);

        // R-type: XOR (bonus)
        funct = 6'b100110; #5;
        $display("R-type XOR: funct=%b --> ALUControl=%b", funct, ALUControl);

        // R-type: MULT
        funct = 6'b011000; #5;
        $display("R-type MUL: funct=%b --> ALUControl=%b", funct, ALUControl);

        // R-type: DIV
        funct = 6'b011010; #5;
        $display("R-type DIV: funct=%b --> ALUControl=%b", funct, ALUControl);

        // R-type: INVALID funct
        funct = 6'b111111; #5;
        $display("R-type INVALID: funct=%b --> ALUControl=%b", funct, ALUControl);

        $finish;
    end

    initial begin
        $dumpfile("aludec.vcd");
        $dumpvars(0, tb_aludec);
    end

endmodule
