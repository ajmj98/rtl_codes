
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2022 21:48:24
// Design Name: 
// Module Name: FULLADDER
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder(
    input wire  X,
    input  wire  Y,
    input  wire Cin,
    output  wire Sum,
    output wire Cout
    );
      
    
assign Sum = X^Y^Cin ;
assign Cout= ((X || Y) && Cin ) || (X&&Y);
endmodule
