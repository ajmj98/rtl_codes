
`include "fulladder.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2022 14:56:40
// Design Name: 
// Module Name: rippleadder_4bit
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


module rippleadder_4bitd(
    input wire [3:0] a,
    input wire [3:0] b,
    input wire cin,
    output wire [3:0] sum,
    output wire  cout
    );
    wire cry[2:0];
    full_adder F1(a[0],b[0],cin,sum[0],cry[0]);
	full_adder F2(a[1],b[1],cry[0],sum[1],cry[1]);
	full_adder F3(a[2],b[2],cry[1],sum[2],cry[2]);
	full_adder F4(a[3],b[3],cry[2],sum[3],cout);

endmodule
