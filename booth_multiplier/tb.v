`include "main.v"
`include "cntroller.v"

module tb();
parameter N=8,n=4;
reg [n-1:0] C,B;
reg start,clk,reset;

wire [N-1:0] P;
wire done;
cntrl   MC(clk,reset,cmp,incr,start,done,ld,clr,shft,add_sub);

bth_mlt #(.N(8),.n(4))  MD(P,cmp,incr,C,B,clr, ld, add_sub,shft);


initial begin
	$monitor($time," start= %b done=%b A=%d B=%d P=%b ",start,done,C,B,P);
	$dumpfile("w.vcd");
	$dumpvars(2);
end

initial begin
	clk=0;
        forever clk=#1 ~clk; 
end

initial begin
	start=0;reset=1;
        #6 reset =0; 
	#5;C=10; B=1;
	#2; start=1;
        #6; start=0;
	#50;

	#3;reset=1;

	#5;
	$finish;
end
endmodule
