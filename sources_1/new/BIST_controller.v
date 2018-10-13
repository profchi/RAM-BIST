`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2018 09:03:10 AM
// Design Name: 
// Module Name: BIST_controller
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


module BIST_controller(rst,clk,error,pat_end,count_end,nxt_pat,
    nxt_count,tst_state,tst_pass,tst_fail,rst_count,rst_pat, tst_count[1]);
    input rst;
    input clk;
    input error;
    input pat_end;
    input count_end;
    output nxt_pat;
    output reg nxt_count;
    output reg tst_state;
    output reg tst_pass;
    output reg tst_fail;
    output rst_count;
    output rst_pat;   
    output reg [1:0]tst_count; 
    reg rst_2nd_test;
    reg mode;
    assign nxt_pat = count_end;
    assign rst_pat = rst | rst_2nd_test;
    assign rst_count = rst | count_end| rst_2nd_test ;
    
    always @(posedge clk)
    begin
        if(rst_2nd_test)
            rst_2nd_test <= ~rst_2nd_test;
        if(rst)
            begin
                mode = 1;
                tst_pass = 0;
                tst_fail = 0;
                nxt_count = 0;
                tst_count = 0;
                rst_2nd_test = 0;
            end        
        tst_state <= mode & ~rst;
        if(tst_state)
            begin
                if(pat_end | error)
                    begin
                        mode = 0;
                        tst_pass <= pat_end;
                        tst_fail <= error;
                        nxt_count = 0;
                        tst_count <= tst_count + 1;
                    end
                else 
                    begin
                        nxt_count = mode;
                    end
            end
        if (~tst_state & tst_fail & tst_count[1])
            begin
                mode = 1;  
                nxt_count = 0;
                rst_2nd_test = 1; 
            end
    end  
endmodule
