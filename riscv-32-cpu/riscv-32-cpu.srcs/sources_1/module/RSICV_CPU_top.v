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
        
        
        output wire[31:0]       out_pc,
        output wire[31:0]       out_instruction,
        //output wire[6:0]        out_opcode,
        //output wire[2:0]        out_funct3,
        //output wire[6:0]        out_funct7,
        //output wire[31:0]       out_imm,

        //output wire[4:0]        out_reg_rd_addr,
        //output wire[4:0]        out_reg_rs1_addr,
        //output wire[4:0]        out_reg_rs2_addr,
    
        //output wire[31:0]       out_reg_rs1_data,
        //output wire[31:0]       out_reg_rs2_data,
    
        //output wire[31:0]       out_src_1_data,
        //output wire[31:0]       out_src_2_data,
        //output wire[31:0]       out_alu_result,

        //output wire[31:0]       out_write_data,       
        //output wire[31:0]       out_return_addr,

        //output wire[2:0]        out_pc_control_sig,
        //output wire[4:0]        out_alu_control_sig,
        //output wire             out_reg_write_sig,
        //output wire[2:0]        out_alu_src1_control_sig,
        //output wire[2:0]        out_alu_src2_control_sig,
        //output wire[2:0]        out_reg_src_sig,

        //output wire             mem_clk,
        //output wire[31:0]       out_load_data,
        //output wire[31:0]       out_save_data,
        //output wire             out_mem_write_sig,
        //output wire             out_im_wait_sig,

        //output wire[31:0]   _debug_reg0_data,
        //output wire[31:0]   _debug_reg1_data,
        //output wire[31:0]   _debug_reg2_data,
        //output wire[31:0]   _debug_reg3_data,
        //output wire[31:0]   _debug_reg4_data,
        //output wire[31:0]   _debug_reg5_data,
        //output wire[31:0]   _debug_reg6_data,
        //output wire[31:0]   _debug_reg7_data,
        //output wire[31:0]   _debug_reg8_data,
        //output wire[31:0]   _debug_reg9_data,
        //output wire[31:0]   _debug_reg10_data,
        output wire[31:0]   _debug_reg11_data,
        output wire[31:0]   _debug_reg12_data,
        output wire[31:0]   _debug_reg13_data,
        output wire[31:0]   _debug_reg14_data,
        output wire[31:0]   _debug_reg15_data,
        output wire[31:0]   _debug_reg16_data,
        output wire[31:0]   _debug_reg17_data//,
        //output wire[31:0]   _debug_reg18_data,
        //output wire[31:0]   _debug_reg19_data,
        //output wire[31:0]   _debug_reg20_data,
        //output wire[31:0]   _debug_reg21_data,
        //output wire[31:0]   _debug_reg22_data,
        //output wire[31:0]   _debug_reg23_data,
        //output wire[31:0]   _debug_reg24_data,
        //output wire[31:0]   _debug_reg25_data,
        //output wire[31:0]   _debug_reg26_data,
        //output wire[31:0]   _debug_reg27_data,
        //output wire[31:0]   _debug_reg28_data,
        //output wire[31:0]   _debug_reg29_data,
        //output wire[31:0]   _debug_reg30_data,
        //output wire[31:0]   _debug_reg31_data
        
    );
    


        // 控制信号线
        wire[6:0]  _opcode;
        wire[2:0]  _funct3;
        wire[6:0]  _funct7;

        wire[2:0]  _pc_control_sig;
        wire[4:0]  _alu_control_sig;
        wire       _reg_write_sig;
        wire[2:0]  _alu_src1_control_sig;
        wire[2:0]  _alu_src2_control_sig;
        wire[2:0]  _reg_src_sig;
        wire       _mem_read_sig;
        wire       _mem_write_sig;
        wire       _load_done_sig;
        wire       _store_done_sig;
        wire       _im_wait_sig;

        // 地址传输线
        wire[4:0]  _reg_rd_addr;
        wire[4:0]  _reg_rs1_addr;
        wire[4:0]  _reg_rs2_addr;
        wire[31:0] _pc;

        // 数据传输线
        wire[31:0] _instruction;
        wire[31:0] _imm;
        wire[31:0] _alu_result;
        wire[31:0] _src_1_data;
        wire[31:0] _src_2_data;
        wire[31:0] _reg_rs1_data;
        wire[31:0] _reg_rs2_data;
        wire[31:0] _return_addr;
        wire[31:0] _write_data;
        wire[31:0] _load_data;

        // debug
        // assign out_opcode = _opcode;
        // assign out_funct3 = _funct3;
        // assign out_funct7 = _funct7;
        // assign out_pc_control_sig = _pc_control_sig;
        // assign out_alu_control_sig = _alu_control_sig;
        // assign out_reg_write_sig = _reg_write_sig;
        // assign out_alu_src1_control_sig = _alu_src1_control_sig;
        // assign out_alu_src2_control_sig = _alu_src2_control_sig;
        // assign out_reg_src_sig = _reg_src_sig;
        // assign out_mem_read_sig = _mem_read_sig;
        // assign out_mem_write_sig = _mem_write_sig;
        // 
        // 
        // assign out_reg_rd_addr = _reg_rd_addr;
        // assign out_reg_rs1_addr = _reg_rs1_addr;
        // assign out_reg_rs2_addr = _reg_rs2_addr;
        // assign out_reg_rs1_addr = _reg_rs1_addr;
        // assign out_reg_rs2_addr = _reg_rs2_addr;
        // assign out_reg_rd_addr = _reg_rd_addr;
        assign out_pc = _pc;

        assign out_instruction = _instruction;
        // assign out_imm = _imm;
        // assign out_alu_result = _alu_result;
        // assign out_src_1_data = _src_1_data;
        // assign out_src_2_data = _src_2_data;
        // assign out_reg_rs1_data = _reg_rs1_data;
        // assign out_reg_rs2_data = _reg_rs2_data;
        // assign out_return_addr = _return_addr;
        // assign out_write_data = _write_data;
        // assign out_load_data = _load_data;
        // assign out_save_data = _reg_rs2_data;
        // assign out_im_wait_sig = _im_wait_sig;
      

        //-=-=-=-=-=-CPU 主要部分-=-=-=-=-=-=-

        Program_counter new_pc_instance(
            //inputs
            .clk(clk),
            .rst(rst),
            .offset(_imm),
            .PC_control_sig(_pc_control_sig),
            //outputs
            .ALU_result(_alu_result),
            .pc(_pc),
            .im_wait_sig(_im_wait_sig),
            .return_addr(_return_addr)
        );
        
        Instruction_memory new_im_instance(
            //inputs
            .rst(rst),
            .clk(clk),
            .pc(_pc),
            .im_wait_sig(_im_wait_sig),
            //outputs
            .instruction(_instruction)
        );
        
        Instruction_decoder new_id_intance(
            //inputs
            .instruction(_instruction),
            //outputs
            .opcode(_opcode),
            .funct3(_funct3),
            .funct7(_funct7),
            .imm(_imm),
            .reg_rd_addr(_reg_rd_addr),
            .reg_rs1_addr(_reg_rs1_addr),
            .reg_rs2_addr(_reg_rs2_addr)
        );

        Register_bank new_reg_instance(
            //inputs
            .rst(rst),
            .clk(clk),                       
            .reg_write_sig(_reg_write_sig),             
            .reg_rs1_addr(_reg_rs1_addr),
            .reg_rs2_addr(_reg_rs2_addr),
            .reg_rd_addr(_reg_rd_addr), 
            //outputs
             .write_data(_write_data), 
             .reg_rs1_data(_reg_rs1_data),
             .reg_rs2_data(_reg_rs2_data),
            //  .debug_reg0_data(_debug_reg0_data),
            //  .debug_reg1_data(_debug_reg1_data),
            //  .debug_reg2_data(_debug_reg2_data),
            //  .debug_reg3_data(_debug_reg3_data),
            //  .debug_reg4_data(_debug_reg4_data),
            //  .debug_reg5_data(_debug_reg5_data),
            //  .debug_reg6_data(_debug_reg6_data),
            //  .debug_reg7_data(_debug_reg7_data),
            //  .debug_reg8_data(_debug_reg8_data),
            //  .debug_reg9_data(_debug_reg9_data),
            //  .debug_reg10_data(_debug_reg10_data),
             .debug_reg11_data(_debug_reg11_data),
             .debug_reg12_data(_debug_reg12_data),
             .debug_reg13_data(_debug_reg13_data),
             .debug_reg14_data(_debug_reg14_data),
             .debug_reg15_data(_debug_reg15_data)//,
            //  .debug_reg16_data(_debug_reg16_data),
            //  .debug_reg17_data(_debug_reg17_data)//,
            //  .debug_reg18_data(_debug_reg18_data),
            //  .debug_reg19_data(_debug_reg19_data),
            //  .debug_reg20_data(_debug_reg20_data),
            //  .debug_reg21_data(_debug_reg21_data),
            //  .debug_reg22_data(_debug_reg22_data),
            //  .debug_reg23_data(_debug_reg23_data),
            //  .debug_reg24_data(_debug_reg24_data),
            //  .debug_reg25_data(_debug_reg25_data),
            //  .debug_reg26_data(_debug_reg26_data),
            //  .debug_reg27_data(_debug_reg27_data),
            //  .debug_reg28_data(_debug_reg28_data),
            //  .debug_reg29_data(_debug_reg29_data),
            //  .debug_reg30_data(_debug_reg30_data),
            //  .debug_reg31_data(_debug_reg31_data)
        );
        
        Arithmetic_logic_unit new_alu_instance(
            //inputs
            .ALU_control_sig(_alu_control_sig),
            //outputs
            .src_1_data(_src_1_data),
            .src_2_data(_src_2_data),
            .ALU_result(_alu_result)
        );
        
        Mux_alu_source1 new_mux_alu_source1_instance(
            //inputs
            .alu_src_control_sig(_alu_src1_control_sig),
            .reg_data(_reg_rs1_data),
            .pc(_pc),  
            .imm(_imm),
            //outputs
            .src(_src_1_data)
        );

        Mux_alu_source2 new_mux_alu_source2_instance(
            //inputs
            .alu_src_control_sig(_alu_src2_control_sig),
            .reg_data(_reg_rs2_data),
            .pc(_pc),  
            .imm(_imm),
            //outputs
            .src(_src_2_data)
        );

        Mux_reg_source new_mux_reg_source_instance(
            //inputs
            .reg_src_sig(_reg_src_sig),
            .return_addr(_return_addr),
            .ALU_result(_alu_result),
            .load_data(_load_data),
            //outputs
            .src(_write_data)

        );

        Control_unit new_control_instance(
            //inputs
            .clk(clk),
            .opcode(_opcode),
            .funct3(_funct3),
            .funct7(_funct7),
            //outputs
            .PC_control_sig(_pc_control_sig),
            .ALU_control_sig(_alu_control_sig),
            .reg_write_sig(_reg_write_sig),
            .ALU_src1_sig(_alu_src1_control_sig),
            .ALU_src2_sig(_alu_src2_control_sig),
            .reg_src_sig(_reg_src_sig),
            .mem_write_sig(_mem_write_sig),
            .mem_read_sig(_mem_read_sig)
        );

        //-=-=-=-=-=-=-内存部分-=-=-=-=-=-=-

        Data_memory new_data_mem_instance(
            //inputs
            .clk(clk),
            .mem_write_sig(_mem_write_sig),
            .mem_read_sig(_mem_read_sig),
            .mem_addr(_alu_result),
            .mem_write_data(_reg_rs2_data),
            //outputs
            .mem_clk(mem_clk),
            .mem_read_data(_load_data)
        );


endmodule