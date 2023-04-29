`timescale 1ns / 1ps
`include "../define/im_wait_define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 14:42:10
// Design Name: 
// Module Name: Instruction Memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: The instruction memory of CPU
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_memory (
        input wire rst,
        input wire clk,
        input wire [31:0] pc,               // 程序计数器（地址）
        input wire im_wait_sig,             // 指令内存等待信号
        output wire [31:0] instruction      // 指令
    );
    
    reg [31:0] instruction_reg;             // 指令寄存器
    
    Frequency_multiplier_2x freq_mul (     // 时钟频率乘2模块
        .clk(clk),
        .rst(1'b1),        // rst信号为1时，输出时钟信号为2倍频率
        .clk_out(clk_2x)
    );
    
    wire[31:0] _douta;

    blk_mem_gen_0 uut(  // 内存模块
        .clka(~clk_2x),
        .addra(pc[12:2]),   // 内存宽度为32，所以地址右移2位，因此只能支持4字节对齐读取
        .douta(_douta)
        );

    // 指令寄存器的更新
    always @(posedge clk) begin
        if (!rst) begin
            instruction_reg <= 32'h00000000;
        end else begin
            instruction_reg <= _douta;
        end
    end

    always @(negedge clk) begin

    end
    
    assign instruction = (im_wait_sig == 1'b1) ? 32'h00000000 : instruction_reg;

    // 指令寄存器的初始化
    initial begin
        instruction_reg <= 32'h00000000;
    end

endmodule



