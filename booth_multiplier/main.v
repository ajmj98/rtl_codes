module bth_mlt #(parameter N=6,parameter n=3) (P,cmp,incr,Multiplier,Multiplicand,clr,ld, add_sub,shft);

input [n-1:0] Multiplier, Multiplicand;
input clr,ld, add_sub,shft;
output reg cmp,incr;
output wire [N-1:0] P ;

reg [n-1:0] Q;
reg q;
reg [n-1:0] M;
reg [n-1:0] A;
 
integer count;




always@(*)
begin
/////////////////TO CLEAR REGISTERS////////////////
	if(clr)
	begin
	  M<=0;q<=0;
	  Q[n-1:0]=0; 
	  A<=0;count<=0;
        end
//////////////TO LOAD REGISTERS////////////////////
	else if(ld)
	begin
          M=Multiplicand;
	  Q[n-1:0]=Multiplier; q=0;
	  A=0;count=0; 
        end
///////////EXECUTION STAGE///////////////////////
	else
	begin
	  incr=1;
////////////COMPARE BITS TO CHECK IF TO SHIFT OR PERFORM ARITHMETIC///////////
	  if({Q[0],q}== 2'b00 || {Q[0],q}== 2'b11)
	  begin
            cmp=0;
	  end
	  else
	  begin	  
	    cmp=1;
	  end
/////////////CHECK BITS TO PERFORM ADDITION OR SUBTRACTION//////////////	  
	  if(add_sub)
	  begin
	    if(q)
	    begin
		    A=A+M;
	    end
	    else
	    begin
		    A=A-M;
	    end
	  end
//////////////////PERFORM RIGHT SHIFT/////////////////////////////////
	  if(shft)
	  begin
		  {A,Q,q}={A[n-1],A,Q};
		  count=count+1;
	  end
////////////////TO COUNT THE NO.OF SHIFTS AND OBTAIN RESULT AT CORRECT NUMBER OF SHIFTS//////////////////////////////////////////          
	  if(count==n)
          begin
		  incr=0;
	  end
	  else
	  begin
		  incr=1;
	  end	 
        end

end	

///////////////assign output//////////////
    assign P=(incr)?0: {A,Q};

endmodule
