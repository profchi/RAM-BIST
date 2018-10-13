`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2018 12:09:02 PM
// Design Name: 
// Module Name: BIST_controller_tb
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


module BIST_controller_tb( );
reg b_rst; 
reg b_clk; 
reg b_error; 
reg b_pat_end; 
reg b_count_end; 
wire b_nxt_pat; 
wire b_nxt_count;
wire b_tst_state;
wire b_tst_pass; 
wire b_tst_fail; 
wire b_rst_count;
wire b_rst_pat;
    BIST_controller My_BIST (b_rst, b_clk, b_error, b_pat_end, 
    b_count_end, b_nxt_pat, b_nxt_count, b_tst_state,
    b_tst_pass, b_tst_fail, b_rst_count,b_rst_pat );
    initial begin
        b_clk = 1'b0;
        forever #50 b_clk = ~b_clk;
    end
    initial begin
    b_rst = 0;
    #1000 b_rst = 1;
    #500 b_rst = 0;
    #200 b_count_end = 1;
    #100 b_count_end = 0;
    #300 b_pat_end = 1;
    #200 b_error = 1;
    end
endmodule
