module ram_dp(
input clk,
input [4:0] din_a,
input we_a,
input [3:0] addr_a,
input [4:0] din_b,
input we_b,
input [3:0] addr_b,
output [4:0] dout_a,
output [4:0] dout_b);

reg [4:0] dout_a;
reg [4:0] dout_b;
reg [4:0] ram[15:0];

always@(posedge clk) 
begin
if(we_a)
		ram[addr_a]<=din_a;
	else
		dout_a<= ram[addr_a];
if(we_b)
		ram[addr_b]<=din_b;
	else
		dout_b<= ram[addr_b];
end

endmodule
