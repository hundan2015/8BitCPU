`timescale 1ns / 1ps
`include "Control.v"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/09/08 21:13:25
// Design Name:
// Module Name: Control_tb
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


module Control_tb(

    );
    reg [5:0] commandIn;
    //reg [8:0]outShit;
    wire  ctl_RegDst,ctl_Branch,ctl_memRead,
          ctl_MemtoReg,ctl_memWrite,
          ctl_ALUSrc,ctl_RegWrite;
    wire [1:0]ctl_ALUOp;
    Control ctl(commandIn,
                ctl_RegDst,
                ctl_Branch,
                ctl_memRead,
                ctl_MemtoReg,
                ctl_ALUOp,
                ctl_memWrite,
                ctl_ALUSrc,
                ctl_RegWrite);
    initial
    begin
        commandIn = 0;
        #10
         commandIn = 35;
        #10
         commandIn = 43;
        #10
         commandIn = 4;
    end
endmodule
