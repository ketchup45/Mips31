`timescale 1ns / 1ps

module IMEM(
input [10:0] addr,
input IM_R,
output [31:0] rd
);
   
reg [31:0] RAM[2047:0];

initial
begin
  $readmemh("E:/VivadoProject/mips31cpu/mips31cpu/mips31cpu.srcs/sources_1/new/imem.txt",RAM);
end

   assign rd =(IM_R) ? RAM[addr] : 32'bz;
endmodule
