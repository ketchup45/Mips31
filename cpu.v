`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/11 18:43:44
// Design Name: 
// Module Name: cpu
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


module CPU(
    input clk,
    input rst,
    output DM_ena,
    output DM_W,
    output DM_R,
    input [31:0] IM_inst,
    input [31:0] DM_rdata,
    output [31:0] DM_wdata,
    output [31:0] PC_out,
    output [31:0] alu_out
    ); 
           
    wire zeroFlag,carryFlag,negFlag,overflowFlag;//ALU.Z
    wire [3:0]ALUC;
    wire [1:0] M1,M2,M5;
    wire M3,M4;
    wire DM_CS;
    wire [15:0] imm_16;
    wire [25:0] address;
    wire [4:0] shamt;
    wire ext16_su;
    wire [4:0] Rsc,Rdc,Rtc;
    wire RF_W;
    
           instr_decoder in_de(
               .IM_inst(IM_inst),
               .overflow(overflowFlag),
               .zero(zeroFlag),
               .ALUC(ALUC),
               .DM_CS(DM_ena),
               .DM_R(DM_R),
               .DM_W(DM_W),
               .RF_W(RF_W),
               .ext16_su(ext16_su),
               .M1(M1),
               .M2(M2),
               .M3(M3),
               .M4(M4),
               .M5(M5),
               .imm_16(imm_16),
               .address(address),
               .shamt(shamt),
               .Rsc(Rsc),
               .Rtc(Rtc),
               .Rdc(Rdc)
               );
           
           wire [31:0] EXT18,EXT16,EXT5,combiner,adder;
           
           wire [31:0]pc,npc,Rs,Rt,Rd,alu_rslt;
           assign PC_out = pc;
           assign npc = pc + 32'd4;
           assign alu_out = alu_rslt;
           assign DM_wdata = DM_W ? Rt : 32'bz;
         
           
           assign EXT18=imm_16[15]==1?{14'b11111111111111,imm_16,2'b00}:{14'b0,imm_16,2'b00};
           assign EXT16 = (ext16_su)?{{16{imm_16[15]}}, imm_16}:{16'b0, imm_16};
           assign EXT5={27'b0,shamt};
           assign combiner={pc[31:28],address,2'b0};
           assign adder=EXT18 + npc;
           
           wire [31:0] rslt1,rslt2,rslt3,rslt4;
           wire [4:0] rslt5;
           
           MUX1 MUX_1(
               .index(M1),
               .a(npc),
               .b(adder),
               .c(combiner),
               .d(Rs),
               .result(rslt1)
           );
                
           MUX1 MUX_2(
                .index(M2),
                .a(alu_rslt),
                .b(npc),
                .c(DM_rdata),
                .d(32'b0),
                .result(rslt2)
                );
                
           assign rslt3 = M3 ? EXT5 : Rs;//a
           assign rslt4 = M4 ? EXT16 : Rt;//b
           
           MUX2 MUX_5(
              .index(M5),
               .a(Rdc),
               .b(5'd31),
               .c(Rtc),
               .d(5'd31),
               .result(rslt5));
           
           PcReg pcreg(
               .clk(clk),
               .rst(rst),
               .ena(1'b1),
               .PR_in(rslt1),
               .PR_out(pc)
               );
           
           alu cpu_alu(
               .a(rslt3),
               .b(rslt4),
               .aluc(ALUC),
               .result(alu_rslt),
               .zero(zeroFlag),
               .carry(carryFlag),
               .negative(negFlag),
               .overflow(overflowFlag)
               );
           
           RegFile cpu_ref(
               .RF_ena(1'b1),
               .RF_rst(rst),
               .RF_clk(clk),
               .Rdc(rslt5),
               .Rsc(Rsc),
               .Rtc(Rtc),
               .Rd(rslt2),
               .Rs(Rs),
               .Rt(Rt),
               .RF_W(RF_W)
           );
           
       
endmodule
