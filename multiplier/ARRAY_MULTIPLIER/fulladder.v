`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2022 08:27:11
// Design Name: 
// Module Name: FullAdder
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


module FullAdder(
    input wire X,
    input wire Y,
    input wire Cin,
    output wire Cout,
    output wire Sum
    );
    
    assign Sum = X ^ Y ^ Cin ;
	assign Cout = (X & Y) | (X & Cin) | (Y & Cin) ;
endmodule
