module ram_sp(

input [4:0] din,
input clk,
input [3:0] addr,
input we,
output [4:0] dout);


reg [4:0] ram [15:0];
reg [4:0] dout;

always@(posedge clk)
begin
	if(we)
		ram[addr]<=din;
	else
		dout<= ram[addr];
end

endmodule


