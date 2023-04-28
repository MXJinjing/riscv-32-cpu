`timescale 1ns / 1ps
`include "../define/reg_src_control_define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 11:58:17
// Design Name: 
// Module Name: Mux_reg_source
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


module Mux_reg_source(  // 用于选择寄存器的写入数据来源
        input wire[2:0]   reg_src_sig,        // 用于选择寄存器的写入数据来源的控制信号
        input wire[31:0]  return_addr,        // 返回地址
        input wire[31:0]  ALU_result,         // ALU的运算结果
        input wire[31:0]  load_data,          // 从存储器中读取的数据
        output wire[31:0] src                 // 输出到寄存器的数据
    );
    
    assign src = (reg_src_sig == `SRC_RETURN_ADDR) ? return_addr :          // 选择返回地址
                (reg_src_sig == `SRC_ALU) ? ALU_result:                     // 选择ALU的运算结果
                (reg_src_sig == `SRC_LOAD) ? load_data : 32'h00000000;      // 选择从存储器中读取的数据

endmodule