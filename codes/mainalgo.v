`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2019 20:20:21
// Design Name: 
// Module Name: algo
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

module algo (start,data,clk,encrypted_data,decrypted_data,done_m1,done_m2);
input [7:0] data;
input clk;
input start;
output [7:0] encrypted_data,decrypted_data;
output done_m1,done_m2;

parameter p = 3;
parameter q = 7;

wire [7:0] n, toitent, en_key, de_key;
wire [63:0]inter_encrypt_data,inter_decrypt_data;
wire count;
wire done_e;
wire done_d;
wire [7:0]in;

//assign start=1;
assign n = p*q;
assign toitent = (p-1)*(q-1);
assign in = 2;

find_e e1 (in,toitent,clk,start,en_key,done_e);
mul m1 (data,en_key,clk,done_e,inter_encrypt_data,done_m1);
assign encrypted_data = inter_encrypt_data % n;

find_d d1 (en_key,toitent,clk,done_e,de_key,done_d);
mul m2 (encrypted_data,de_key,clk,done_d,inter_decrypt_data,done_m2);
assign decrypted_data = inter_decrypt_data % n;
 
 /*
 ila_0 your_instance_name (
	.clk(clk), // input wire clk
	.probe0(in), // input wire [7:0]  probe0  
	.probe1(toitent), // input wire [7:0]  probe1 
	.probe2(en_key), // input wire [7:0]  probe2 
	.probe3(de_key) // input wire [7:0]  probe3
);
*/
endmodule
