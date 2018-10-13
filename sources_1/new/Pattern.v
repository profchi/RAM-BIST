`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2018 04:08:29 PM
// Design Name: 
// Module Name: Pattern
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


module Pattern( clk, count_rst, pat_rst, nxt_pat_trig,
 nxt_count_trig, error, pat, count);
     input clk;
     input count_rst;
     input pat_rst;
     input nxt_pat_trig;
     input nxt_count_trig;
     input error;
     output reg [8:0] pat;
     output reg [10:0] count;
     
     always @ (posedge clk)
     begin
        if (count_rst)
        begin
            count = 0;
        end
        else if (nxt_count_trig & ~pat[8] & ~error)
        begin
            count <= count + 1;
        end
        
        if (pat_rst)
        begin
            pat = 1;
        end
        else if (nxt_pat_trig & ~error)
        begin
            pat <= pat*2;
        end
     end
     
endmodule
