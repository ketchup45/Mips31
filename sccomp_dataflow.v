`timescale 1ns / 1ps

module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc
    //output  [7:0]o_seg,
    //output [7:0]o_sel
    );
    wire dw, dr, dena;
    wire [31:0] w_data, r_data;
    wire [31:0] instr;
    wire [10:0] dm_addr;
    wire [31:0] im_addr;
    wire [31:0] res;
    //wire [7:0]seg;
    //wire [7:0]sel;
    //assign o_seg=seg;
    //assign o_sel=sel;
    assign inst = instr;
    assign dm_addr = (res - 32'h1001_0000) / 4;
    //CLK_DIV div(
        //.clk_in(clk_in),.rst(reset),.clk_out(clk)
        //);
    //IMEM imemory(
        //.addr(im_addr[10:0]),
        //.IM_R(1'b1),
        //.rd(instr)
    //);
    _imem imemory(
            .addr(im_addr[10:0]),
            .rd(instr)
        );
    assign im_addr = (pc - 32'h0040_0000)/4;
    DMEM dmemory(
        .clk(clk_in), .CS(dena), .DM_W(dw), .DM_R(dr), .addr(dm_addr[10:0]), .wdata(w_data),
        .rdata(r_data)
    );
    CPU sccpu(
        .clk(clk_in),.rst(reset), .IM_inst(instr), .DM_rdata(r_data),
        .DM_ena(dena), .DM_W(dw), .DM_R(dr), .DM_wdata(w_data), .PC_out(pc),.alu_out(res)
    );
        
endmodule
