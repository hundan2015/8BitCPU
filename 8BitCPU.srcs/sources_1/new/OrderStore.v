//R
//[31:26] [25:21] [20:16] [15:11] [10:6] [5:0]
//   0      rs      rt      rd    shamt  funct
//存取
//[31:26] [25:21] [20:16] [15:0]
//35or43    rs      rt     addr
//分支
//[31:26] [25:21] [20:16] [15:0]
//   4      rs      rt     addr
module OrderStore (
        CLK,
        addressIn,
        orderOut
    );
    input CLK;
    input [15:0] addressIn;
    output [31:0] orderOut;
    reg [31:0] orderOut;
    reg [31:0] orderMemory[255:0];
    integer i;
    initial
    begin
        orderOut =0;
        /* for(i=0;i<255;i=i+1)
        begin
            orderMemory[i]=i;
        end */
        //orderMemory[1]=1;
        //R add s2 s0 s1
        //000000 00000 00001 00010 00000 100000 PASS
        //Store sw s0 s2(0)
        //101011 00010 00000 00000 00000 000000 PASS
        //R sll s0 s2 2 ??
        //000000 00000 00010 00000 00010 000000 PASS
        //R srl s0 s2 2
        //000000 00000 00010 00000 00010 000010 PASS
        //R sar s0 s2 2 FALLED UNSUPPORT
        //000000 00000 00010 00000 00010 000011 PASS
        //I addi s2 s0 2
        //001000 00000 00010 0000000000000010; PASS
        //I andi s2 s0 2
        //001100 00000 00010 0000000000000010;
        //I ori s2 s0 2
        //001101 00000 00010 0000000000000010;
        //I slti s2 s0 2
        //001010 00000 00010 0000000000000010;
        //R sub s2 s0 s1
        //000000 00000 00001 00010 00000 100010
        //R and s2 s0 s1
        //000000 00000 00001 00010 00000 100100
        //R or s2 s0 s1
        //000000 00000 00001 00010 00000 100101
        //Load lw s0 s2(0)
        //100011 00010 00000 0000000000000000
        //beq s0 s0
        //000100 00000 00000 1111111111111100; PASS
        orderMemory[0] = 32'b00000000000000010001000000100000;
        orderMemory[1] = 32'b00000000000000010001000000100000;// add
        orderMemory[2] = 32'b10101100010000000000000000000000;// sw
        orderMemory[3] = 32'b00000000000000100000000010000000;// sll 
        orderMemory[4] = 32'b00000000000000100000000010000010;// srl
        orderMemory[5] = 32'b00100000000000100000000000000010;// addi
        orderMemory[6] = 32'b00110000000000100000000000000010;// andi
        orderMemory[7] = 32'b00110100000000100000000000000010;// ori
        orderMemory[8] = 32'b00101000000000100000000000000010;// slti
        orderMemory[9] = 32'b00000000000000010001000000100010;// sub
        orderMemory[10]= 32'b00000000000000010001000000100100;// and
        orderMemory[11]= 32'b00000000000000010001000000100101;// or
        orderMemory[12]= 32'b10001100010000000000000000000000;//lw
        orderMemory[13]= 32'b00010000000000001111111111111100;// beq
        
       /*  orderMemory[1] = 32'b00000000000000010001000000100000;
        orderMemory[2] = 32'b00000000001000100001100000100000;
        orderMemory[3] = 32'b00000000010000110010000000100000; */
    end
    always @(posedge CLK)
    begin
        orderOut = orderMemory[addressIn>>2];
    end
endmodule
