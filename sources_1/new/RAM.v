`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2018 08:40:30 PM
// Design Name: 
// Module Name: RAM
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


module RAM( clk, ram_rd_addrs, ram_wrt_addrs,
 ram_wrt_en, ram_wrt_dat, ram_rd_dat);
    input clk;
    input [9:0] ram_rd_addrs;
    input [9:0] ram_wrt_addrs;
    input ram_wrt_en;
    input [7:0] ram_wrt_dat;
    output reg [7:0] ram_rd_dat;
    reg [7:0] memory [1023:0];
    always@(posedge clk) begin
        if(ram_wrt_en) begin
            if (~(ram_wrt_addrs == 100 ))begin
                memory[ram_wrt_addrs] <= ram_wrt_dat;
            end
            else begin
                memory[ram_wrt_addrs] <= {ram_wrt_dat[7:5], ~ram_wrt_dat[4], ram_wrt_dat[3:0]};
            end
        end
       else begin
           ram_rd_dat <= memory[ram_rd_addrs];
        end
    end
endmodule
