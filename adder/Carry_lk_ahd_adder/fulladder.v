`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2022 21:48:24
// Design Name: 
// Module Name: FULLADDER
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FULLADDER(
    input wire  X,
    input  wire  Y,
    input  wire Cin,
    output  wire G,
    output  wire P,
    output  wire Sum
    );
      
    wire P_int;
assign G = X & Y ;
assign P = P_int ;
assign P_int = X ^ Y ;
assign Sum = P_int ^ Cin ;
endmodule
