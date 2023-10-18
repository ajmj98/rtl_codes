module ROM(
input clk,
input [3:0] addr,
input en,
output [4:0] dout);


reg [4:0] rom [15:0];
reg [4:0] dout;

always@(posedge clk)
begin
	if(en)
		dout<= rom[addr];
	else
		dout<=5'bxxxx;
end

endmodule


