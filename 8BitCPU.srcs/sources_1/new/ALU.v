//这是一个8位CPU，所以说只需要进行8位运算即可。
// ALU所进行的运算十分有限。ALU只能进行6种运算。
// 例如说乘法除法，本身是依赖于这几种运算的。这些运算能构建出其他所有的运算。
/**
最后还是想使用16位。因为最后在指令寻址的时候最后会是16位。
*/
module ALU (
        ALUcontrol, //控制ALU的行为，加减乘除移位
        src1,
        src2,
        ZF,         //零标志
        res,
        ADD_shamt
    );
    input [3:0] ALUcontrol;
    input [15:0] src1,src2;
    input [4:0] ADD_shamt;
    output reg ZF;
    output reg [15:0] res;
    integer i;
    initial
    begin
        ZF = 0;
        res =0;
    end
    always @(*)
    begin
        //TODO:之后要不要支持移位方法？
        //XXX:关于ALU的移位，需要一个额外的输入，和一组全新的opCode来支持。
        case (ALUcontrol)
            4'b0000:
                res = src1 & src2; // 0
            4'b0001:
                res = src2 | src1; // 1
            4'b0010:
                res = src1 + src2; // 2
            4'b0100:
                res = src2 << ADD_shamt; //About the SLL, src2 = regReadOut2 + shamt
            4'b0101:
                res = src2 >> ADD_shamt;
            4'b0011:                //SAR Arithmetic Shift right(sign-extended)
            begin
                for(i=0;i<ADD_shamt;i=i+1)
                begin
                    res = src2>>1;
                    res[15] = res[14];
                end
            end
            4'b0110:
                res = src1 - src2; // 6
            //小于则置位
            4'b0111:
                res = src1 < src2 ? 1:0; //
            4'b1000:
                res = src1 & ~(src2);
            4'b1100:
                res = ~(src1 | src2); // 12

            default:
                res = 0;
        endcase
        ZF = (res == 0);
    end

endmodule
/*
TODO: 这块我们需要一个左右移的算符。左移需要设置两种，右移也需要两种。所以最终还是需要状态寄存器吗？？？？
真的不知道如何设置了。
*/
