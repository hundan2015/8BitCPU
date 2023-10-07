`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/08/16 17:45:45
// Design Name:
// Module Name: Control
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


module Control(
        commandIn,
        ctl_RegDst,
        ctl_Branch,
        ctl_memRead,
        ctl_MemtoReg,
        ctl_ALUOp,
        ctl_memWrite,
        ctl_ALUSrc,
        ctl_RegWrite
    );

    input [5:0] commandIn;
    reg [9:0]outShit;
    output  ctl_RegDst,ctl_Branch,ctl_memRead,
            ctl_MemtoReg,ctl_memWrite,
            ctl_ALUSrc,ctl_RegWrite;
    output [2:0]ctl_ALUOp;
    assign ctl_RegDst = outShit[9];
    assign ctl_ALUSrc = outShit[8];
    assign ctl_MemtoReg = outShit[7];
    assign ctl_RegWrite = outShit[6];
    assign ctl_memRead = outShit[5];
    assign ctl_memWrite=outShit[4];
    assign ctl_Branch=outShit[3];
    assign ctl_ALUOp=outShit[2:0];
    initial begin
        outShit = 0;
    end
    always @(*)
    begin
        case (commandIn)
            0:
                outShit =10'b1001000010; // R Type
            8:
                outShit =10'b0101000100; // I Type addi
            10:
                outShit =10'b0101000101; // slti
            12:
                outShit =10'b0101000110; // andi
            13:
                outShit =10'b0101000111; // ori
            35:
                outShit =10'b0111100000;// lw
            43:
                outShit =10'b0100010000;// sw
            4:
                outShit =10'b0000001001; //beq
            endcase
    end
endmodule
