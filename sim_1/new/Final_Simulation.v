`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2018 07:23:27 AM
// Design Name: 
// Module Name: Final_Simulation
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


module Final_Simulation( );
reg rst;
reg clk;
reg [9:0] wrt_addrs;
reg [9:0] rd_addrs;
reg [7:0] wrt_dat;
reg wrt_en;
reg button;
wire [7:0] led_out;

wire [7:0] rd_data;
wire [7:0] ram_rd_data;
reg [7:0] extra_bytes;
reg check_if_fail;
reg [9:0] def_addrs;
wire tst_count;
wire rd_sel;

wire cur_tst_state;
    wire tst_pass;
    wire tst_fail;
    
    wire [9:0] ram_rd_addrs;
    wire [9:0] ram_wrt_addrs;
    wire [7:0] ram_wrt_dat;
    wire ram_wrt_en;
    wire bist_wrt_en; 
    
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
    
    wire error;
    
    Pattern Pat_Gen ( clk_div, resetcount, resetpat,
    nextpat, nextcount, error, pattern,counter);
             
    BIST_controller Control (rst,clk_div,error,
    pattern[8],counter [10],nextpat,
    nextcount, cur_tst_state,
    tst_pass ,tst_fail ,resetcount,resetpat,tst_count);
           
    Multiplexer #(10) Read_address(clk,rd_addrs,counter[9:0],cur_tst_state,ram_rd_addrs) ;
    Multiplexer #(10) Write_address(clk,wrt_addrs, counter[9:0], cur_tst_state , ram_wrt_addrs); 
    Multiplexer #(8) Write_data (clk,wrt_dat, pattern [7:0] , cur_tst_state , ram_wrt_dat ); 
    assign ram_wrt_en = (wrt_en & ~cur_tst_state) | (bist_wrt_en & cur_tst_state);
      
    assign bist_wrt_en = clk_div & cur_tst_state;
    Comparator Test_result (pattern[7:0], rd_data ,error);
    assign rd_sel = check_if_fail & (ram_rd_addrs == def_addrs);
    Multiplexer #(8) Read_data (clk,ram_rd_data, extra_bytes , rd_sel , rd_data ); 
    always @ (posedge clk)
    begin
        if(rst)
            check_if_fail = 0;
        else if (~cur_tst_state & tst_fail & tst_count)
            begin 
                check_if_fail <= 1;
                def_addrs <= counter;
            end
        if (check_if_fail)
            begin
                if((ram_wrt_addrs == def_addrs) & ram_wrt_en)
                    extra_bytes <= ram_wrt_dat;
            end       
    end
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