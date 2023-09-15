`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2022 21:45:59
// Design Name: 
// Module Name: CLA_4
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


module CLA_4(
    input wire [3:0] A,
    input wire [3:0] B,
    input wire Ci,
    output wire [3:0] S,
    output wire Co,
    output wire PG,
    output wire GG
    );
    
    wire[3:0] G;
wire[3:0] P;
wire[3:1] C;
CLALOGIC CarryLogic (G, P, Ci, C, Co, PG, GG);
FULLADDER FA0 (A[0], B[0], Ci, G[0], P[0], S[0]);
FULLADDER FA1 (A[1], B[1], C[1], G[1], P[1], S[1]);
FULLADDER FA2 (A[2], B[2], C[2], G[2], P[2], S[2]);
FULLADDER FA3 (A[3], B[3], C[3], G[3], P[3], S[3]);
endmodule
