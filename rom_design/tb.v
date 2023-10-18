`include "main.v"

module tb();
   
	reg clk,en;
	reg [3:0] addr;
	wire [4:0] dout;


	ROM Mem(clk,addr,en,dout);

	initial begin
		$readmemb("dta.mem",Mem.rom,0,15);
                $dumpfile("d.vcd");
		$dumpvars(2);

		clk=0;
		forever clk= #1 ~clk;
	end

	

	initial begin
		en=1;
		addr=0;
		#3;
		$display($time,"%b   %d",dout,addr);

		#5
		addr=1;
		#3;
            	$display($time,"%b   %d",dout,addr);
		#6 addr=9;
		#3;	      
               $display($time,"%b  %d",dout,addr);

		#3 addr=15;
	         #3;
		$display($time,"%b  %d",dout,addr);

		#5 en=0;
	
		addr= 5;
		$display($time,"%b  %d",dout,addr);

		#4 addr=7;
		#3;
		$display($time,"%b  %d",dout,addr);

		#5 addr=15;
                 #3;$display($time,"%b  %d",dout,addr);

                #3 $finish;
	end


endmodule




