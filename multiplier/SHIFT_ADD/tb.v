`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2022 22:18:19
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
    reg Clk;
    reg St;
    reg[3:0] Mplier;
    reg [3:0] Mcand;
wire Done;
wire [7:0] Result;
    
    mult4x4 M( .Clk(Clk),  .St(St), .Mplier(Mplier), .Mcand(Mcand), .Done(Done), .Result(Result));
    
    initial begin
	$dumpfile("test.vcd");
	$dumpvars;
	Clk=0;
		forever #0.5 Clk=~Clk;
	end
	initial begin
		$monitor("t=%t, a=%d, b=%d, st=%b ,p=%d, done=%b ",$time,Mplier,Mcand,St,Result,Done);
	end
   initial begin
    Mplier=10; Mcand=1; St=0;
   #10 Mplier=10; Mcand=2; St=0;
   #5 Mplier=10; Mcand=3; St=1;
   #8 Mplier=4; Mcand=12; St=1;
   #8 Mplier=10; Mcand=1; St=0;
   #3 Mplier=11; Mcand=1; St=1;
   #10 $finish;
   end
endmodule
