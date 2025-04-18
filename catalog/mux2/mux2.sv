//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2025
// Engineer: Zidane Karim & Tyler Lee
// 
//     Create Date: 2025-04-18
//     Module Name: mux2
//     Description: 2 to 1 multiplexer (parameterizable width)
// Revision: 1.0
//////////////////////////////////////////////////////////////////////////////////

`ifndef MUX2
`define MUX2

module mux2 #(
    parameter n = 32           // width of data ports
)(
    input  logic        S,     // select
    input  logic [n-1:0] D0,    // data input 0
    input  logic [n-1:0] D1,    // data input 1
    output logic [n-1:0] Y      // output
);
    // simple combinational 2:1 mux
    assign Y = S ? D1 : D0;
endmodule

`endif // MUX2