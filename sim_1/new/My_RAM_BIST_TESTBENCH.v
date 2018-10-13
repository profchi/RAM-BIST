`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2018 02:47:58 PM
// Design Name: 
// Module Name: My_RAM_BIST_TESTBENCH
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


module My_RAM_BIST_TESTBENCH();

    reg rst;
    reg clk;
    reg [9:0] wrt_addrs;
    reg [9:0] rd_addrs;
    reg [7:0] wrt_dat;
    reg wrt_en;
    reg button;
    wire [7:0] ram_rd_data;
    wire [7:0] tst_out;
    
    
    
    // My_RAM_BIST project (rst, clk, wrt_addrs, rd_addrs, wrt_dat, wrt_en, button,rd_data,tst_out);
      wire [9:0] ram_rd_addrs;
      wire [9:0] ram_wrt_addrs;
      wire [7:0] ram_wrt_dat;
      wire ram_wrt_en;
   
     RAM ram (clk, ram_rd_addrs,ram_wrt_addrs, 
     ram_wrt_en, ram_wrt_dat, ram_rd_data);
      
        
     wire clk_div;
     Clock_div Divide(clk,clk_div);
     
     wire nextcount;
     wire nextpat;
     wire resetpat;
     wire resetcount;
     wire [8:0] pattern;
     wire [10:0] counter;
     Pattern Pat_Gen ( clk_div, resetcount, resetpat,
     nextpat, nextcount , pattern,counter);
     
     wire error;
     Comparator Test_result (pattern[7:0], ram_rd_data ,error);
    
     BIST_controller Control (rst,clk_div,error,
     pattern[8],counter [10],nextpat,
     nextcount, tst_out[0],
     tst_out[1],tst_out[2],resetcount,resetpat);
     
     wire bist_wrt_en;    
     Multiplexer #(10) Read_address(clk,rd_addrs,counter[9:0],tst_out[0],ram_rd_addrs) ;
     Multiplexer #(10) Write_address(clk,wrt_addrs, counter[9:0],tst_out[0], ram_wrt_addrs); 
     Multiplexer #(8) Write_data (clk,wrt_dat, pattern [7:0] , tst_out[0], ram_wrt_dat ); 
    // Multiplexer #(1) Write_enable (clk,wrt_en, bist_wrt_en , tst_out[0], ram_wrt_en);
    assign ram_wrt_en = (wrt_en & ~tst_out[0]) | (bist_wrt_en & tst_out[0]);
  
   clocking BIST_write_enable (clk,clk_div,tst_out[0],bist_wrt_en);
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
       
        end  
endmodule
