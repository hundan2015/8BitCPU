`timescale 1ns / 1ps
`include "ALU.v"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/09/08 19:48:19
// Design Name:
// Module Name: ALU_tb
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


module ALU_tb(
    );
    reg  [3:0] ALUcontrol;
    reg [15:0] src1,src2;
    wire ZF;
    wire [15:0] res;
    ALU alu(ALUcontrol,src1,src2,ZF,res);
    initial
    begin
        //先初始化一下
        src1 = 1;
        src2 = 2;
        ALUcontrol = 0;
        #10
         ALUcontrol  = 1;
        #10
         ALUcontrol = 2;
        #10
         ALUcontrol = 6;
        #10
         ALUcontrol = 7;
        #10
         ALUcontrol = 12;
    end

endmodule
