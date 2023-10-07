`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/08/31 08:55:38
// Design Name:
// Module Name: CLKControl
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


module CLKControl(
        CLK,CLK1,CLK2,CLK3,CLK4,CLK5
    );
    input CLK;
    output CLK1,CLK2,CLK3,CLK4,CLK5;
    //parameter CLOCKCOUNT = 48000000;
    parameter CLOCKCOUNT = 1;
    reg [31:0] counter,state;
    reg CLKinside;

    assign CLK1 = state[0];
    assign CLK2 = state[1];
    assign CLK3 = state[2];
    assign CLK4 = state[3];
    assign CLK5 = state[4];

    //state 1一般是用来占位的。用一个空的状态来管理。进而避免开机时的时钟错乱。
    initial
    begin
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
        state <= state << 1;
        if(state > 16)
        begin
            state = 1;
        end
    end
endmodule
