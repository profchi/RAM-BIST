`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2018 07:42:04 AM
// Design Name: 
// Module Name: Final_tb
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


module Final_tb();
reg rst;
 reg clk;
 reg [9:0] wrt_addrs;
 reg [9:0] rd_addrs;
 reg [7:0] wrt_dat;
 reg  wrt_en;
 reg button;
 wire [7:0] rd_dat;
 wire [7:0] tst_out;
 wire test_pass;
 wire test_fail;
 wire failed_first_test;
 wire done;
 
 assign test_pass = tst_out[1];
 assign test_fail = tst_out[2];
 assign failed_first_test = tst_out[3];
 assign done = ~tst_out[0];
 
   Sub_BIST Ram (rst, clk, wrt_addrs, rd_addrs, wrt_dat, wrt_en, button,rd_dat,tst_out);

 initial begin
     clk = 0;
    forever begin
        #50 clk = ~clk;
    end
end 
initial begin
button = 0;
rst = 0;
#100 wrt_addrs = 100;
rd_addrs = 100;
wrt_en = 1;
wrt_dat = 8'b11111111;
#200 rst = 1;
#1000 wrt_en = 0; 
#300 rst = 0;
#3400000 wrt_en = 1;
#500 wrt_en = 0;
      
 end 

endmodule
