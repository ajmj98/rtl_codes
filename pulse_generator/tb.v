`include "main.v"
module tb();

reg signal,clk;
wire plse;


PLSE_GEN M1(clk,signal,plse);
initial begin
    $dumpfile("w.vcd");
    $dumpvars(1);
end

initial begin
    clk=0;
    forever clk=#1 ~clk;
end

initial begin
    signal=0;
    #5 signal =1;
    #10 signal=0;
    #5 $finish;
end

endmodule
