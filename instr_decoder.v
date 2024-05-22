`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/17 22:37:57
// Design Name: 
// Module Name: instr_decoder
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


module instr_decoder(
    input [31:0] IM_inst,
    input overflow,
    input zero,
    output [3:0] ALUC,
    output DM_CS,
    output DM_R,
    output DM_W,
    output RF_W,
    output ext16_su,
    output [1:0] M1,
    output [1:0] M2,
    output M3,
    output M4,
    output [1:0] M5,
    output [15:0] imm_16,
    output [25:0] address,
    output [4:0] shamt,
    output [4:0] Rsc,
    output [4:0] Rtc,
    output [4:0] Rdc
    );
    
    wire _add, _addu, _sub, _subu, _and, _or, _xor, _nor;
    wire _slt, _sltu, _sll, _srl, _sra, _sllv, _srlv, _srav, _jr;
    wire  _addi, _addiu, _andi, _ori, _xori, _lw, _sw;
    wire _beq, _bne, _slti, _sltiu, _lui, _j, _jal;
    
    //1~17
    assign _add = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100000)?1'b1:1'b0;
    assign _addu = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100001)?1'b1:1'b0;
    assign _sub = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100010)?1'b1:1'b0;
    assign _subu = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100011)?1'b1:1'b0;
    assign _and = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100100)?1'b1:1'b0;
    assign _or = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100101)?1'b1:1'b0;
    assign _xor = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100110)?1'b1:1'b0;
    assign _nor = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100111)?1'b1:1'b0;
    
    assign _slt = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b101010)?1'b1:1'b0;
    assign _sltu = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b101011)?1'b1:1'b0;
    assign _sll = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b000000)?1'b1:1'b0;
    assign _srl = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b000010)?1'b1:1'b0;
    assign _sra = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b000011)?1'b1:1'b0;
    assign _sllv = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b000100)?1'b1:1'b0;
    assign _srlv = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b000110)?1'b1:1'b0;
    assign _srav = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b000111)?1'b1:1'b0;
    assign _jr = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b001000)?1'b1:1'b0;
    
    //18~29
    assign _addi = (IM_inst[31:26]==6'b001000)?1'b1:1'b0;
    assign _addiu = (IM_inst[31:26]==6'b001001)?1'b1:1'b0;
    assign _andi = (IM_inst[31:26]==6'b001100)?1'b1:1'b0;
    assign _ori = (IM_inst[31:26]==6'b001101)?1'b1:1'b0;
    assign _xori = (IM_inst[31:26]==6'b001110)?1'b1:1'b0;
    assign _lw = (IM_inst[31:26]==6'b100011)?1'b1:1'b0;
    assign _sw = (IM_inst[31:26]==6'b101011)?1'b1:1'b0;
    assign _beq = (IM_inst[31:26]==6'b000100)?1'b1:1'b0;
    assign _bne = (IM_inst[31:26]==6'b000101)?1'b1:1'b0;
    assign _slti = (IM_inst[31:26]==6'b001010)?1'b1:1'b0;
    assign _sltiu = (IM_inst[31:26]==6'b001011)?1'b1:1'b0;
    assign _lui = (IM_inst[31:26]==6'b001111)?1'b1:1'b0;
    
    //30 31
    assign _j = (IM_inst[31:26]==6'b000010)?1'b1:1'b0;
    assign _jal = (IM_inst[31:26]==6'b000011)?1'b1:1'b0;
    
    assign ALUC[0]=_sub||_subu||_or||_nor||_slt||_srl||_srlv||_ori||_beq||_bne||_slti;
    assign ALUC[1]=_sub||_xor||_nor||_sll||_sllv||_addi||_xori||_lw||_sw||_beq||_bne||_jal||_slti||_sltiu||_slt||_sltu;
    assign ALUC[2]=_and||_or||_xor||_nor||_sll||_srl||_sra||_sllv||_srlv||_srav||_andi||_ori||_xori;
    assign ALUC[3]=_sll||_srl||_sra||_sllv||_srlv||_srav||_lui||_slti||_sltiu||_slt||_sltu||_lui;
    
    assign ext16_su = (_addi||_addiu||_slti|||_sw||_lw)?1'b1:((_andi||_ori||_xori||_sltiu||_lui)?1'b0:1'bz);

    assign RF_W=(_add&&!overflow)||_addu||(_sub&&!overflow)||_subu||_and||_or||_xor||_nor||_slt||_sltu
                 ||_sll||_srl||_sra||_sllv||_srlv||_srav||(_addi&&!overflow)||_addiu||_andi||_ori||_xori||_lw||_slti||_sltiu||_lui||_jal;
    
    assign imm_16=(_addi||_addiu||_andi||_ori||_xori||_lw||_sw||_beq||_bne||_slti||_sltiu||_lui)?IM_inst[15:0]:16'bz;
    assign address=(_j||_jal)?IM_inst[25:0]:26'bz;
    assign shamt=(_sll||_srl||_sra)?IM_inst[10:6]:5'bz;

    assign DM_CS=_lw||_sw;
    assign DM_R=_lw;
    assign DM_W=_sw;
    
    
    assign Rsc=(_sll||_srl||_sra||_lui||_j||_jal)?5'bz:IM_inst[25:21];
    assign Rtc=(_j||_jal)?5'bz:IM_inst[20:16];
    assign Rdc=(_add|_addu||_sub||_subu||_and||_or||_xor||_nor||_slt||_sltu||_sll||_srl||_sra||_sllv||_srlv||_srav)?IM_inst[15:11]:5'bz;
    
    assign M1[1] = _jr||_j||_jal;
    assign M1[0] = _jr||(_beq && zero)||(_bne && !zero);
    assign M2[1] = _lw;
    assign M2[0] = _jal;
    assign M3 = _sll||_srl||_sra;
    assign M4 = _addi||_addiu||_andi||_xori||_ori||_lw||_sw||_slti||_sltiu||_lui;
    assign M5[1] = _addi||_addiu||_andi||_xori||_ori||_lw||_slti||_sltiu||_lui;
    assign M5[0] = _jal;
    
endmodule
