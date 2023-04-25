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
    
        assign data1 = _instruction;
        assign data2 = _pc;


        // CONTROL BUS
        wire[2:0]  _pc_control_sig;
        wire[5:0]  _alu_control_sig;
        wire       reg_write_sig;
        wire[2:0]  _alu_src1_control_sig;
        wire[2:0]  _alu_src2_control_sig;
     

        // ADDRESS BUS
        wire[4:0]  _reg_rd_addr;
        wire[4:0]  _reg_rs1_addr;
        wire[4:0]  _reg_rs2_addr;
        wire[4:0]  _reg_r1_addr;
        wire[4:0]  _reg_r2_addr;
        wire[4:0]  _reg_w1_addr;
        wire[31:0] _pc;

        // DATA BUS
        wire[31:0] _instruction;
        wire[31:0] _imm;
        wire[31:0] _alu_result;
        wire[31:0] _src_1_data;
        wire[31:0] _src_2_data;
        wire[31:0] _reg_r1_data;
        wire[31:0] _reg_r2_data;
        wire[31:0] _return_addr;
        wire[31:0] _reg_w1_data;
        wire[31:0] _write_data;
        wire[31:0] _load_data;
        wire[31:0] _save_data;

        
        Program_counter new_pc_instance(
            .clk(clk),
            .rst(rst),
            .offset(_imm),
            .PC_control_sig(_pc_control_sig),

            .ALU_result(_alu_result),
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
            .imm(_imm),
            .reg_rd_addr(_reg_rd_addr),
            .reg_rs1_addr(_reg_rs1_addr),
            .reg_rs2_addr(_reg_rs2_addr)
        );
        
        Arithmetic_logic_unit new_alu_instance(
            .clk(clk),
            .ALU_control_sig(_alu_control_sig),
            .src_1_data(_src_1_data),
            .src_2_data(_src_2_data),
            .ALU_result(_alu_result),
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

        Mux_alu_source new_mux_alu_source1_instance(
            .alu_src_control_sig(_alu_src1_control_sig),
            .reg_data(_reg_r1_data),
            .pc(_pc),  
            .imm(_imm),
            .src(_src_1_data)
        );

        Mux_alu_source new_mux_alu_source2_instance(
            .alu_src_control_sig(_alu_src2_control_sig),
            .reg_data(_reg_r2_data),
            .pc(_pc),  
            .imm(_imm),
            .src(_src_2_data)
        );

        Mux_reg_source new_mux_reg_source_instance(
            .reg_src_control_sig(_reg_src_control_sig),
            .return_addr(_return_addr),
            .ALU_result(_alu_result),
            .load_data(_load_data)
        );

        Control_unit new_control_instance(
            .opcode(_opcode),
            .funct3(_funct3),
            .funct7(_funct7),
            .PC_control_sig(_pc_control_sig),
            .ALU_control_sig(_alu_control_sig),
            .reg_write_sig(_reg_write_sig),
            .blk_mem_we_sig(_blk_mem_we_sig),
            .ALU_src1_sig(_alu_src1_control_sig),
            .ALU_src2_sig(_alu_src2_control_sig)
        );
        


endmodule