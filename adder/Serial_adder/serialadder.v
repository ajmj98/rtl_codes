`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2022 08:08:59
// Design Name: 
// Module Name: serialadder
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


module serialadder(
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire st,
    input wire ld,
    input wire clk,
    output wire [31:0] sum,
    output  wire cout,
    output wire done
     );
    reg [32:0] A;
    reg [31:0] B;
    reg [5:0] k;
    reg cin;
    reg [2:0] cur_state;
    
    initial begin
        A<=0;
        B<=0;
        cin<=0;
        k<=0;
        cur_state<=0;
       
     end
        
     
    always @(posedge clk) begin 
        case(cur_state)
                0 : begin
                    k=0;
                   if(st==1 && ld==1) begin 
                       A<={1'b0,in1};
                        B<=in2;
                         cur_state<=1;
                         
                  end  end
                1: begin
                         {cin,A[32]} =A[0]+B[0]+cin;
                            cur_state=2;
                           
                    end
                2: begin
                        A={0,A[32:1]};
                        B={B[0],B[31:1]};
                        k=k+1;
                        if(k==32)  begin
                            cur_state=3;
                        end
                        else  cur_state=1;
                    end
                3: begin
                         A<=0;
                         B<=0;
                         cin<=0;
                         k<=0;
                        @(in1,in2) cur_state<=0;
                        cur_state=3;
                    end   
                default: cur_state=3;
               endcase
    end
    assign {done,cout,sum}=(k==32)?{1'b1,cin,A[31:0]}:0;
endmodule
