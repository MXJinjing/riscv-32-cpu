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
        input wire[4:0]     ALU_control_sig,   // �����ź�

        input wire[31:0]    src_1_data,        // ALU����Դ����1��src_1��
        input wire[31:0]    src_2_data,        // ALU����Դ����2��src_2��

        output wire[31:0]    ALU_result        // ALU��������
    );

    wire equal;                 // �������Ƿ����
    wire signed_less_than;      // �������Ƿ��з���С��
    wire unsigned_less_than;    // �������Ƿ��޷���С��

    // ��Ҫ��ν��������ģ��ȡ�������Խ��䶨��Ϊһ����ģ��
    assign equal = (src_1_data == src_2_data) ? 1'b1 : 1'b0;
    assign signed_less_than = ($signed(src_1_data) < $signed(src_2_data)) ? 1'b1 : 1'b0;
    assign unsigned_less_than = ($unsigned(src_1_data) < $unsigned(src_2_data)) ? 1'b1 : 1'b0;

    // ѡ��������ͣ�����ALU�ļ��㣬����������
    assign ALU_result = (ALU_control_sig == `ALU_ADD)? src_1_data + src_2_data :            // �ӷ�����
                    (ALU_control_sig == `ALU_SUB)? src_1_data - src_2_data :                // ��������
                    (ALU_control_sig == `ALU_AND)? src_1_data & src_2_data :                // ��λ������
                    (ALU_control_sig == `ALU_OR)? src_1_data | src_2_data :                 // ��λ������
                    (ALU_control_sig == `ALU_XOR)? src_1_data ^ src_2_data :                // ��λ�������
                    (ALU_control_sig == `ALU_NOR)? ~(src_1_data | src_2_data) :             // ��λ�������
                    (ALU_control_sig == `ALU_SLT)? (signed_less_than)? 32'b1 : 32'b0 :      // �з���С������
                    (ALU_control_sig == `ALU_SLTU)? (unsigned_less_than)? 32'b1 : 32'b0 :   // �޷���С������
                    (ALU_control_sig == `ALU_SLL)? src_1_data << src_2_data[4:0] :          // �߼���������
                    (ALU_control_sig == `ALU_SRL)? src_1_data >> src_2_data[4:0] :          // �߼���������
                    (ALU_control_sig == `ALU_SRA)? src_1_data >>> src_2_data[4:0] :         // ������������
                    (ALU_control_sig == `ALU_BEQ)? (equal)? 32'b1 : 32'b0 :                 // �������
                    (ALU_control_sig == `ALU_BNE)? (~equal)? 32'b1 : 32'b0 :                // ���������
                    (ALU_control_sig == `ALU_BLT)? (signed_less_than)? 32'b1 : 32'b0 :      // �з���С����ת�ź�
                    (ALU_control_sig == `ALU_BGE)? (~signed_less_than)? 32'b1 : 32'b0 :     // �з��Ŵ��ڵ�����ת�ź�
                    (ALU_control_sig == `ALU_BLTU)? (unsigned_less_than)? 32'b1 : 1'b0 :    // �޷���С����ת�ź�
                    (ALU_control_sig == `ALU_BGEU)? (~unsigned_less_than)? 32'b1 : 1'b0 :   // �޷��Ŵ��ڵ�����ת�ź�
                    32'hffffffff;       // Ĭ�����ȫ1
endmodule
