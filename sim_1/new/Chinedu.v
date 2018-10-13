`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2018 08:43:24 PM
// Design Name: 
// Module Name: Chinedu
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


module Chinedu();
    reg rst;
    reg clk;
    reg [9:0] wrt_addrs;
    reg [9:0] rd_addrs;
    reg [7:0] wrt_dat;
    reg wrt_en;
    reg button;
    wire [7:0] rd_data;
    wire [7:0] led_out;
    
    wire cur_tst_state;
        wire tst_pass;
        wire tst_fail;
        
        wire [9:0] ram_rd_addrs;
        wire [9:0] ram_wrt_addrs;
        wire [7:0] ram_wrt_dat;
        wire ram_wrt_en;
        wire bist_wrt_en; 
        
        RAM ram (clk, ram_rd_addrs,ram_wrt_addrs, 
        ram_wrt_en, ram_wrt_dat, rd_data);
                      
        wire clk_div;
        Clock_div Divide(clk,clk_div);
        wire nextcount;
        wire nextpat;
        wire resetpat;
        wire resetcount;
        wire [8:0] pattern;
        wire [10:0] counter;
        
        wire error;
        
        Pattern Pat_Gen ( clk_div, resetcount, resetpat,
        nextpat, nextcount, error, pattern,counter);
                 
        BIST_controller Control (rst,clk_div,error,
        pattern[8],counter [10],nextpat,
        nextcount, cur_tst_state,
        tst_pass ,tst_fail ,resetcount,resetpat);
               
        Multiplexer #(10) Read_address(clk,rd_addrs,counter[9:0],cur_tst_state,ram_rd_addrs) ;
        Multiplexer #(10) Write_address(clk,wrt_addrs, counter[9:0], cur_tst_state , ram_wrt_addrs); 
        Multiplexer #(8) Write_data (clk,wrt_dat, pattern [7:0] , cur_tst_state , ram_wrt_dat ); 
        assign ram_wrt_en = (wrt_en & ~cur_tst_state) | (bist_wrt_en & cur_tst_state);
          
        assign bist_wrt_en = clk_div & cur_tst_state;
        Comparator Test_result (pattern[7:0], rd_data ,error);
        
     initial begin
        clk = 0;
        forever begin
        #50 clk = ~clk;
        end
     end 
     initial begin
         rst = 0;
         
         #300 rst = 1;
         #500 rst = 0;
          #10000000 wrt_en = 1;
                    wrt_addrs = 10'h0; 
                    wrt_dat = 10'h01;
                    rd_addrs = 10'h0;
                    #200
                    wrt_en = 0;
                     
                    #200 wrt_en = 1;
                    rd_addrs = 10'h1;
                    wrt_addrs =  10'h1;
                    #200 wrt_en = 0;
     end  
    endmodule
