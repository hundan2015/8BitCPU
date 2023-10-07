`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/08/16 14:21:10
// Design Name:
// Module Name: Reg
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


module Reg(
        CLK,
        ctl_RegWrite,   //控制端，确定寄存器写使能是否有效
        readRegPosIn1,  //读寄存器1
        readRegPosIn2,  //读寄存器2
        writeRegPosIn,  //写寄存器
        dataIn,         //写数�?
        readDataOut1,   //读数�?1
        readDataOut2    //读数�?1
    );
    input CLK,ctl_RegWrite;
    input [4:0] readRegPosIn1,readRegPosIn2,writeRegPosIn;
    input [15:0] dataIn;
    output reg [15:0] readDataOut1,readDataOut2;
    reg [15:0] cpuRegs[31:0]; //32�?16位寄存器
    integer i;
    initial
    begin
        for(i=0;i<32;i=i+1)
        begin
            cpuRegs[i] = 0;
        end
        cpuRegs[0] = 1;
        cpuRegs[1] = 2;
    end
    always @(posedge CLK)
    begin
        readDataOut1 = cpuRegs[readRegPosIn1];
        readDataOut2 = cpuRegs[readRegPosIn2];

    end
    always @(negedge CLK)
    begin
        if(ctl_RegWrite)
        begin  //允许写数�?
            cpuRegs[writeRegPosIn] = dataIn;
        end
    end
endmodule
