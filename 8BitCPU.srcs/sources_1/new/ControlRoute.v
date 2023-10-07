`timescale 1ns / 1ps
/* `include "PC.v"
`include "Reg.v"
`include "ALU.v"
`include "OrderStore.v" */
/* This is the main Module of the full CPU. */
`include "ALUControl.v"
`include "CLKControl.v"
module ControlRoute(
        CLK,dataOut
    );
    input CLK;
    output [15:0]dataOut;
    //TODO: Make a CLK control
    //TODO:make it 16bit.
    reg pc_CLK,reg_CLK,datastore_CLK,orderstore_CLK; // Define CLK.
    //PC part.
    reg [15:0]pc_lastpos,pc_outpos; //在mips中指令中地址至少是16位
    //OrderStore part.
    //FIXME: How to make orderStore 16BIT?
    wire [31:0]orderstore_orderOut;
    wire [15:0]orderstore_addressIn;
    //RegStore part.
    wire regstore_ctlRegWrite;
    reg [4:0] regstore_readRegPosIn1,regstore_readRegPosIn2,regstore_writeRegPosIn;
    reg [15:0] regstore_dataIn;
    reg [15:0] regstore_readDataOut1,regstore_readDataOut2;
    //ALU part.
    reg  [3:0] ALU_ALUcontrol;
    reg [15:0] ALU_src1,ALU_src2;
    wire ALU_ZF;
    wire [15:0] ALU_res;
    //DataStore part.
    reg [15:0] datastore_addressIn;//8位地址
    reg [15:0] datastore_dataIn;
    reg datastore_ctl_memWrite,datastore_ctl_memRead;
    wire [15:0] datastore_dataOut;
    //control part.
    wire [5:0] ctl_commandIn;
    wire  ctl_RegDst,ctl_Branch,ctl_memRead,
          ctl_MemtoReg,ctl_memWrite,
          ctl_ALUSrc,ctl_RegWrite;
    //wire [1:0]ctl_ALUOp;\
    wire [2:0]ctl_ALUOp;
    //ALUControl part.
    reg [1:0] ALUControl_ALUOp;
    reg [5:0] ALUControl_FuncCode;
    reg [3:0] ALUControl_ALUCtl;

    assign dataOut = ALU_res;
    //Define all the modules.
    CLKControl clkControl(CLK,pc_CLK ,reg_CLK,orderstore_CLK,datastore_CLK);
    PC pc(.CLK(pc_CLK),.lastpos(pc_lastpos),.outpos(pc_outpos));
    Reg regstore(reg_CLK,regstore_ctlRegWrite,regstore_readRegPosIn1,//读寄存器1
                 regstore_readRegPosIn2,  //读寄存器2
                 regstore_writeRegPosIn,  //写寄存器
                 regstore_dataIn,         //写数据
                 regstore_readDataOut1,
                 regstore_readDataOut2);
    ALU alu(
            ALU_ALUcontrol, //控制ALU的行为，加减乘除移位
            ALU_src1,
            ALU_src2,
            ALU_ZF,         //零标志
            ALU_res
        );
    ALUControl aluControl(
                   ALUControl_ALUOp,ALUControl_FuncCode,ALUControl_ALUCtl
               );
    OrderStore orderstore(
                   orderstore_CLK,
                   orderstore_addressIn,
                   orderstore_orderOut
               );
    Control control(
                ctl_commandIn,
                ctl_RegDst,
                ctl_Branch,
                ctl_memRead,
                ctl_MemtoReg,
                ctl_ALUOp,
                ctl_memWrite,
                ctl_ALUSrc,
                ctl_RegWrite
            );
    DataStore datastore(
                  datastore_CLK,
                  datastore_addressIn,
                  datastore_dataIn,
                  datastore_ctl_memWrite,   //读写入段的数据写到指定地址
                  datastore_ctl_memRead,    //数据存储器读使能有效
                  datastore_dataOut
              );

    reg [5:0]ctrl;
    reg [4:0]readreg1,readreg2,writereg;
    reg [5:0]funcCode,shamt;
    reg [15:0] address;
    always @(*)
    begin
        // Define the branch.
        ctrl = orderstore_orderOut[31:26];
        readreg1 = orderstore_orderOut[25:21]; // rs
        readreg2 = orderstore_orderOut[20:16]; // rt
        writereg = orderstore_orderOut[15:11]; // rd
        funcCode = orderstore_orderOut[5:0];   // funct
        address = orderstore_orderOut[15:0];   // addr
        shamt = orderstore_orderOut[10:6];     // shamt
        // Real route start.
        regstore_readRegPosIn1 = readreg1;
        regstore_readRegPosIn2 = readreg2;

        // MUX before reg.
        regstore_writeRegPosIn = (ctl_RegDst) ? readreg2 : writereg;


        ALU_src1 = regstore_readDataOut1;
        //FIXME: need a 32 bit extend!
        //mux after reg
        ALU_src2 = ctl_ALUSrc ? regstore_readDataOut2 : regstore_readDataOut2;
        
        //ALU Control.
        ALUControl_FuncCode = funcCode;
        ALUControl_ALUOp = ctl_ALUOp;
        ALU_ALUcontrol = ALUControl_ALUCtl;

        datastore_addressIn = ALU_res;
        datastore_dataIn = regstore_readDataOut2;

        //MUX after dataStore.
        regstore_dataIn = ctl_MemtoReg ?
                        ALU_res : datastore_dataOut;

        //TODO: 还差一个分支的MUX
        pc_lastpos = ctl_Branch & ALU_ZF ? pc_outpos:address + pc_outpos;
    end
endmodule
