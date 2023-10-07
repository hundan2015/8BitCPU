module PC (
        CLK,
        lastpos,
        outpos
    );
    input CLK;
    input [15:0]lastpos;
    output reg [15:0]outpos;
    initial begin
        outpos = 0;
    end
    always @(posedge CLK)
    begin
        outpos <= lastpos;// + 4;
    end
endmodule
