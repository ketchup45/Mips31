`timescale 1ns / 1ps

module DMEM(
input clk,
input CS,
input DM_W,
input DM_R,
input [10:0] addr,
input [31:0] wdata,
output [31:0] rdata
);
    
reg [31:0] ROM [2047:0];

assign rdata = (CS & DM_R) ? ROM[addr] : 32'hz;

always @(posedge clk)
begin
  if(CS & DM_W)
      ROM[addr] <= wdata;
end
endmodule

