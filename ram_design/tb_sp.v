`include "main_sp.v"

module tb();
        reg [4:0] din;
	reg clk,we;
	reg [3:0] addr;
	wire [4:0] dout;


	ram_sp Mem(din,clk,addr,we,dout);

	initial begin
		clk=0;
		forever clk= #1 ~clk;
		$dumpfile("d.vcd");
		$dumpvars(2);
	end

	

	initial begin
		we=1;
		addr=0;
		$display($time,"%b   %d",Mem.ram[addr],addr);
                #3;
		din=5;
                $display($time,"%b %d",Mem.ram[addr],addr);
		#5
		addr=1;
            	$display($time,"%b   %d",Mem.ram[addr],addr);
                #3;

		din=6;
		$display($time,"%b",Mem.ram[addr]);

		#6 addr=9;
	        $display($time,"%b   %d",Mem.ram[addr],addr);
                #3;

		din=13;
               $display($time,"%b  %d",Mem.ram[addr],addr);

		#3 addr=15;
	        $display($time,"%b   %d",Mem.ram[addr],addr);
                 #3;

		din=7;
		$display($time,"%b  %d",Mem.ram[addr],addr);

		#5 we=0;
		din=6;
		addr= 5;
		$display($time,"%b  %d",Mem.ram[addr],addr);

		#4 addr=7;
		$display($time,"%b  %d",Mem.ram[addr],addr);

		#5 addr=15;
                $writememb("dta.mem",Mem.ram,0,15);
                #3 $finish;
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




