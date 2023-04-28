`timescale 1ns / 1ps
`include "../define/alu_control_define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 19:15:54
// Design Name: 
// Module Name: ALU_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Desrciption: arithmetic and logic unit, which is the core of the CPU
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////_data////////


module Arithmetic_logic_unit(
        input wire[4:0]     ALU_control_sig,   // 控制信号

        input wire[31:0]    src_1_data,        // ALU的来源数据1（src_1）
        input wire[31:0]    src_2_data,        // ALU的来源数据2（src_2）

        output wire[31:0]    ALU_result        // ALU的运算结果
    );

    wire equal;                 // 运算结果是否相等
    wire signed_less_than;      // 运算结果是否有符号小于
    wire unsigned_less_than;    // 运算结果是否无符号小于

    // 将要多次进行运算的模块取出，可以将其定义为一个子模块
    assign equal = (src_1_data == src_2_data) ? 1'b1 : 1'b0;
    assign signed_less_than = ($signed(src_1_data) < $signed(src_2_data)) ? 1'b1 : 1'b0;
    assign unsigned_less_than = ($unsigned(src_1_data) < $unsigned(src_2_data)) ? 1'b1 : 1'b0;

    // 选择计算类型，运行ALU的计算，并将结果输出
    assign ALU_result = (ALU_control_sig == `ALU_ADD)? src_1_data + src_2_data :            // 加法运算
                    (ALU_control_sig == `ALU_SUB)? src_1_data - src_2_data :                // 减法运算
                    (ALU_control_sig == `ALU_AND)? src_1_data & src_2_data :                // 按位与运算
                    (ALU_control_sig == `ALU_OR)? src_1_data | src_2_data :                 // 按位或运算
                    (ALU_control_sig == `ALU_XOR)? src_1_data ^ src_2_data :                // 按位异或运算
                    (ALU_control_sig == `ALU_NOR)? ~(src_1_data | src_2_data) :             // 按位或非运算
                    (ALU_control_sig == `ALU_SLT)? (signed_less_than)? 32'b1 : 32'b0 :      // 有符号小于运算
                    (ALU_control_sig == `ALU_SLTU)? (unsigned_less_than)? 32'b1 : 32'b0 :   // 无符号小于运算
                    (ALU_control_sig == `ALU_SLL)? src_1_data << src_2_data[4:0] :          // 逻辑左移运算
                    (ALU_control_sig == `ALU_SRL)? src_1_data >> src_2_data[4:0] :          // 逻辑右移运算
                    (ALU_control_sig == `ALU_SRA)? src_1_data >>> src_2_data[4:0] :         // 算术右移运算
                    (ALU_control_sig == `ALU_BEQ)? (equal)? 32'b1 : 32'b0 :                 // 相等运算
                    (ALU_control_sig == `ALU_BNE)? (~equal)? 32'b1 : 32'b0 :                // 不相等运算
                    (ALU_control_sig == `ALU_BLT)? (signed_less_than)? 32'b1 : 32'b0 :      // 有符号小于跳转信号
                    (ALU_control_sig == `ALU_BGE)? (~signed_less_than)? 32'b1 : 32'b0 :     // 有符号大于等于跳转信号
                    (ALU_control_sig == `ALU_BLTU)? (unsigned_less_than)? 32'b1 : 1'b0 :    // 无符号小于跳转信号
                    (ALU_control_sig == `ALU_BGEU)? (~unsigned_less_than)? 32'b1 : 1'b0 :   // 无符号大于等于跳转信号
                    32'hffffffff;       // 默认输出全1
endmodule
