`timescale 1ns / 1ps
`include "../define/rv32i_op_define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/22 11:42:35
// Design Name: 
// Module Name: Instuction_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: The instruction decoder is a combinational circuit that decodes the 32 bit instruction into control signals for the datapath.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_decoder(   

        input  wire[31:0]            instruction,        // �����ָ��
        output wire[6:0]             opcode,             // ָ���opcode
        output wire[2:0]             funct3,             // ָ���funct3
        output wire[6:0]             funct7,             // ָ���funct7

        output wire[31:0]            imm,                // ��������32λ��

        output wire[4:0]             reg_rd_addr,         // �Ĵ���rd�ĵ�ַ
        output wire[4:0]             reg_rs1_addr,        // �Ĵ���rs1�ĵ�ַ
        output wire[4:0]             reg_rs2_addr         // �Ĵ���rs2�ĵ�ַ 
    );


    // �ж�ָ������
    assign R_type = (opcode == `REG_ALU_OP);
    assign I_type = (opcode == `IMM_ALU_OP|| opcode == `LOAD_OP|| opcode == `SYNCH_OP|| opcode == `ENV_OP|| opcode == `CSR_OP|| opcode == `JALR_OP);
    assign S_type = (opcode == `STORE_OP );
    assign B_type = (opcode == `BRANCH_OP);
    assign U_type = (opcode == `LUI_OP || opcode == `AUIPC_OP );
    assign J_type = (opcode == `JAL_OP);

    // ����opcode��funct3��funct7��rd��rs1��rs2
    assign opcode = instruction[6:0];           
    assign funct3 = (R_type || I_type || S_type || B_type) ? instruction[14:12]: 3'b0;       // R��I��S��B����ָ���funct3
    assign funct7 = R_type ? instruction[31:25]: 7'b0;                                       // ֻ��R����ָ����funct7
    assign reg_rd_addr = (R_type || I_type || U_type || J_type) ? instruction[11:7]: 5'b0;   // R��I��U��J����ָ���rd
    assign reg_rs1_addr = (R_type || I_type || S_type || B_type) ? instruction[19:15]: 5'b0; // R��I��S��B����ָ���rs1
    assign reg_rs2_addr = (R_type || S_type || B_type) ? instruction[24:20]: 5'b0;           // R��S��B����ָ���rs2

    wire[31:0] I_imm;   // I��ָ���������
    wire[31:0] S_imm;   // S��ָ���������
    wire[31:0] B_imm;   // B��ָ���������
    wire[31:0] U_imm;   // U��ָ���������
    wire[31:0] J_imm;   // J��ָ���������
    

    // ������������
    // ͬʱ���з�����չ�����򣺸�λ�Է���λ��䣬��λ��0
    assign I_imm = {{21{instruction[31]}},instruction[30:25],instruction[24:21],instruction[20]};
    assign S_imm = {{21{instruction[31]}},instruction[30:25],instruction[11:8],instruction[7]};
    assign B_imm = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0};
    assign U_imm = {instruction[31],instruction[30:20],instruction[19:12],12'b0};
    assign J_imm = {{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:25],instruction[24:21],1'b0};
      
    // ѡ��������
    assign imm = I_type ? I_imm:
                S_type ? S_imm:
                B_type ? B_imm:
                U_type ? U_imm:
                J_type ? J_imm:
                32'b0;


endmodule

