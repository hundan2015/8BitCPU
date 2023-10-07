`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/09/17 16:25:52
// Design Name:
// Module Name: CLKControl_tb
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


module RegControl_tb(
    );
    reg CLK,ctl_RegWrite;
    reg [5:0]readRegPosIn1,readRegPosIn2,writeRegPosIn;
    reg [15:0]dataIn;
    wire [15:0]readDataOut1,readDataOut2;
    Reg regStore(CLK,
                 ctl_RegWrite,   //控制端，确定寄存器写使能是否有效
                 readRegPosIn1,  //读寄存器1
                 readRegPosIn2,  //读寄存器2
                 writeRegPosIn,  //写寄存器
                 dataIn,         //写数�?
                 readDataOut1,   //读数�?1
                 readDataOut2    //读数�?1
                );
    integer i;
    initial
    begin
        ctl_RegWrite=0;
        dataIn=0;
        readRegPosIn2=0;
        writeRegPosIn=0;
        readRegPosIn1=0;
        for(i=0;i<32;i=i+1)
        begin
            #10
            CLK=0;
            #10
            CLK=1;
            readRegPosIn1=readRegPosIn1+1;
        end
    end
endmodule
