`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2022 08:56:08
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
     reg [31:0] in1;
     reg  [31:0] in2;
     reg st;
     reg ld;
     reg clk;
     wire [31:0] sum;
     wire cout,done;
    
    serialadder sa(in1,in2,st,ld,clk,sum,cout,done);
    
    initial begin
        $dumpfile("test.vcd");
        $dumpvars();
        $monitor("time=%t, a=%d     b=%d  st=%d  ld=%d    sum=%d    cout=%d  done=%d  ",$time,in1,in2,st,ld,sum,cout,done);
        clk=0;
        forever #2.5 clk=~clk;
    end
    initial begin
        #2 in1=1;in2=2;st=0;ld=0;
        #2 in1=1;in2=2;st=1;ld=0;
        #2 in1=1;in2=2;st=0;ld=1;
        #2 in1=1;in2=2;st=1;ld=1;
       // #350 in1=31;in2=500;st=0;ld=0;
        #2 in1=32'hffffffff;in2=1;st=1;ld=1;
        #330  in1=32'hffffffff;in2=32'hffffffff;st=1;ld=1; 
        #370 $finish;
    end
endmodule
