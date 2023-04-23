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


module Instuction_decoder(   

        input  wire[31:0]            instuction,         // input instuction

        output wire[6:0]             opcode,             // opcode
        output wire[2:0]             funct3,             // funct3
        output wire[6:0]             funct7,             // funct7

        output wire[31:0]            imm_32_bit,          // the 32 bit immediate 

        output wire[4:0]             reg_rd_addr,         // register rd address
        output wire[4:0]             reg_rs1_addr,        // register rs1 address
        output wire[4:0]             reg_rs2_addr         // register rs2 address  
    );

    assign opcode = instuction[6:0];           
    assign funct3 = instuction[14:12];         
    assign funct7 = instuction[31:25];         

    assign reg_rd_addr = instuction[11:7];
    assign reg_rs1_addr = instuction[19:15];
    assign reg_rs2_addr = instuction[24:20];     

    // to determine the instuction type
    wire R_type = (opcode == `REG_ALU_OP ? 1'b1 : 1'b0);
    wire I_type = (opcode == `REG_ALU_OP|| opcode == `LOAD_OP|| opcode == `SYNCH_OP|| opcode == `ENV_OP|| opcode == `CSR_OP|| opcode == `JALR_OP) ? 1'b1 : 1'b0;
    wire S_type = (opcode == `STORE_OP ? 1'b1 : 1'b0);
    wire B_type = (opcode == `BRANCH_OP ? 1'b1 : 1'b0);
    wire U_type = (opcode == `LUI_OP|| opcode == `AUIPC_OP ? 1'b1 : 1'b0);
    wire J_type = (opcode == `JAL_OP ? 1'b1 : 1);
    // decode the instuction for each type


    // Decode the instruction for each type
    assign imm_32_bit = R_type ? 32'b0 :
                       I_type ? {{20{instuction[31]}}, instuction[31:20]} :
                       S_type ? {{20{instuction[31]}}, instuction[31:25], instuction[11:7], 2'b0} :
                       B_type ? {{19{instuction[31]}}, instuction[31], instuction[7], instuction[30:25], instuction[11:8], 1'b0} :
                       U_type ? {instuction[31:12], 12'b0} :
                       J_type ? {{11{instuction[31]}}, instuction[31], instuction[19:12], instuction[20], instuction[30:21], 1'b0} :
                                32'b0;
endmodule

