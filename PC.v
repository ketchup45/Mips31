`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/14 23:46:10
// Design Name: 
// Module Name: PC
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


module PcReg(
    input clk,
    input rst,
    input ena,
    input [31:0] PR_in,
    output [31:0] PR_out
    );
    reg [31:0] pc_reg;
    always @(negedge clk or posedge rst) begin
        if (ena) begin
            if (rst)
               pc_reg <= 32'h00400000;
            else
                pc_reg <= PR_in;
        end
    end

      assign PR_out = rst ? 32'h0040_0000 : pc_reg;
endmodule