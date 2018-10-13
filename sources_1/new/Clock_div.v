`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2018 02:10:31 AM
// Design Name: 
// Module Name: Clock_div
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


module Clock_div(
    input clk_in,
    output reg clk_out);
    reg count;
    reg reset = 1;
    always@(posedge clk_in)
    if (reset)begin
        reset <= 0;
        clk_out = 0;
        count = 0;
    end
    else begin
        if (count == 1) begin
            clk_out = ~clk_out;
            count = 0;
        end
        else begin
            count <= count + 1;
        end
    end
endmodule
