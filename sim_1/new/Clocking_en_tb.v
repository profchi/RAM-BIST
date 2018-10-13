`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2018 12:00:54 PM
// Design Name: 
// Module Name: Clocking_en_tb
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


module Clocking_en_tb(  );
reg clk;
wire clk_div;
reg state;
wire mode;

Clock_div Div (clk, clk_div);
clocking Divide (clk,clk_div,state,mode);
initial begin
  clk = 0;
  forever begin
  #50 clk = ~clk;
  end
 end
  initial begin
  state = 0;
  #100 state = 1;
  end
endmodule
