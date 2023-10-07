`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/09/29 09:13:56
// Design Name:
// Module Name: TopOut
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


module TopOut(
        CLK,segments,pos
    );
    input CLK;
    output reg[7:0]segments;
    reg [7:0]poser;
    output reg[7:0]pos;
    reg [5:0]dataNow;
    reg [31:0]shit;
    parameter REFRESHTIME = 2000;
    wire [15:0]aluDataOut;
    ControlRouteRemake cpu(CLK,aluDataOut);
    reg [5:0]pos1,pos2,pos3,pos4,pos5;
    initial begin
    pos=1;
    poser=1;
    shit=0;
    segments=8'b00000000;
    end
    
    always @(posedge CLK)
    begin
        pos1<=aluDataOut%10;
        pos2<=aluDataOut/10%10;
        pos3<=aluDataOut/100%10;
        pos4<=aluDataOut/1000%10;
        pos5<=aluDataOut/10000;
        if(poser==0) poser=1;
        shit = shit+1;
        
        if(shit>REFRESHTIME)
        begin
            poser=poser<<1;
            if(poser>16)
            begin
                poser=1;
            end
            shit=0;
        end
        
        poser=1;
        pos=~poser;
    end
    
    always @(negedge CLK)
    begin
        case (poser)
            1:
                dataNow=pos1;
            2:
                dataNow=pos2;
            4:
                dataNow=pos3;
            8:
                dataNow=pos4;
            16:
                dataNow=pos5;
            default:
                dataNow=0;
        endcase
        
        dataNow=pos1;
        case (dataNow)
            0:
                segments=8'b00111111;
            1:
                segments=8'b00000110;
            2:
                segments=8'b01011011;
            3:
                segments=8'b01001111;
            4:
                segments=8'b01100110;
            5:
                segments=8'b01101101;
            6:
                segments=8'b01111101;
            7:
                segments=8'b00000111;
            8:
                segments=8'b01111111;
            9:
                segments=8'b01101111;
            default:
                segments=8'b11111111;
        endcase
        segments=~segments;
    end
endmodule
