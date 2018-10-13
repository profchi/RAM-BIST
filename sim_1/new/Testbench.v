`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2018 06:38:43 PM
// Design Name: 
// Module Name: Testbench
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


module Testbench();
reg rst;
 reg clk;
 reg [9:0] wrt_addrs;
 reg [9:0] rd_addrs;
 reg [7:0] wrt_dat;
 reg  wrt_en;
 reg button;
 wire [7:0] rd_dat;
 wire [7:0] tst_out;
 
   Sub_BIST Ram_Bist (rst, clk, wrt_addrs, rd_addrs, wrt_dat, wrt_en, button,rd_dat,tst_out);

 initial begin
     clk = 0;
    forever begin
        #50 clk = ~clk;
    end
end 
initial begin
    button = 0;
    rst = 0;
    #300 rst = 1;
    #500 rst = 0;   
 end 

endmodule
