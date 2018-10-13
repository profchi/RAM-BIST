`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2018 09:21:30 PM
// Design Name: 
// Module Name: RAM_BIST_tb
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


module RAM_BIST_tb();

    reg ram_clk;
    reg [9:0] ram_rd_addrs;
    reg [9:0] ram_wrt_addrs;
    reg ram_wrt_en;
    reg [7:0] ram_wrt_dat;
    wire [7:0] ram_rd_dat;
    wire clk_out;
    RAM RAM( ram_clk,
    ram_rd_addrs, 
    ram_wrt_addrs, 
    ram_wrt_en, 
    ram_wrt_dat, 
    ram_rd_dat);
    Clock_div Divide(ram_clk,clk_out);
    initial begin
    ram_clk = 1'b0;
    forever #50 ram_clk = ~ram_clk;
    end
    initial begin
    #1000 ram_wrt_en = 1;
    ram_wrt_addrs = 10'h0; 
    ram_wrt_dat = 10'h01;
    ram_rd_addrs = 10'h0;
    #100
    ram_wrt_en = 0;
     
    #300 ram_wrt_en = 1;
    ram_rd_addrs = 10'h1;
    ram_wrt_addrs =  10'h1;
    #100 ram_wrt_en = 0;
    end
   
endmodule
