`timescale 1ns / 1ps

module MUX1(
input [1:0]index,
input [31:0]a,
input [31:0]b,
input [31:0]c,
input [31:0]d,
output[31:0]result
);
    
    assign result=(index==2'b00)?a:(index==2'b01)?b:(index==2'b10)?c:(index==2'b11)?d:32'bz;
endmodule