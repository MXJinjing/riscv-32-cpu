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

        input  wire[31:0]            instruction,        // 输入的指令
        output wire[6:0]             opcode,             // 指令的opcode
        output wire[2:0]             funct3,             // 指令的funct3
        output wire[6:0]             funct7,             // 指令的funct7

        output wire[31:0]            imm,                // 立即数（32位）

        output wire[4:0]             reg_rd_addr,         // 寄存器rd的地址
        output wire[4:0]             reg_rs1_addr,        // 寄存器rs1的地址
        output wire[4:0]             reg_rs2_addr         // 寄存器rs2的地址 
    );


    // 判断指令类型
    assign R_type = (opcode == `REG_ALU_OP);
    assign I_type = (opcode == `IMM_ALU_OP|| opcode == `LOAD_OP|| opcode == `SYNCH_OP|| opcode == `ENV_OP|| opcode == `CSR_OP|| opcode == `JALR_OP);
    assign S_type = (opcode == `STORE_OP );
    assign B_type = (opcode == `BRANCH_OP);
    assign U_type = (opcode == `LUI_OP || opcode == `AUIPC_OP );
    assign J_type = (opcode == `JAL_OP);

    // 生成opcode、funct3、funct7、rd、rs1、rs2
    assign opcode = instruction[6:0];           
    assign funct3 = (R_type || I_type || S_type || B_type) ? instruction[14:12]: 3'b0;       // R、I、S、B类型指令都有funct3
    assign funct7 = R_type ? instruction[31:25]: 7'b0;                                       // 只有R类型指令有funct7
    assign reg_rd_addr = (R_type || I_type || U_type || J_type) ? instruction[11:7]: 5'b0;   // R、I、U、J类型指令都有rd
    assign reg_rs1_addr = (R_type || I_type || S_type || B_type) ? instruction[19:15]: 5'b0; // R、I、S、B类型指令都有rs1
    assign reg_rs2_addr = (R_type || S_type || B_type) ? instruction[24:20]: 5'b0;           // R、S、B类型指令都有rs2

    wire[31:0] I_imm;   // I型指令的立即数
    wire[31:0] S_imm;   // S型指令的立即数
    wire[31:0] B_imm;   // B型指令的立即数
    wire[31:0] U_imm;   // U型指令的立即数
    wire[31:0] J_imm;   // J型指令的立即数
    

    // 立即数生成器
    // 同时进行符号拓展，规则：高位以符号位填充，低位补0
    assign I_imm = {{21{instruction[31]}},instruction[30:25],instruction[24:21],instruction[20]};
    assign S_imm = {{21{instruction[31]}},instruction[30:25],instruction[11:8],instruction[7]};
    assign B_imm = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0};
    assign U_imm = {instruction[31],instruction[30:20],instruction[19:12],12'b0};
    assign J_imm = {{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:25],instruction[24:21],1'b0};
      
    // 选择立即数
    assign imm = I_type ? I_imm:
                S_type ? S_imm:
                B_type ? B_imm:
                U_type ? U_imm:
                J_type ? J_imm:
                32'b0;


endmodule

