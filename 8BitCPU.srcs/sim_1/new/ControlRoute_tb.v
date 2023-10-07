`timescale 1ns / 1ps
`include "ControlRouteRemake.v"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/09/09 10:00:17
// Design Name:
// Module Name: ControlRoute_tb
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


module ControlRoute_tb(
    );
    reg CLK;
    wire [15:0]dataOut;
    ControlRouteRemake ctlR(CLK,dataOut);
    integer i;
    initial
    begin
        CLK =0;
        for(i = 0;i<1024;i=i+1)
        begin
            #10
             CLK = 1;
            #10
             CLK = 0;
        end
    end
endmodule
