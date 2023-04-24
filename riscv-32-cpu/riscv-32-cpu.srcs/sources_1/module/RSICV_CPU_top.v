`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 14:03:47
// Design Name: 
// Module Name: CPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: the top module of the cpu, connect all the modules together
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RISCV_CPU_top(
        input wire rst,
        input wire clk,
        
        output wire[31:0] data1,
        output wire[31:0] data2
    );
    
    
        wire[31:0] _pc;
        wire[31:0] _instruction;
        wire[2:0]  _PC_control_sig;
     
        assign data1 = _instruction;
        assign _PC_control_sig = 3'b000;
        assign data2 = _pc;
       
        
        Program_counter new_pc_instance(
            .clk(clk),
            .rst(rst),
            .PC_control_sig(_PC_control_sig),
            .offset(_offset),
            .reg_rs1_data(_reg_rs1_data),
            .ALU_result_1bit(_ALU_result_1bit),
            .pc(_pc),
            .reg_rd_addr(_reg_rd_addr)
        );
        
        Instruction_memory new_im_instance(
            .clk(clk),
            .PC(_pc),
            .Dout(_instruction)
        );
        
        Instruction_decoder new_id_intance(
            .instruction(_instruction),
            .opcode(_opcode),
            .funct3(_funct3),
            .funct7(_funct7),
            .imm_32_bit(_imm_32_bit),
            .reg_rd_addr(_reg_rd_addr),
            .reg_rs1_addr(_reg_rs1_addr),
            .reg_rs2_addr(_reg_rs2_addr)
        );
        
        Arithmetic_logic_unit new_alu_instance(
            .clk(clk),
            .ALU_control_sig(_ALU_control_sig),
            .src_1_data(_src_1_data),
            .src_2_data(_src_2_data),
            .ALU_result(_ALU_result),
            .overflow(_overflow)
        );
        
        Register_bank new_regbank_instance(
            .clk(clk),
            .reg_write_sig(_reg_write_sig),
            .reg_1_addr(_reg_1_addr),
            .reg_2_addr(_reg_2_addr),
            .write_data(_write_data),
            .reg_1_data(_reg_1_data),
            .reg_2_data(_reg_2_data)
        );
        
endmodule