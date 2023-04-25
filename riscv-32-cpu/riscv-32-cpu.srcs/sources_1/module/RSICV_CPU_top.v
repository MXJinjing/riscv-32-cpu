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
        
        
        wire[6:0]  out_opcode,
        wire[2:0]  out_funct3,
        wire[6:0]  out_funct7,
        //wire[2:0]  out_pc_control_sig,
        wire[4:0]  out_alu_control_sig,
        //wire       out_reg_write_sig,
        wire[2:0]  out_alu_src1_control_sig,
        wire[2:0]  out_alu_src2_control_sig,
        //wire[2:0]  out_reg_src_sig,
        wire[4:0]  out_reg_rd_addr,
        wire[4:0]  out_reg_rs1_addr,
        wire[4:0]  out_reg_rs2_addr,

        wire[31:0] out_pc,
        wire[31:0] out_instruction,
        wire[31:0] out_imm,
        wire[31:0] out_alu_result,
        wire[31:0] out_src_1_data,
        wire[31:0] out_src_2_data,
        wire[31:0] out_reg_rs1_data,
        wire[31:0] out_reg_rs2_data,
        //wire[31:0] out_return_addr,
        //wire[31:0] out_reg_rd_data,
        wire[31:0] out_write_data//,
        //wire[31:0] out_load_data,
        //wire[31:0] out_save_data
        

    );
    


        // CONTROL BUS
        wire[6:0]  _opcode;
        wire[2:0]  _funct3;
        wire[6:0]  _funct7;

        wire[2:0]  _pc_control_sig;
        wire[4:0]  _alu_control_sig;
        wire       _reg_write_sig;
        wire[2:0]  _alu_src1_control_sig;
        wire[2:0]  _alu_src2_control_sig;
        wire[2:0]  _reg_src_sig;

     

        // ADDRESS BUS
        wire[4:0]  _reg_rd_addr;
        wire[4:0]  _reg_rs1_addr;
        wire[4:0]  _reg_rs2_addr;
        wire[4:0]  _reg_rs1_addr;
        wire[4:0]  _reg_rs2_addr;
        wire[4:0]  _reg_rd_addr;
        wire[31:0] _pc;

        // DATA BUS
        wire[31:0] _instruction;
        wire[31:0] _imm;
        wire[31:0] _alu_result;
        wire[31:0] _src_1_data;
        wire[31:0] _src_2_data;
        wire[31:0] _reg_rs1_data;
        wire[31:0] _reg_rs2_data;
        wire[31:0] _return_addr;
        wire[31:0] _reg_rd_data;
        wire[31:0] _write_data;
        wire[31:0] _load_data;
        wire[31:0] _save_data;

        assign out_opcode = _opcode;
        assign out_funct3 = _funct3;
        assign out_funct7 = _funct7;
        assign out_pc_control_sig = _pc_control_sig;
        assign out_alu_control_sig = _alu_control_sig;
        assign out_reg_write_sig = _reg_write_sig;
        assign out_alu_src1_control_sig = _alu_src1_control_sig;
        assign out_alu_src2_control_sig = _alu_src2_control_sig;
        assign out_reg_src_sig = _reg_src_sig;
        
        assign out_reg_rd_addr = _reg_rd_addr;
        assign out_reg_rs1_addr = _reg_rs1_addr;
        assign out_reg_rs2_addr = _reg_rs2_addr;
        assign out_reg_rs1_addr = _reg_rs1_addr;
        assign out_reg_rs2_addr = _reg_rs2_addr;
        assign out_reg_rd_addr = _reg_rd_addr;
        assign out_pc = _pc;

        assign out_instruction = _instruction;
        assign out_imm = _imm;
        assign out_alu_result = _alu_result;
        assign out_src_1_data = _src_1_data;
        assign out_src_2_data = _src_2_data;
        assign out_reg_rs1_data = _reg_rs1_data;
        assign out_reg_rs2_data = _reg_rs2_data;
        assign out_return_addr = _return_addr;
        assign out_reg_rd_data = _reg_rd_data;
        assign out_write_data = _write_data;
        assign out_load_data = _load_data;
        assign out_save_data = _save_data;


        
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
            .instruction(_instruction)
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

        Register_bank new_reg_instance(
            .clk(clk),                       
            .reg_write_sig(_reg_write_sig),             
            .reg_rs1_addr(_reg_rs1_addr),
            .reg_rs2_addr(_reg_rs2_addr),
            .reg_rd_addr(_reg_rd_addr), 
            .write_data(_write_data), 
            .reg_rs1_data(_reg_rs1_data),
            .reg_rs2_data(_reg_rs2_data)
        );
        
        Arithmetic_logic_unit new_alu_instance(
            .clk(clk),
            .ALU_control_sig(_alu_control_sig),
            .src_1_data(_src_1_data),
            .src_2_data(_src_2_data),
            .ALU_result(_alu_result),
            .overflow(_overflow)
        );
        
        Mux_alu_source new_mux_alu_source1_instance(
            .alu_src_control_sig(_alu_src1_control_sig),
            .reg_data(_reg_rs1_data),
            .pc(_pc),  
            .imm(_imm),
            .src(_src_1_data)
        );

        Mux_alu_source new_mux_alu_source2_instance(
            .alu_src_control_sig(_alu_src2_control_sig),
            .reg_data(_reg_rs2_data),
            .pc(_pc),  
            .imm(_imm),
            .src(_src_2_data)
        );

        Mux_reg_source new_mux_reg_source_instance(
            .reg_src_sig(_reg_src_sig),
            .return_addr(_return_addr),
            .ALU_result(_alu_result),
            .load_data(_load_data),
            .src(_write_data)
        );

        Control_unit new_control_instance(
            .clk(clk),
            .opcode(_opcode),
            .funct3(_funct3),
            .funct7(_funct7),
            .PC_control_sig(_pc_control_sig),
            .ALU_control_sig(_alu_control_sig),
            .reg_write_sig(_reg_write_sig),
            .blk_mem_we_sig(_blk_mem_we_sig),
            .ALU_src1_sig(_alu_src1_control_sig),
            .ALU_src2_sig(_alu_src2_control_sig),
            .reg_src_sig(_reg_src_sig)
        );
        


endmodule