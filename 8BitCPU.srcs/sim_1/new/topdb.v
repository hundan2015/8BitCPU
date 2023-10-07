`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/29 11:10:54
// Design Name: 
// Module Name: topdb
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


module topdb(

    );
    reg CLK;
    wire [15:0]dataOut;
    wire [7:0]segments;
    wire [4:0]pos;
    TopOut topout(CLK,segments,pos);
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
