`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 23:00:01
// Design Name: 
// Module Name: Instruction_memory_tb
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


module Instruction_memory_tb(
    );
    reg reset;
    reg clk;

    parameter period = 1;
    parameter hperiod =0.5;
    parameter times =10;

    wire[31:0] pc;
    wire[31:0] instruction;
    wire[6:0] opcode;
    wire[2:0] funct3;
    wire[6:0] funct7;
    wire[31:0] imm;
    wire[4:0] reg_rs1_addr;
    wire[4:0] reg_rs2_addr; 
    wire[4:0] reg_rd_addr;
    reg[31:0] reg_rs1_data;
    reg[31:0] reg_rs2_data;
    wire[31:0] src_1_data;
    wire[31:0] src_2_data;
    wire[31:0] alu_result;
    wire[4:0] alu_control_sig;
    wire[2:0] alu_src1_control_sig;   
    wire[2:0] alu_src2_control_sig;
    
    RISCV_CPU_top uut(
        .rst(reset),
        .clk(clk),
        
        .out_pc(pc),
        .out_instruction(instruction),
        .out_opcode(opcode),
        .out_funct3(funct3),
        .out_funct7(funct7),
        .out_imm(imm),
        .out_reg_rs1_addr(reg_rs1_addr),
        .out_reg_rs2_addr(reg_rs2_addr),
        .out_reg_rd_addr(reg_rd_addr),
        .out_reg_rs1_data(reg_rs1_data),
        .out_reg_rs2_data(reg_rs2_data),
        .out_src_1_data(src_1_data),
        .out_src_2_data(src_2_data),
        .out_alu_result(alu_result),
        //.out_pc_control_sig(not_use1),
        .out_alu_control_sig(alu_control_sig),
        //.out_reg_write_sig(not_use3),
        .out_alu_src1_control_sig(alu_src1_control_sig),
        .out_alu_src2_control_sig(alu_src2_control_sig)//,
        //.out_reg_src_control_sig(not_use6),
        //.out_reg_rs1_addr(not_use7),
        //.out_reg_rs2_addr(not_use8),
        //.out_reg_rd_addr(not_use9),
        //.out_return_addr(not_use10),
        //.out_reg_rd_data(not_use11),
        //.out_write_data(not_use12),
        //.out_load_data(not_use13),
        //.out_save_data(not_use14)
        );
    initial begin
        #10
        clk <= 0;
        reset <= 0;
    end
    always #hperiod clk = !clk;
    endmodule
