`timescale 1ns / 1ps
`include "../define/alu_src_control_define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 11:58:17
// Design Name: 
// Module Name: Mux_alu_source
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: to pick the source of the alu, whether is from the immediate or the register
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux_alu_source1(     // 用于选择ALU的数据来源
        input wire[2:0]   alu_src_control_sig,       // 用于选择ALU的数据来源的控制信号
        input wire[31:0]  reg_data,                  // 寄存器的数据
        input wire[31:0]  pc,                        // 程序计数器的数据
        input wire[31:0]  imm,                       // 立即数
        output wire[31:0] src                        // 输出到ALU的数据
    );
    
    // 选择ALU的数据来源
    assign src = (alu_src_control_sig == `SRC_REG_RS) ? reg_data:
                (alu_src_control_sig == `SRC_REG_PC) ? pc - 4'b0100: // 由于指令计数器的值是指向下一条指令的地址，所以这里需要减去4
                (alu_src_control_sig == `SRC_IMM) ? imm : 32'h00000000;

endmodule

// 尽管这两个模块的功能是一样的，但是由于在CPU中使用了两个模块，在Debug的时候会比较方便
// 并且，在展示CPU结构图的时候，也可以更加清晰的表达CPU的结构

module Mux_alu_source2(
        input wire[2:0]   alu_src_control_sig,
        input wire[31:0]  reg_data,
        input wire[31:0]  pc,   
        input wire[31:0]  imm,
        output wire[31:0] src
    );
    
    // 选择ALU的数据来源
    assign src = (alu_src_control_sig == `SRC_REG_RS) ? reg_data:
                (alu_src_control_sig == `SRC_REG_PC) ? pc - 4'b0100:
                (alu_src_control_sig == `SRC_IMM) ? imm : 32'h00000000;

endmodule