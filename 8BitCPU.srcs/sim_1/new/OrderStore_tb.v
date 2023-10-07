`timescale 1ns / 1ps
`include "OrderStore.v"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/09/08 20:57:45
// Design Name:
// Module Name: OrderStore_tb
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


module OrderStore_tb(
    );
    reg CLK;
    reg [15:0] addressIn;
    wire [31:0] orderOut;
    OrderStore od(CLK,addressIn,orderOut);
    integer i;
    initial
    begin
        //addressIn = 1;
        CLK=0;
        for(i=0;i<255;i=i+1)
        begin
            addressIn = i;
            CLK=0;
            #10
             CLK=1;
            #10
            CLK=0;
         end
     end
 endmodule
