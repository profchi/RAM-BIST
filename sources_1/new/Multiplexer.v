`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2018 01:59:43 AM
// Design Name: 
// Module Name: Multiplexer
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


module Multiplexer( clk,input1, input2 ,sel, out );
    
    parameter size = 8;
    input clk;
    input [size - 1 : 0] input1;
    input [size-1 : 0] input2;
    input sel;
    output [size -1 : 0] out;
    assign out = sel? input2:input1;
    /*always@ (posedge clk)
    begin 
        if (~sel) begin
        out <= input1;
        end 
        else begin
        out <= input2;
        end
   end*/
endmodule
