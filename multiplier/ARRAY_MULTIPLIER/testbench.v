`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2022 08:31:23
// Design Name: 
// Module Name: tb
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


module tb(

    );
    
    
    reg[3:0] X;
    reg [3:0] Y;

wire [7:0] P;
    
    Array_Mult M( X, Y,P );
    
    initial begin
	$dumpfile("test.vcd");
	$dumpvars;
	
	end
	initial begin
		$monitor("t=%t, a=%d, b=%d ,p=%d, ",$time,X,Y,P);
	end
   initial begin
   #1 X=10; Y=1; 
   #1 X=10;Y=2; 
   #1 X=10; Y=3;
   #1 X=4; Y=12; 
   #1 X=10; Y=1; 
   #1 X=11; X=1; 
   #1 $finish;
   end
endmodule
