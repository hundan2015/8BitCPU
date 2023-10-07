`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/09/09 14:35:02
// Design Name:
// Module Name: CLKControlAno
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


module CLKControlAno(
        CLK,CLK1,CLK2,CLK3,CLK4,CLK5
    );
    input CLK;
    output CLK1,CLK2,CLK3,CLK4,CLK5;
    //parameter CLOCKCOUNT = 48000000;
    parameter CLOCKCOUNT = 1;
    reg [63:0] counter,state;
    reg [63:0] goodBoy;
    reg CLKinside;

    assign CLK1 = state[0];
    assign CLK2 = state[1];
    assign CLK3 = state[2];
    assign CLK4 = state[3];
    assign CLK5 = state[4];

    //state 1�?般是用来占位的�?�用�?个空的状态来管理。进而避免开机时的时钟错乱�??
    initial
    begin
        goodBoy=0;
        counter = 0;
        CLKinside = 0;
        state = 1;
    end

    always @(posedge CLK)
    begin
        if(counter>=CLOCKCOUNT)
        begin
            counter <= 0;
            CLKinside = ~CLKinside;
        end
        else
        begin
            counter <= counter + 1;
        end
    end
    always @(posedge CLKinside)
    begin
        
        case (goodBoy) //goodboy是未知的！？？？
            0:
                state = 1;
            1:
                state =2;
            2:
                state=4;
            3:
                state=8;
            4:
                state=16;
            default:
                state=0;
        endcase
        goodBoy =goodBoy+1;
        if(goodBoy>4)
        begin
            goodBoy = 0;
        end
    end
endmodule
