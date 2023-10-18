module rr_arbiter(
input clk,
input rst,
input req0,
input req1,
input req2,
input req3,
output gnt0,
output gnt1,
output gnt2,
output gnt3);

reg gnt0,gnt1,gnt2,gnt3;


reg [2:0] state,next_state;



always@(posedge clk) 
begin
	if(rst)
	begin
		gnt0<=0;
		gnt1<=0;
		gnt2<=0;
		gnt3<=0;
		state<=3'b100;
		
	end
	else
	begin
	        state<=next_state;	
	end
end


always@(*)
begin
///////////////////////////////////////////////////////////////////
	case(state)
		3'b000:
		begin
			if(req0 )
			begin
				gnt0<=1;gnt1<=0;gnt2<=0;gnt3<=0;
				next_state<=3'b001;
			end
			else if(req1)
			begin
				gnt0<=0;gnt1<=1;gnt2<=0;gnt3<=0;
				next_state<=3'b010;
			end
                        else if(req2)
			begin
				gnt0<=0;gnt1<=0;gnt2<=1;gnt3<=0;
				next_state<=3'b011;
			end
			else if(req3)
			begin
				gnt0<=0;gnt1<=0;gnt2<=0;gnt3<=1;
				next_state<=3'b000;
			end  
		       else
	                begin
                                next_state<= 3'b100;
				gnt0<=0;gnt1<=0;gnt2<=0;gnt3<=0;

		       end
		end
/////////////////////////////////////////////////////////////////////////
		3'b001:
		begin
                       
			if(req1)
			begin
				gnt0<=0;gnt1<=1;gnt2<=0;gnt3<=0;
				next_state<=3'b010;
			end
			else if(req2)
			begin
				gnt0<=0;gnt1<=0;gnt2<=1;gnt3<=0;
				next_state<=3'b011;
			end
                        else if(req3)
			begin
				gnt0<=0;gnt1<=0;gnt2<=0;gnt3<=1;
				next_state<=3'b000;
			end
			else if(req0)
			begin
				gnt0<=1;gnt1<=0;gnt2<=0;gnt3<=0;
				next_state<=3'b001;
			end
			else
	                begin
                                next_state<= 3'b100;
				gnt0<=0;gnt1<=0;gnt2<=0;gnt3<=0;

		       end

		
		 end
/////////////////////////////////////////////////////////////////////
		3'b010:
		begin
	                if(req2)
			begin
				gnt0<=0;gnt1<=0;gnt2<=1;gnt3<=0;
				next_state<=3'b011;
			end
                        else if(req3)
			begin
				gnt0<=0;gnt1<=0;gnt2<=0;gnt3<=1;
				next_state<=3'b000;
			end
			else if(req0)
			begin
				gnt0<=1;gnt1<=0;gnt2<=0;gnt3<=0;
				next_state<=3'b001;
			end
			else if(req1)
			begin
				gnt0<=0;gnt1<=1;gnt2<=0;gnt3<=0;
				next_state<=3'b010;
			end
			else
	                begin
                                next_state<= 3'b100;
				gnt0<=0;gnt1<=0;gnt2<=0;gnt3<=0;

		       end

		 end
////////////////////////////////////////////////////////////////////////
		3'b011:
		begin
			if(req3)
			begin
				gnt0<=0;gnt1<=0;gnt2<=0;gnt3<=1;
				next_state<=3'b000;
			end
			else if(req0)
			begin
				gnt0<=1;gnt1<=0;gnt2<=0;gnt3<=0;
				next_state<=3'b001;
			end
			else if(req1)
			begin
				gnt0<=0;gnt1<=1;gnt2<=0;gnt3<=0;
				next_state<=3'b010;
			end
			else if(req2)
			begin
				gnt0<=0;gnt1<=0;gnt2<=1;gnt3<=0;
				next_state<=3'b011;
			end
			else
	                begin
                                next_state<= 3'b100;
				gnt0<=0;gnt1<=0;gnt2<=0;gnt3<=0;

		       end

                 end
/////////////////////////////////////////////////////////////////////////////               
		 3'b100:
		 begin
			
			
			if(req0 )
			begin
				gnt0<=1;gnt1<=0;gnt2<=0;gnt3<=0;
				next_state<=3'b001;
			end
			else if(req1)
			begin
				gnt0<=0;gnt1<=1;gnt2<=0;gnt3<=0;
				next_state<=3'b010;
			end
                        else if(req2)
			begin
				gnt0<=0;gnt1<=0;gnt2<=1;gnt3<=0;
				next_state<=3'b011;
			end
			else if(req3)
			begin
				gnt0<=0;gnt1<=0;gnt2<=0;gnt3<=1;
				next_state<=3'b000;
			end 
                        else
	                begin
                                next_state<= 3'b100;
				gnt0<=0;gnt1<=0;gnt2<=0;gnt3<=0;

		       end
	        end
///////////////////////////////////////////////////////////////////////////////////
		
		default:
		begin 
		                next_state<= 3'b100;
			        gnt0<=0;gnt1<=0;gnt2<=0;gnt3<=0;

		end
///////////////////////////////////////////////////////////////////////////////
	endcase
end

endmodule

