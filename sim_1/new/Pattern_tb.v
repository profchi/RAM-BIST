`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2018 04:35:46 PM
// Design Name: 
// Module Name: Pattern_tb
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


module Pattern_tb( );
reg p_clk;

reg b_rst; 
reg b_clk; 
reg b_error; 
wire b_tst_state;
wire b_tst_pass; 
wire b_tst_fail; 

wire nextcount;
wire nextpat;
wire resetpat;
wire resetcount;
wire [8:0] patend;
wire [10:0] countend;

wire clk_out;

 Clock_div Divide(p_clk,clk_out);
Pattern My_pat(clk_out, resetcount, resetpat,nextpat, nextcount, patend,countend);
    BIST_controller My_BIST (b_rst, clk_out, b_error, patend[8], 
    countend[10],nextpat, nextcount, b_tst_state,
    b_tst_pass, b_tst_fail, resetcount,resetpat );
    
initial begin
    p_clk = 0;
    b_clk = 0;
    forever begin
     #50 p_clk = ~p_clk;
     b_clk = ~b_clk;
     end
    end
initial begin
  b_rst = 0;
  #300 b_rst = 1;
  #500 b_rst = 0;
   
    end 
endmodule
