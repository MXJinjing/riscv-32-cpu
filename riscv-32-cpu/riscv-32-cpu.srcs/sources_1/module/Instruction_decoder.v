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

        output wire[4:0]             reg_rd_addr,         // register rd address
        output wire[4:0]             reg_rs1_addr,        // register rs1 address
        output wire[4:0]             reg_rs2_addr         // register rs2 address  
    );

    assign opcode = instruction[6:0];           
    assign funct3 = instruction[14:12];         
    assign funct7 = instruction[31:25];         

    assign reg_rd_addr = instruction[11:7];
    assign reg_rs1_addr = instruction[19:15];
    assign reg_rs2_addr = instruction[24:20];     

    // to determine the instruction type
    assign R_type = (opcode == `REG_ALU_OP ? 1'b1 : 1'b0);
    assign I_type = (opcode == `IMM_ALU_OP|| opcode == `LOAD_OP|| opcode == `SYNCH_OP|| opcode == `ENV_OP|| opcode == `CSR_OP|| opcode == `JALR_OP) ? 1'b1 : 1'b0;
    assign S_type = (opcode == `STORE_OP ? 1'b1 : 1'b0);
    assign B_type = (opcode == `BRANCH_OP ? 1'b1 : 1'b0);
    assign U_type = (opcode == `LUI_OP|| opcode == `AUIPC_OP ? 1'b1 : 1'b0);
    assign J_type = (opcode == `JAL_OP ? 1'b1 : 1);


    // Decode the instruction for each type
    
    assign I_imm = {{21{instruction[31]}},instruction[30:25],instruction[24:21],instruction[20]};
    assign S_imm = {{21{instruction[31]}},instruction[30:25],instruction[11:8],instruction[7]};
    assign B_imm = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0};
    assign U_imm = {instruction[31],instruction[30:20],instruction[19:12],12'b0};
    assign J_imm = {{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:25],instruction[24:21],1'b0};
      
    assign imm =I_type ? I_imm:
                       S_type ? S_imm:
                       B_type ? B_imm:
                       U_type ? U_imm:
                       J_type ? J_imm:
                                32'b0;
endmodule

