/*implement a 16-bit majority function using behavioral description. The module will take as input a 16-bit data, Data and provide a single-bit output, Out, indicating the logic state of the most number of input bits, i.e. if at least 9 out of 16 input signals are at logic 1, the logic state of Out will be 1; otherwise Out will remain at  logic 0.
*/

module majority16 (Out, Data);
  input [15:0] Data;
  output Out;
  integer i,k;
  
  always @(Data) begin
    k=0; 
    for(i=0;i<16;i=i+1) begin
     
      if(Data[i] == 1) begin
        	k=k+1; 
      end
       
    end
   
    
  end
  assign Out=(k>=9)?1:0;
endmodule
