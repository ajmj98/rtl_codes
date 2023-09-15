module tb();
  reg clk,sa,sb;
  wire ra,rb,ya,yb,ga,gb;

  trafficlight test(clk,sa,sb,ra,rb,ya,yb,ga,gb);

  intial begin
	  $dumpfile("test.vcd");
	  $dumpvars;
	  clk=0;

	  forever #5 clk=~clk;

  end

  initial begin
	  sa=1;sb=0;
	  #40 sa=0;
	  #30 sb=1;
	  #30 sb=0;
	  #20 sb=1;
	  #30 sb=0;
	  #20 sa=1;
	  #40 sb=1;
	  #20 sa=0;
	  #20 sa=1;sb=0;
	  #20 sb=1;
	  #30 $finish;
  end
 endmodule

