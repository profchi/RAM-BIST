`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2018 06:50:14 AM
// Design Name: 
// Module Name: Multiplex_tb
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


module Multiplex_tb( );
reg clk;
reg [8:0] one;
reg [8:0] two;
reg select;
wire [8:0] result;

Multiplexer #(9) Mult(clk,one, two , select, result);

initial begin
    clk = 0;
    forever begin
     #50 clk = ~clk;
     end
    end
initial begin
#100 one = 9'b111111111;
 two =  9'b100000000;
select = 0;
#1000
select = 1;
#500 select = 0;
#500 select = 1;
end

endmodule
