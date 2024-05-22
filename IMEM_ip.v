`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 03:32:01
// Design Name: 
// Module Name: IMEM_ip
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


module _imem(
    input [10:0] addr,
    output [31:0] rd
    );

    imem instr_mem(
        .a(addr),
        .spo(rd)
    );

endmodule
