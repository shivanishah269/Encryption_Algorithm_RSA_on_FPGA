`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2019 16:02:30
// Design Name: 
// Module Name: find_d
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


module find_d(a,b,clk,start,out,done);
input [7:0] a,b;
input clk,start;
output reg [7:0] out;
output reg done;

reg state=0;
reg [7:0] A,B,temp;

always @ (posedge clk)
begin
case (state)
	1'b0: begin
			A = a;
			B = b;
			temp = 1;
			done =0;
			if(start)
				state = 1'b1;
		  end
	1'b1: begin
			if(((temp*A) % B)==1)
			begin
				state = 1'b0;
				out = temp;
				done = 1;
		    end
			else begin
			 temp = temp +1;
			end
				
		  end
endcase
end
endmodule
