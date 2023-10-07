`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/08/29 15:15:41
// Design Name:
// Module Name: ALUControl
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


module ALUControl(
        ALUOp,FuncCode,ALUCtl
    );
    input [2:0] ALUOp;
    input [5:0] FuncCode;
    output reg [3:0] ALUCtl;
    initial
    begin
        ALUCtl =0;
    end
    always @(*)
    begin
        case(ALUOp)
            2'b00:
                ALUCtl <= 4'b0010;
            2'b01: //beq
                ALUCtl <= 4'b0110;
            2'b10:
            begin
                case (FuncCode)
                    6'b000000:
                        ALUCtl <= 4'b0100; //SLL
                    6'b000010:
                        ALUCtl <= 4'b0101; //SRL
                    6'b000011:
                        ALUCtl <= 5'b0011; //SAR
                    6'b100000: // add
                        ALUCtl <= 4'b0010;
                    6'b100010: // sub
                        ALUCtl <= 4'b0110;
                    6'b100100: // and
                        ALUCtl <= 4'b0000;
                    6'b100101: // or
                        ALUCtl <= 4'b0001;
                    6'b101010: // less to 1
                        ALUCtl <= 4'b0111;
                    default:
                        ALUCtl<=0;
                endcase
            end
            3'b100: //addi
                ALUCtl <= 4'b0010;
            3'b101: //slti
                ALUCtl <= 4'b0111;
            3'b110: //andi
                ALUCtl <= 4'b0000;
            3'b111: //ori
                ALUCtl <= 4'b0001;
        endcase
    end
endmodule
