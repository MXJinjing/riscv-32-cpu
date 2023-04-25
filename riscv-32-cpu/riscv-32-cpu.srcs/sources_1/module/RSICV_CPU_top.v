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
    
    
        // CONTROL SIGNALS BUS
        wire[31:0] _pc;
        wire[31:0] _instruction;
        wire[2:0]  _PC_control_sig;
        wire[5:0]  _ALU_control_sig;
        wire       reg_write_sig;
        wire[2:0]  _alu_src1_control_sig;
        wire[2:0]  _alu_src2_control_sig;
     
        assign data1 = _instruction;
        assign data2 = _pc;
       
        
        Program_counter new_pc_instance(
            .clk(clk),
            .rst(rst),
            .PC_control_sig(_PC_control_sig),

            .ALU_result(_ALU_result),
            .pc(_pc),
            .return_addr(_return_addr)
        );
        
        Instruction_memory new_im_instance(
            .clk(clk),
            .pc(_pc),
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
            .reg_r1_addr(_reg_r1_addr),
            .reg_r2_addr(_reg_r2_addr),
            .reg_w1_addr(_reg_w1_addr),
            .write_data(_write_data),
            .reg_r1_data(_reg_r1_data),
            .reg_r2_data(_reg_r2_data)
        );

        Mux_alu_source1 new_mux_alu_source1_instance(
            .alu_src1_control_sig(_alu_src1_control_sig),
            .reg_rs1_data(_reg_rs1_data),
            .reg_pc_data(_reg_pc_data),
            .imm(_imm),
            .src1(_src1)
        );

        Mux_alu_source2 new_mux_alu_source2_instance(
            .alu_src2_control_sig(_alu_src2_control_sig),
            .reg_rs2_data(_reg_rs2_data),
            .imm(_imm),
            .src2(_src2)
        );

        Control_unit new_control_instance(
            .opcode(_opcode),
            .funct3(_funct3),
            .funct7(_funct7),
            .PC_control_sig(_PC_control_sig),
            .ALU_control_sig(_ALU_control_sig),
            .reg_write_sig(_reg_write_sig),
            .blk_mem_we_sig(_blk_mem_we_sig),
            .ALU1_source_sig(_alu_src1_control_sig),
            .ALU2_source_sig(_alu_src2_control_sig)
        );
        


endmodule