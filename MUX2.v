`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/18 14:29:33
// Design Name: 
// Module Name: MUX2
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

module MUX2(
input [1:0]index,
input [4:0]a,
input [4:0]b,
input [4:0]c,
input [4:0]d,
output[4:0]result
);
    
    assign result=(index==2'b00)?a:(index==2'b01)?b:(index==2'b10)?c:(index==2'b11)?d:32'bz;
endmodule
