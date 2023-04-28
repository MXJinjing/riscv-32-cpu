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


module Mux_reg_source(  // ����ѡ��Ĵ�����д��������Դ
        input wire[2:0]   reg_src_sig,        // ����ѡ��Ĵ�����д��������Դ�Ŀ����ź�
        input wire[31:0]  return_addr,        // ���ص�ַ
        input wire[31:0]  ALU_result,         // ALU��������
        input wire[31:0]  load_data,          // �Ӵ洢���ж�ȡ������
        output wire[31:0] src                 // ������Ĵ���������
    );
    
    assign src = (reg_src_sig == `SRC_RETURN_ADDR) ? return_addr :          // ѡ�񷵻ص�ַ
                (reg_src_sig == `SRC_ALU) ? ALU_result:                     // ѡ��ALU��������
                (reg_src_sig == `SRC_LOAD) ? load_data : 32'h00000000;      // ѡ��Ӵ洢���ж�ȡ������

endmodule