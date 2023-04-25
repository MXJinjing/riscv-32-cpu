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
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_decoder(   

        input  wire[31:0]            instruction,         // input instruction

        output wire[6:0]             opcode,             // opcode
        output wire[2:0]             funct3,             // funct3
        output wire[6:0]             funct7,             // funct7

        output wire[31:0]            imm,          // the 32 bit immediate 

        output reg[4:0]             reg_rd_addr,         // register rd address
        output reg[4:0]             reg_rs1_addr,        // register rs1 address
        output reg[4:0]             reg_rs2_addr         // register rs2 address  
    );


    // to determine the instruction type
    assign R_type = (opcode == `REG_ALU_OP);
    assign I_type = (opcode == `IMM_ALU_OP|| opcode == `LOAD_OP|| opcode == `SYNCH_OP|| opcode == `ENV_OP|| opcode == `CSR_OP|| opcode == `JALR_OP);
    assign S_type = (opcode == `STORE_OP );
    assign B_type = (opcode == `BRANCH_OP);
    assign U_type = (opcode == `LUI_OP || opcode == `AUIPC_OP );
    assign J_type = (opcode == `JAL_OP);
    
    wire[31:0] _reg_rs1_addr;
    wire[31:0] _reg_rs2_addr;
    wire[31:0] _reg_rd_addr;
    
    assign opcode = instruction[6:0];           
    assign funct3 = (R_type || I_type || S_type || B_type) ? instruction[14:12]: 3'b0;  // funct3 is not used in U and J type 
    assign funct7 = R_type ? instruction[31:25]: 7'b0;  // funct7 is not used in I, S, B, U and J type
    assign _reg_rd_addr = (R_type || I_type || U_type || J_type) ? instruction[11:7]: 5'b0;  // rd is not used in S and B type (STORE and BRANCH
    assign _reg_rs1_addr = (R_type || I_type || S_type || B_type) ? instruction[19:15]: 5'b0;  // rs1 is not used in U and J type (JALR)
    assign _reg_rs2_addr = (R_type || S_type || B_type) ? instruction[24:20]: 5'b0;  // rs2 is not used in I and U type

    wire[31:0] I_imm;
    wire[31:0] S_imm;
    wire[31:0] B_imm;
    wire[31:0] U_imm;
    wire[31:0] J_imm;
    

    // Decode the instruction for each type
    assign I_imm = {{21{instruction[31]}},instruction[30:25],instruction[24:21],instruction[20]};
    assign S_imm = {{21{instruction[31]}},instruction[30:25],instruction[11:8],instruction[7]};
    assign B_imm = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0};
    assign U_imm = {instruction[31],instruction[30:20],instruction[19:12],12'b0};
    assign J_imm = {{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:25],instruction[24:21],1'b0};
      
    assign imm = I_type ? I_imm:
                       S_type ? S_imm:
                       B_type ? B_imm:
                       U_type ? U_imm:
                       J_type ? J_imm:
                                32'b0;

    always @(instruction) begin
        if(instruction != 0) begin
        reg_rd_addr <= _reg_rd_addr;
        reg_rs1_addr <= _reg_rs1_addr;
        reg_rs2_addr <= _reg_rs2_addr;
        end
    end
endmodule

