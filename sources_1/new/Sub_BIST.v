`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2018 07:06:49 PM
// Design Name: 
// Module Name: Sub_BIST
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


module Sub_BIST(rst, clk, wrt_addrs, rd_addrs, wrt_dat, wrt_en, button,rd_data ,led_out);
    input rst;
    input clk;
    input [9:0] wrt_addrs;
    input [9:0] rd_addrs;
    input [7:0] wrt_dat;
    input  wrt_en;
    input button;
    output wire [7:0] rd_data;
    output reg [7:0] led_out;
    
    reg [7:0] extra_bytes;
    reg check_if_fail;
    reg [9:0] def_addrs;
    wire rd_sel;
    
    wire cur_tst_state;
    wire tst_pass;
    wire tst_fail;
    
    wire [7:0] ram_rd_data;
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
            
    wire tst_count;
    BIST_controller Control (rst,clk_div,error,
    pattern[8],counter [10],nextpat,
    nextcount, cur_tst_state,
    tst_pass ,tst_fail ,resetcount,resetpat,tst_count);
           
    //Multiplexer #(10) Read_address(clk,rd_addrs,counter[9:0],cur_tst_state,ram_rd_addrs);
    assign ram_rd_addrs = cur_tst_state? counter[9:0]:rd_addrs;
    //Multiplexer #(10) Write_address(clk,wrt_addrs, counter[9:0], cur_tst_state , ram_wrt_addrs);
    assign ram_wrt_addrs = cur_tst_state? counter[9:0]:wrt_addrs;
    //Multiplexer #(8) Write_data (clk,wrt_dat, pattern [7:0] , cur_tst_state , ram_wrt_dat );
    assign ram_wrt_dat = cur_tst_state? pattern[7:0]:wrt_dat; 
   // assign ram_wrt_en = (wrt_en & ~cur_tst_state) | (bist_wrt_en & cur_tst_state );
    assign ram_wrt_en = cur_tst_state? bist_wrt_en:wrt_en;
    
    assign error = ~(pattern[7:0] == rd_data );
   
    assign bist_wrt_en = clk_div & cur_tst_state;
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
        if (button)begin
                led_out <= counter[7:0];
            end
        else begin
            led_out[7:4] <= 0;
            led_out[3] <= check_if_fail;
            led_out[2] <= tst_fail;
            led_out[1] <= tst_pass;
            led_out[0] <= cur_tst_state;   
            end            
    end
   /* always@(posedge clk )
    begin
        if (button)begin
            led_out <= counter[7:0];
        end
        else begin
            led_out[7:3] <= 0;
            led_out[2] <= tst_fail;
            led_out[1] <= tst_pass;
            led_out[0] <= cur_tst_state;   
        end
    end*/

endmodule
