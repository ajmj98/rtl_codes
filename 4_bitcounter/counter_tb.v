module tb();
	reg  m,clr,e,ld,clk;
	reg [3:0] din;
	wire t;
  wire [3:0] out;
	counter c( m,clr,e,ld,clk, din,out,t);
	initial begin
	 $monitor("time=%0t, clk=%0b  clr=%0b ld=%0b din=%0d e=%0b m=%0b out=%0d  t=%0b",$time, clk,clr,ld,din,e,m,out,t);
		$dumpfile("test.vcd");
		$dumpvars;
		clk=0;
		forever #5 clk=~clk;
	end
	initial begin
		clr<=1;e<=0;ld<=0;
		#5 clr<=0;m=1;e<=1;
		#210 ld<=1; din<=4'b1100;
		#10 ld<=0; m<=0; e<=1;
		#300 ld<=1;din<=4'b1101;
		#10 ld<=0;m<=1;
      	#30 $finish;
	end
endmodule
