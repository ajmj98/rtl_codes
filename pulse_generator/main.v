module PLSE_GEN(
input clk,
input signal,
output plse);

reg plse;


reg q1,q2, out;


always@(posedge clk)
begin
	q1<=signal;
	q2<=q1;
	plse<=q1^q2;
end

endmodule



