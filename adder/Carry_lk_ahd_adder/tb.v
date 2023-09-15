`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2022 21:49:49
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
    
  
	 reg [31:0] a,b;
	reg cin;
	wire [31:0] sum;
	wire carry;
	
	cla32 K(.A(a),.B(b),.Cin(cin),.S(sum),.Cout(carry));
	

	initial begin
	$dumpfile("test.vcd");
	$dumpvars;
	end
	
	initial begin
		$monitor("t=%t, a=%b, b=%b ,cin=%b, sum=%b , carry=%b",$time,a,b,cin,sum,carry);
	end
	
	initial begin
	
	#0.5 a=3;b=10;cin=1;
	#0.5 a=31;b=10;cin=1;
	#0.5 a=7;b=2;cin=0;
	#0.5 a=28;b=3;cin=0;
	#0.5 a=1200;b=500;cin=1;
	#0.5 a=4294967295;b=0;cin=1;
	#0.5 a=4294967295;b=4294967295;cin=0;
	#0.5 a=4294967295;b=4294967295;cin=1;
	#0.5 $finish ;
	end
endmodule
