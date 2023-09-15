//4 bit ripple carry adder in pipeline model


module pipe_rca4 (Cout, Sum, A, B, Cin, Clk);
  
  input [3:0] A,B;
  input Clk, Cin;
  output  [3:0] Sum;
  output   Cout;
  
  reg L1A1,L1A2,L1A3,L1B1,L1B2,L1B3,L1CI,L2A2,L2A3,L2B2,L2B3,L2CI,L3A3,L3B3,L3CI,L4CI,L1S0,L1S1,L2S0,L2S1,L2S2,L3S0,L3S1,L3S2,L3S3,L4S0,L4S1,L4S2,L4S3,L4S4;

  assign Sum[0]=L4S0;
 assign Sum[1]=L4S1;
 assign Sum[2]=L4S2;
 assign Sum[3]=L4S3;

 assign Cout= L4CI;

  always@(posedge Clk)
  begin
	  {L1CI,L1S0}<=A[0]+B[0]+Cin;
	  {L1A1,L1B1,L1A2,L1B2,L1A3,L1B3}<={A[1],B[1],A[2],B[2],A[3],B[3]};
  end  

  always@(posedge Clk)
  begin
	  {L2CI,L2S1}<=L1A1+L1B1+L1CI;
	  {L2S0,L2A2,L2B2,L2A3,L2B3}<={L1S0,L1A2,L1B2,L1A3,L1B3};


  end

  always@(posedge Clk)
  begin
	  {L3CI,L3S2}<=L2A2+L2B2+L2CI;
	  {L3S0,L3S1,L3A3,L3B3}<={L2S0,L2S1,L2A3,L2B3};
  end

  always@(posedge Clk)
  begin
	  {L4CI,L4S3} <= L3A3+L3B3+L3CI;
	  {L4S0,L4S1,L4S2}<={L3S0,L3S1,L3S2};
  end

endmodule
  
