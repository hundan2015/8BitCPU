module DataStore (
        CLK,
        addressIn,
        dataIn,
        ctl_memWrite,   //读写入段的数据写到指定地址
        ctl_memRead,    //数据存储器读使能有效
        dataOut
    );
    input CLK;
    input [15:0] addressIn;//16位地址
    input [15:0] dataIn;
    input ctl_memWrite,ctl_memRead;
    output reg [15:0] dataOut;
    //FIXME:这里应该怎么写？？？？？？？
    //256 个 8位 reg [7:0] memory[255:0]
    integer i;
    reg [15:0]  memory[255:0]; //用整个Memory代表一块内存，但是内容怎么办？
    initial
    begin
        dataOut = 0;
        //对内存进行简单的初始化
        for (i=0;i<256;i=i+1)begin
            memory[i] = i;
        end
        memory[0]=0;
    end
    always @(posedge CLK)
    begin
        if(ctl_memRead)
        begin
            dataOut = memory[addressIn];
        end
        if(ctl_memWrite)
        begin
            memory[addressIn] = dataIn;
        end
    end

endmodule
