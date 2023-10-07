`timescale 1ns / 1ps
`include "CLKControlAno.v"
`include "ALUControl.v"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/09/09 10:27:31
// Design Name:
// Module Name: ControlRouteRemake
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


module ControlRouteRemake(
        CLK,
        aluDataOut
    );
    input CLK;
    output [15:0]aluDataOut;
    // CLKControl is to control the stage the computing.
    wire CLK1,CLK2,CLK3,CLK4,CLK5;
    //CLKControlAno clkControl(.CLK(CLK),.CLK1(CLK1),.CLK2(CLK2),.CLK3(CLK3),.CLK4(CLK4),.CLK5(CLK5));

    // PC part
    wire PC_CLK;
    assign PC_CLK = CLK2;
    wire [15:0]PC_lastPos,PC_outPos;

    //reg [15:0] mux_isBranch;
    wire [15:0] mux_isBranch;
    assign PC_lastPos = mux_isBranch;

    PC pc(PC_CLK,PC_lastPos,PC_outPos);

    // OrderStore Part
    wire OrderStore_CLK;
    assign OrderStore_CLK = CLK3;
    wire [15:0] OrderStore_addressIn;
    wire [31:0] OrderStore_orderOut;
    assign OrderStore_addressIn = PC_outPos;
    OrderStore orderStore(OrderStore_CLK,OrderStore_addressIn,OrderStore_orderOut);

    // make some distribution
    wire [5:0]ctrl;
    wire [4:0]readReg1,readReg2,writeReg;
    wire [5:0]funcCode,shamt;
    wire [15:0] address;
    assign ctrl = OrderStore_orderOut[31:26];
    assign readReg1 = OrderStore_orderOut[25:21];   // rs
    assign readReg2 = OrderStore_orderOut[20:16];   // rt
    assign writeReg = OrderStore_orderOut[15:11];   // rd
    assign funcCode = OrderStore_orderOut[5:0];     // funct
    assign shamt = OrderStore_orderOut[10:6];       // shamt
    assign address = OrderStore_orderOut[15:0];     // addr

    // Control part
    wire ctl_RegDst,ctl_Branch,ctl_MemRead,ctl_MemtoReg,ctl_MemWrite,ctl_ALUSrc,ctl_RegWrite;
    //wire [1:0] ctl_ALUOp;
    wire [2:0] ctl_ALUOp;
    Control control(ctrl,ctl_RegDst,
                    ctl_Branch,
                    ctl_MemRead,
                    ctl_MemtoReg,
                    ctl_ALUOp,
                    ctl_MemWrite,
                    ctl_ALUSrc,
                    ctl_RegWrite);

    // A mux before the regStore
    //reg [4:0]mux_writeReg;
    wire [4:0]mux_writeReg;
    // RegStore part
    wire [15:0]Reg_readDataOut1,Reg_readDataOut2;

    //reg [15:0]mux_whereDataFrom;//Reg_dataIn;
    wire [15:0]mux_whereDataFrom;
    wire [15:0]Reg_dataIn;
    assign Reg_dataIn = mux_whereDataFrom;
    Reg regStore(CLK4,ctl_RegWrite,readReg1,readReg2,mux_writeReg,Reg_dataIn,Reg_readDataOut1,Reg_readDataOut2);

    //ALU control part
    wire [3:0]ALU_ALUcontrol;
    ALUControl aluControl(ctl_ALUOp,funcCode,ALU_ALUcontrol);

    // ALU part
    wire ZF;
    wire [15:0]ALU_res;
    //reg [15:0]mux_aluInput;
    wire [15:0]mux_aluInput;
    wire [4:0] ADD_shamt;
    ALU alu(ALU_ALUcontrol,Reg_readDataOut1,mux_aluInput,ZF,ALU_res,ADD_shamt);
    assign aluDataOut = ALU_res; // output alu res for tb
    assign ADD_shamt = shamt;
    // dataStore part
    wire [15:0]Datastore_dataOut;
    DataStore dataStore(CLK5,ALU_res,Reg_readDataOut2,ctl_MemWrite,ctl_MemRead,Datastore_dataOut);



    reg [8:0] CLKReg;
    reg [63:0] counter;
    //parameter TIME = 48000000;
    parameter TIME = 1;
    initial
    begin
        //mux_whereDataFrom = 0;
        //mux_aluInput = 0;
        //mux_isBranch = 0;
        //mux_writeReg = 0;
        //aluDataOut = 0;
        CLKReg = 0;
        counter=0;
    end
    assign mux_isBranch = ctl_Branch & ZF ? address + PC_outPos +4 : PC_outPos+4;
    assign mux_whereDataFrom = ctl_MemtoReg ? Datastore_dataOut : ALU_res;
    assign mux_aluInput = ctl_ALUSrc ? address : Reg_readDataOut2;// maybe + shamt
    assign mux_writeReg = ctl_RegDst ? writeReg : readReg2;
    always @(*)
    begin
        //mux_writeReg = ctl_RegDst ? writeReg : readReg2;
        //mux_aluInput = ctl_ALUSrc ? address : Reg_readDataOut2 + shamt;
        //mux_whereDataFrom = ctl_MemtoReg ? Datastore_dataOut : ALU_res;
        //Reg_dataIn = mux_whereDataFrom;
        //mux_isBranch = ctl_Branch & ZF ? address + PC_outPos : PC_outPos;
    end


    always @(posedge CLK)
    begin
        counter = counter + 1;
        if(counter >= TIME)
        begin
            case(CLKReg)
                0:
                    CLKReg =1;
                1:
                    CLKReg=2;
                2:
                    CLKReg=4;
                4:
                    CLKReg=8;
                8:
                    CLKReg=24; // 关于节拍器：这个时�?�要保证reg的上升沿，进而在下降沿的时�?�可以使lw成功读入
                24:
                    CLKReg=1;
            endcase
            counter=0;
        end
    end
    assign CLK1 = CLKReg[0];
    assign CLK2 = CLKReg[1];
    assign CLK3 = CLKReg[2];
    assign CLK4 = CLKReg[3];
    assign CLK5 = CLKReg[4];
endmodule
