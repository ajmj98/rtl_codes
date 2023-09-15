
`include "rippleadder_4bit.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2022 14:49:58
// Design Name: 
// Module Name: ripplecarry
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


module ripplecarryadder(
    input [31:0] a,
    input [31:0] b,
    input cin,
    output [31:0] sum,
    output cout
    );
    
    wire cry[6:0];
    rippleadder_4bitd R1(a[3:0],b[3:0],cin,sum[3:0],cry[0]);
    rippleadder_4bitd R2 (a[7:4],b[7:4],cry[0],sum[7:4],cry[1]);
    rippleadder_4bitd R3(a[11:8],b[11:8],cry[1],sum[11:8],cry[2]);
    rippleadder_4bitd R4(a[15:12],b[15:12],cry[2],sum[15:12],cry[3]);
    rippleadder_4bitd R5(a[19:16],b[19:16],cry[3],sum[19:16],cry[4]);
    rippleadder_4bitd R6(a[23:20],b[23:20],cry[4],sum[23:20],cry[5]);
    rippleadder_4bitd R7(a[27:24],b[27:24],cry[5],sum[27:24],cry[6]);
    rippleadder_4bitd R8(a[31:28],b[31:28],cry[6],sum[31:28],cout);




endmodule
