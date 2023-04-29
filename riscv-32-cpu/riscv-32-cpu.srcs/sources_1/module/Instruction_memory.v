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
        input wire [31:0] pc,               // �������������ַ��
        input wire im_wait_sig,             // ָ���ڴ�ȴ��ź�
        output wire [31:0] instruction      // ָ��
    );
    
    reg [31:0] instruction_reg;             // ָ��Ĵ���
    
    Frequency_multiplier_2x freq_mul (     // ʱ��Ƶ�ʳ�2ģ��
        .clk(clk),
        .rst(1'b1),        // rst�ź�Ϊ1ʱ�����ʱ���ź�Ϊ2��Ƶ��
        .clk_out(clk_2x)
    );
    
    wire[31:0] _douta;

    blk_mem_gen_0 uut(  // �ڴ�ģ��
        .clka(~clk_2x),
        .addra(pc[12:2]),   // �ڴ���Ϊ32�����Ե�ַ����2λ�����ֻ��֧��4�ֽڶ����ȡ
        .douta(_douta)
        );

    // ָ��Ĵ����ĸ���
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

    // ָ��Ĵ����ĳ�ʼ��
    initial begin
        instruction_reg <= 32'h00000000;
    end

endmodule



