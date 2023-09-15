`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2022 21:43:08
// Design Name: 
// Module Name: CLALOGIC
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


module CLALOGIC(
    input wire [3:0] G,
    input wire[3:0] P,
    input wire Ci,
    output wire [3:1] C,
    output wire Co,
    output wire PG,
    output wire GG
    );
    
    wire GG_int;
wire PG_int;
assign C[1] = G[0] | (P[0] & Ci) ;
assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & Ci) ;
assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] &
P[0] & Ci) ;
assign PG_int = P[3] & P[2] & P[1] & P[0] ;
assign GG_int = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] &
P[1] & G[0]) ;
assign Co = GG_int | (PG_int & Ci) ;
assign PG = PG_int ;
assign GG = GG_int ;

endmodule
