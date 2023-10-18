`include "main_dp.v"

module tb();
        reg [4:0] din_a;
	reg clk,we_a;
	reg [3:0] addr_a;
	wire [4:0] dout_a;

        reg [4:0] din_b;
	reg we_b;
	reg [3:0] addr_b;
	wire [4:0] dout_b;

	ram_dp Mem(clk,din_a,we_a,addr_a,din_b,we_b,addr_b,dout_a,dout_b);

	initial begin
		clk=0;
		forever clk= #1 ~clk;
		$dumpfile("d.vcd");
		$dumpvars(2);
	end

	

	initial begin
                $display("**************testing a**************");
		we_a=1;
		addr_a=0;
		$display($time,"%b   %d",Mem.dout_a,addr_a);
                #3;
		din_a=5;
                $display($time,"%b %d",Mem.dout_a,addr_a);
		#5
		addr_a=1;
            	$display($time,"%b   %d",Mem.dout_a,addr_a);
                #3;

		din_a=6;
		$display($time,"%b  %d",Mem.dout_a,addr_a);

		#6 addr_a=9;
	        $display($time,"%b   %d",Mem.dout_a,addr_a);
                #3;

		din_a=13;
               $display($time,"%b  %d",Mem.dout_a,addr_a);

		#3 addr_a=15;
	        $display($time,"%b   %d",Mem.dout_a,addr_a);
                 #3;

		din_a=7;
		$display($time,"%b  %d",Mem.dout_a,addr_a);

		#5 we_a=0;
		din_a=6;
		addr_a= 5;
		$display($time,"%b  %d",Mem.dout_a,addr_a);

		#4 addr_a=0;
		$display($time,"%b  %d",Mem.dout_a,addr_a);

		#5 addr_a=15;
                $writememb("dta.mem",Mem.ram,0,15);
                #6 


		$display("************testing b************");;
                we_b=1;
		addr_b=2;
		$display($time,"%b   %d",Mem.dout_b,addr_b);
                #3;
		din_b=5;
                $display($time,"%b %d",Mem.dout_b,addr_b);
		#5
		addr_b=3;
            	$display($time,"%b   %d",Mem.dout_b,addr_b);
                #3;

		din_b=6;
		$display($time,"%b   %d",Mem.dout_b,addr_b);

		#6 addr_b=10;
	        $display($time,"%b   %d",Mem.dout_b,addr_b);
                #3;

		din_b=13;
               $display($time,"%b  %d",Mem.dout_b,addr_b);

		#3 addr_b=14;
	        $display($time,"%b   %d",Mem.dout_b,addr_b);
                 #3;

		din_b=7;
		$display($time,"%b  %d",Mem.dout_b,addr_b);

		#5 we_b=0;
		din_b=6;
		addr_b= 5;
		$display($time,"%b  %d",Mem.dout_b,addr_b);

		#4 addr_b=7;
		$display($time,"%b  %d",Mem.dout_b,addr_b);

		#5 addr_b=15;
                $writememb("dtb.mem",Mem.ram,0,15);
                #3; 
               

		$display("************testing  a and b************");

		we_a=0;we_b=0;
		addr_a=0;addr_b=1;
		din_a=16;din_b=17;
                $display($time,"A= %b  %d  B= %b   %d",Mem.dout_a,addr_a,dout_b,addr_b);
		#3;

                we_a=0;we_b=1;
		addr_a=2;addr_b=3;
		din_a=16;din_b=17;
                $display($time,"A= %b  %d  B= %b   %d",Mem.dout_a,addr_a,Mem.dout_b,addr_b);
		#5;

	        we_a=1;we_b=0;
		addr_a=4;addr_b=5;
		din_a=16;din_b=17;
                $display($time,"A= %b  %d  B= %b   %d",Mem.dout_a,addr_a,Mem.dout_b,addr_b);
		#6;

	        we_a=1;we_b=1;
		addr_a=6;addr_b=7;
		din_a=16;din_b=17;
                $display($time,"A= %b  %d  B= %b   %d",Mem.dout_a,addr_a,Mem.dout_b,addr_b);
		#3 ;$writememb("dtab.mem",Mem.ram,0,15);
		#4 $finish;




	end


/*
        initial begin
	        we =1;
	        $readmemb("dta_in.mem",Mem.ram,0,15);

         	$writememb("dta.mem",Mem.ram,0,15);
                #3$finish;
        end
*/
endmodule




