`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2019 19:24:00
// Design Name: 
// Module Name: mul
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


module mul(a,b,clk,start,out,done);
input [7:0] a,b;
input clk,start;
output reg [63:0] out=0;
output reg done=0;

reg state=0;
reg [7:0] B=0,temp=0;
reg [63:0] A=0;

always @ (posedge clk)
begin
case (state)
	1'b0: begin
			A = a;
			B = b;
			temp = a;
			done =0;
			if(start)
				state = 1'b1;
		  end
	1'b1: begin
			if(B==1)
			begin
				state = 1'b0;
				out = A;
				done = 1;
		    end
			else begin
			 A = A*temp;
			 B = B - 1;
			end
				
		  end
endcase
end
endmodule
