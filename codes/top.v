`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.11.2019 03:32:17
// Design Name: 
// Module Name: top
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


module top(input wire clk,
           input wire send,
           input wire rst, 
           input wire rxd,
           output wire txd
          

    );
    
    
    wire [15:0] prescale=100000000/(115200*8);
/*
wire                   tx_busy;
wire                   rx_busy;
wire                   rx_overrun_error;
wire                   rx_frame_error;
*/
reg state =0;

reg [7:0]out_encrypted=0;
reg [7:0]out_decrypted=0;
reg done_d_received=0,done_e_received=0;
wire [7:0] in,out_e,out_d;
reg [7:0] out_final=0;
reg send_valid=0;
wire tready;
wire receiver;
wire done_e,done_d;

     uart uart_instance
(
    .clk(clk),
    .rst(rst),

    /*
     * AXI input
     */
    .s_axis_tdata(out_final),
    .s_axis_tvalid(send_valid),
    .s_axis_tready(tready),

    /*
     * AXI output
     */
    .m_axis_tdata(in),
    .m_axis_tvalid(receiver),
    .m_axis_tready(1),

    /*
     * UART interface
     */
    .rxd(rxd),
    .txd(txd),

    /*
     * Status
     */
     /*
    .tx_busy(tx_busy),
    .rx_busy(rx_busy),
    .rx_overrun_error(rx_overrun_error),
    .rx_frame_error(rx_frame_error),
    */
    /*
     * Configuration
     */
    .prescale(prescale)

);

algo a1(receiver,in,clk,out_e,out_d,done_e,done_d);


always @(posedge clk) begin    
    if(done_e) begin
        out_encrypted=out_e;
        done_d_received=0;
        done_e_received=1;
        end
    if(done_d)begin
        out_decrypted =out_d;
        done_d_received=1;
        done_e_received=0;
        end 
end

always @(posedge clk) begin
    case (state)
        1'b0:begin
                if(done_e_received && tready)begin
                    send_valid=1;
                    state=1;
                    out_final=out_encrypted;
                end
                else 
                     send_valid=0;
             end
        1'b1:begin
                if(tready && done_d_received && send) begin
                    state=1'b0;
                    send_valid=1;
                    out_final=out_decrypted;
                end
                else
                    send_valid=0;
                end
    endcase
 end

endmodule
