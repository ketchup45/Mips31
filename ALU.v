`timescale 1ns / 1ps
module alu(
        input [31:0] a,        //OP1
        input [31:0] b,        //OP2
        input [3:0] aluc,    //controller
        output reg [31:0] result,    //result
        output reg zero,
        output reg carry,
        output reg negative,
        output reg overflow);
        
    parameter Addu    =    4'b0000;    //r=a+b unsigned
    parameter Add    =    4'b0010;    //r=a+b signed
    parameter Subu    =    4'b0001;    //r=a-b unsigned
    parameter Sub    =    4'b0011;    //r=a-b signed
    parameter And    =    4'b0100;    //r=a&b
    parameter Or    =    4'b0101;    //r=a|b
    parameter Xor    =    4'b0110;    //r=a^b
    parameter Nor    =    4'b0111;    //r=~(a|b)
    parameter Lui1    =    4'b1001;    //r={b[15:0],16'b0}
    parameter Lui2    =    4'b1000;    //r={b[15:0],16'b0}
    parameter Slt    =    4'b1011;    //r=(a-b<0)?1:0 signed
    parameter Sltu    =    4'b1010;    //r=(a-b<0)?1:0 unsigned
    parameter Sra    =    4'b1100;    //r=b>>>a 
    parameter Sll    =    4'b1110;    //r=b<<a
    parameter Srl    =    4'b1101;    //r=b>>a
    
    wire signed [31:0] sa = a, sb = b;
    reg [32:0] temp;
    
    always@(*)begin
        case(aluc)
            Addu:  begin
             result=a+b;
             temp = a+b;
             carry = temp[32]==1 ? 1:0;
             end
            Subu:  begin
             result=a-b;
             carry=(a<b) ? 1 : 0;
             end
            Add: begin
                result=sa+sb;
                if((a[31]==1&&b[31]==1&&result[31]==0)||(a[31]==0&&b[31]==0&&result[31]==1))
                     overflow=1;
                else
                     overflow=0;
            end
            Sub: begin
                result=sa-sb;
                if((a[31]==1&&b[31]==0&&result[31]==0)||(a[31]==0&&b[31]==1&&result[31]==1))
                     overflow=1;
                else
                     overflow=0;
            end
            Sra: begin
                result = sb>>>a;
                carry=(a<=32 && a!=0)? b[a-1]:0;
            end
            Srl: begin
                result = b>>a;
                carry=(a<=32 && a!=0)? b[a-1]:0;
            end
            Sll: begin
                result=b<<a;
                carry=(a<=32 && a!=0)? b[32-a]:0;
            end
            
            And: result=a&b;
            Or:  result=a|b;
            Xor: result=a^b;
            Nor: result=~(a|b);
            
            Sltu: begin
             result=a<b?1:0;
             carry=(a<b)?1:0;
             end
            Slt: begin
             result=sa<sb?1:0;
             negative=sa<sb?1:0;
             end
            Lui1,Lui2: result = {b[15:0], 16'b0};
            default:
                result = 0;
        endcase
        
            if(aluc==4'b1011||aluc==4'b1010)
                zero = (a==b)?1:0;
            else
                zero = (result==0)?1:0;
            
            
             if(aluc!=4'b1011)
                    negative = (result[31]==1)?1:0;
    end


endmodule
