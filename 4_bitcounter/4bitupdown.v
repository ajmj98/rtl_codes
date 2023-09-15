
module counter(input m,clr,e,ld,clk,input [3:0] din,output reg [3:0]out,output reg t);
	
	always @(posedge clk) begin
		if(clr==1)
			out<=4'b0000;
		else if(ld==1)
			out<=din;
		else if(m==1 && e==1) 
          if(out==15)	begin
            t<=1'b1;
            out<=5'b0000; 
          end
          else begin
            t<=1'b0;
            out<=out+1; 
          end
		else if(m==0 && e==1) 
          if(out==0)	begin
            t<=1'b1;
            out<=5'b1111; 
          end
          else begin
            t<=1'b0;
            out<=out-1;     
          end
	end
endmodule


