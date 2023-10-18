`include "main.v"
module tb();

reg clk,rst,req0,req1,req2,req3;
wire gnt0,gnt1,gnt2,gnt3;

rr_arbiter M1(clk,rst,req0,req1,req2,req3,gnt0,gnt1,gnt2,gnt3);


initial begin
	$dumpfile("w.vcd");
	$dumpvars(2);
        clk=0;
	forever clk= #1 ~clk;
end

initial begin
	rst=1;
        req0=0;
	req1=0;
	req2=0;
	req3=0;
	#3 rst=0;
	repeat(2) @(posedge clk); req0=1;
        repeat(1) @(posedge clk); req0=0;req1=1;
        repeat(3) @(posedge clk); req1=1;req2=1;
	repeat(1) @(posedge clk); req1=1;req2=1;req3=1;req0=1;
        repeat(1) @(posedge clk); req1=0;req2=1;req3=1;req0=1;
	repeat(1) @(posedge clk); req1=0;req2=0;req3=1;req0=1;
	repeat(1) @(posedge clk); req1=0;req2=0;req3=0;req0=1;
        repeat(1) @(posedge clk); req1=0;req2=0;req3=0;req0=0;



	
	#5; $finish;
       	
end

endmodule
