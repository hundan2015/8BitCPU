# 说明
## funcCode
add 100000
sub 100010
and 100100
or  100101
sll 000000
srl 000010
#sar 000011 //原版MIPS没有SAR
slt 101010//less to 1
beq
lw
sw
## 关于可行的扩展：ALUOp扩位
ALUOp主要是控制I，R还有其它形式的指令。但是现有的ALUOp为两位
如果希望能够在Opcode中获得立即数的话，在不改变大结构的情况下只能更改ALUOp为3位。
正好能支持4个I指令：addi，slti，ori，andi。
这是天意吗？
## I指令Opcode
addi	I	8	2	1	100	addi $1, $2, 100
//addiu	I	9	2	1	100	addiu $1, $2, 100
andi	I	12	2	1	100	andi $1, $2, 100
ori	I	13	2	1	100	ori $1, $2, 100
slti	I	10	2	1	100	slti $1, $2, 100
//sltiu	I	11	2	1	100	sltiu $1, $2, 100