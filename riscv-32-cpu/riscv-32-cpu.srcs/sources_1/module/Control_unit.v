`timescale 1ns / 1ps
`include "../define/rv32i_op_define.vh"
`include "../define/pc_control_define.vh"
`include "../define/alu_control_define.vh"
`include "../define/alu_src_control_define.vh"
`include "../define/reg_src_control_define.vh"
`include "../define/lenth_control_define.vh"
`include "../define/ram_control_define.vh"
`include "../define/reg_control_define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 12:43:47
// Design Name: 
// Module Name: Control_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Control_unit(
        input clk,
        input wire[6:0]      opcode,
        input wire[2:0]      funct3,
        input wire[6:0]      funct7,

        output reg[3:0]     PC_control_sig,
        output reg[4:0]     ALU_control_sig,
        output reg          reg_write_sig,
        output reg          blk_mem_we_sig,
        output reg[2:0]      ALU_src1_sig,
        output reg[2:0]      ALU_src2_sig,
        output reg[2:0]      reg_src_sig
    );

    wire[3:0] _PC_control_sig;
    wire[4:0] _ALU_control_sig;
    wire _reg_write_sig;
    wire _blk_mem_we_sig;
    wire[2:0] _ALU_src1_sig;
    wire[2:0] _ALU_src2_sig;
    wire[2:0] _reg_src_sig;
    
    assign _PC_control_sig = (opcode == `BRANCH_OP) ? `PC_CONTROL_BRANCH :
                            (opcode == `JAL_OP) ? `PC_CONTROL_JAL :
                            (opcode == `JALR_OP) ? `PC_CONTROL_JALR : `PC_NEXT;

    assign _ALU_src1_sig = (opcode == `AUIPC_OP) ? `SRC_REG_PC :
                            (opcode == `JAL_OP) ? `SRC_REG_PC :
                            (opcode == `JALR_OP) ? `SRC_REG_PC :
                            (opcode == `LUI_OP) ? `SRC_ZERO : 
                            (opcode == `LOAD_OP) ? `SRC_REG_RS :
                            (opcode == `STORE_OP) ? `SRC_REG_RS : 
                            (opcode == `IMM_ALU_OP) ? `SRC_REG_RS : 
                            (opcode == `REG_ALU_OP) ? `SRC_REG_RS : 
                            (opcode == `BRANCH_OP) ? `SRC_REG_RS :`SRC_ZERO;

    assign _ALU_src2_sig = (opcode == `IMM_ALU_OP) ? `SRC_IMM : 
                            (opcode == `LOAD_OP) ? `SRC_IMM :
                            (opcode == `STORE_OP) ? `SRC_IMM :
                            (opcode == `JAL_OP) ? `SRC_IMM :
                            (opcode == `JALR_OP) ? `SRC_IMM : 
                            (opcode == `AUIPC_OP) ? `SRC_IMM :
                            (opcode == `LUI_OP) ? `SRC_IMM : 
                            (opcode == `REG_ALU_OP) ? `SRC_REG_RS :
                            (opcode == `BRANCH_OP) ? `SRC_REG_RS :`SRC_ZERO;


    assign _reg_src_sig = (opcode == `JALR_OP) ? `SRC_RETURN_ADDR : 
                            (opcode == `JAL_OP) ? `SRC_RETURN_ADDR : 
                            (opcode == `LOAD_OP) ? `SRC_ALU : 
                            (opcode == `STORE_OP) ? `SRC_LOAD :
                            (opcode == `IMM_ALU_OP) ? `SRC_ALU :
                            (opcode == `REG_ALU_OP) ? `SRC_ALU :`SRC_ZERO; 


    assign _reg_write_sig = (opcode == `LUI_OP) ? `REG_WRITE_ENABLE :
                            (opcode == `AUIPC_OP) ? `REG_WRITE_ENABLE :
                            (opcode == `JAL_OP) ? `REG_WRITE_ENABLE :
                            (opcode == `JALR_OP) ? `REG_WRITE_ENABLE :
                            (opcode == `LOAD_OP) ? `REG_WRITE_ENABLE :
                            (opcode == `IMM_ALU_OP) ? `REG_WRITE_ENABLE :
                            (opcode == `REG_ALU_OP) ? `REG_WRITE_ENABLE :`REG_WRITE_DISABLE;
    
    assign _blk_mem_we_sig = (opcode == `STORE_OP) ? `RAM_WRITE_ENABLE : `RAM_WRITE_DISABLE;


    assign _ALU_control_sig = (opcode == `REG_ALU_OP)?
                            (funct3 == `ADD_F3 && funct7 ==  0     )?`ALU_ADD :
                            (funct3 == `ADD_F3 && funct7 == `SUB_F7)?`ALU_SUB :
                            (funct3 == `AND_F3)?`ALU_AND :
                            (funct3 == `OR_F3)?`ALU_OR :
                            (funct3 == `XOR_F3)?`ALU_XOR :
                            (funct3 == `SLT_F3)?`ALU_SLT :
                            (funct3 == `SLTU_F3)?`ALU_SLTU :
                            (funct3 == `SLL_F3)?`ALU_SLL :
                            (funct3 == `SR_F3 && funct7 == `SRL_F7 )?`ALU_SRL :
                            (funct3 == `SR_F3 && funct7 == `SRA_F7 )?`ALU_SRA :
                        
                            0:

                            (opcode == `IMM_ALU_OP)?
                            (funct3 == `ADD_F3 )?`ALU_ADD :
                            (funct3 == `AND_F3)?`ALU_AND :
                            (funct3 == `OR_F3)?`ALU_OR :
                            (funct3 == `XOR_F3)?`ALU_XOR :
                            (funct3 == `SLT_F3)?`ALU_SLT :
                            (funct3 == `SLTU_F3)?`ALU_SLTU :
                            (funct3 == `SLL_F3)?`ALU_SLL :
                            (funct3 == `SR_F3 && funct7 == `SRL_F7 )?`ALU_SRL :
                            (funct3 == `SR_F3 && funct7 == `SRA_F7 )?`ALU_SRA :
                            0:

                            (opcode == `LUI_OP)?`ALU_ADD : 

                            (opcode == `AUIPC_OP)?`ALU_ADD :

                            (opcode == `LOAD_OP)?`ALU_ADD :

                            (opcode == `STORE_OP)?`ALU_ADD :

                            (opcode == `BRANCH_OP)?
                            (funct3 == `BEQ_F3)?`ALU_BEQ :
                            (funct3 == `BNE_F3)?`ALU_BNE :
                            (funct3 == `BLT_F3)?`ALU_BLT :
                            (funct3 == `BGE_F3)?`ALU_BGE :
                            (funct3 == `BLTU_F3)?`ALU_BLTU :
                            (funct3 == `BGEU_F3)?`ALU_BGEU :
                            0:

                            (opcode == `JAL_OP)?`ALU_ADD :
                            
                            (opcode == `JALR_OP)?`ALU_ADD : 0;

    always @(opcode or funct3 or funct7) begin
        PC_control_sig = _PC_control_sig;
        ALU_control_sig = _ALU_control_sig;
        reg_write_sig = _reg_write_sig;
        blk_mem_we_sig = _blk_mem_we_sig;
        ALU_src1_sig = _ALU_src1_sig;
        ALU_src2_sig = _ALU_src2_sig;
        reg_src_sig = _reg_src_sig;
    end

    initial begin   //set all control signal to zero
        PC_control_sig = 0;
        ALU_control_sig = 0;
        reg_write_sig = 0;
        blk_mem_we_sig = 0;
        ALU_src1_sig = 0;
        ALU_src2_sig = 0;
        reg_src_sig = 0;
    end
        

       
endmodule
