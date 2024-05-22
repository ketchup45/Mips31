`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/14 23:45:06
// Design Name: 
// Module Name: clk_div
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


module CLK_DIV(
input clk_in,
input rst,
output clk_out
);
   reg [2:0]counter;
        always @ (posedge clk_in or posedge rst)begin
            if(rst)
                counter<=0;
            else 
                counter<=counter+1'b1;
        end
        assign clk_out=counter[2];
endmodule
