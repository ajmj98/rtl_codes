`include "main.v"

module pipe_rca4_test;
    reg [3:0] A, B, A_prev, B_prev;
    reg Cin, Cin_prev, Clk;
    wire [3:0] Sum;
    wire Cout;

    parameter STDIN = 32'h8000_0000;
    integer testid=0;
    integer ret;

    pipe_rca4 DUT (Cout, Sum, A, B, Cin, Clk);

    initial begin
        Clk = 1'b0;
        #500 $finish;
    end

    always #5 Clk = ~Clk;

    initial begin
           
     #2  A = 7; B = 5; Cin = 0;
                       #10 A_prev = A; B_prev = B; Cin_prev = Cin; A = 0; B = 0; Cin = 0;
                       #30;testid=1;
                               #2  A = 7; B = 5; Cin = 1;
                       #10 A_prev = A; B_prev = B; Cin_prev = Cin; A = 0; B = 0; Cin = 0;
                       #30;testid=2;
                            #2  A = 10; B = 6; Cin = 0;
                       #10 A_prev = A; B_prev = B; Cin_prev = Cin; A = 0; B = 0; Cin = 0;
                       #30;testid=3;
                       #2  A = 4; B = 10; Cin = 1;
                       #10 A_prev = A; B_prev = B; Cin_prev = Cin; A = 0; B = 0; Cin = 0;
                       #30;testid=4;
                            #2  A = 0; B = 6; Cin = 1;
                       #10 A_prev = A; B_prev = B; Cin_prev = Cin; A = 0; B = 0; Cin = 0;
                       #30;testid=5;
                             #2  A = 0; B = 0; Cin = 0;
                       #10 A_prev = A; B_prev = B; Cin_prev = Cin; A = 2; B = 2; Cin = 2;
                       #30;testid=6;
       #2  A = 0; B = 0; Cin = 1;
                       #10 A_prev = A; B_prev = B; Cin_prev = Cin; A = 0; B = 0; Cin = 0;
                       #30;
                      #2  A = 3; B = 0; Cin = 0;
                       #10 A_prev = A; B_prev = B; Cin_prev = Cin; A = 0; B = 0; Cin = 0;#1;
	       end      
           

		  initial begin
			  $dumpfile("d.vcd");
			  $dumpvars(2);
                   $monitor($time, "(A = %b and B = %b and Cin = %b) => (Sum = %b and  Cout = %b)", A_prev, B_prev, Cin_prev, Sum, Cout);
             #500 $finish;
  
       end
     
endmodule
