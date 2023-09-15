`include "main.v"
`timescale 10ns/1ns

module tb();
     reg sys_rst;
     reg clk;
     reg [15:0] din;
     wire[15:0] dout;

     core top(clk,sys_rst,din,dout);

     initial 
     begin
	 $dumpfile("wave.vcd");
	 $dumpvars(2);
         clk=0;
	 forever #0.5 clk=~clk;
 	    end


    initial
    begin
	    
            
	     sys_rst=1;
	    #1 sys_rst=0; din=31;
	    #1;

    end
    initial begin
	    //$monitor($time,"top.gpr[0]=%d top.gpr[1]=%d top.gpr[2]=%d gpr[3]=%d top.gpr[4]=%d top.gpr[5]=%d top.gpr[6]=%d top.gpr[7]=%d opcode=%b ir=%b pc=%b",top.gpr[0],top.gpr[1],top.gpr[2],top.gpr[3],top.gpr[4],top.gpr[5],top.gpr[6],top.gpr[7],top.`op_code,top.ir,top.PC);
	    $monitor($time," dout=%d din=%d opcode=%b ir=%b pc=%b data_mem[0]=%b data_mem[1]=%b data_mem[2]=%b data_mem[3]=%b gpr[0]=%b gpr[7]=%b ",dout,din,top.`op_code,top.ir,top.PC,top.data_mem[0],top.data_mem[1],top.data_mem[2],top.data_mem[2],top.gpr[0],top.gpr[7]);

	     #160;
	    $writememb("data_mem_i.mem", top.data_mem);
	   #1 $finish;

      end
endmodule

      	   
    	   
