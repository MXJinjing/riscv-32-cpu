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


module CPU_TOP_tb(
    );
    parameter period = 1;
    parameter hperiod = 0.5;
    parameter times =10;

    reg reset;
    reg clk;

    wire[31:0]       pc;
    wire[31:0]       instruction;
    wire[6:0]        opcode;
    wire[2:0]        funct3;
    wire[6:0]        funct7;
    wire[31:0]       imm;
    wire[4:0]        reg_rd_addr;
    wire[4:0]        reg_rs1_addr;
    wire[4:0]        reg_rs2_addr;
    wire[31:0]       alu_result;
    wire[31:0]       src_1_data;
    wire[31:0]       src_2_data;
    wire[31:0]       reg_rs1_data;
    wire[31:0]       reg_rs2_data;
    wire[31:0]       return_addr;
    wire[31:0]       write_data;

    wire[2:0]        pc_control_sig;
    wire[4:0]        alu_control_sig;
    wire             reg_write_sig;
    wire[2:0]        alu_src1_control_sig;
    wire[2:0]        alu_src2_control_sig;
    wire[2:0]        reg_src_sig;
    
    wire             mem_clk;
    wire[31:0]       load_data;
    wire[31:0]       save_data;
    wire             mem_write_sig;


    wire[31:0]      debug_reg0_data;
    wire[31:0]      debug_reg1_data;
    wire[31:0]      debug_reg2_data;
    wire[31:0]      debug_reg3_data;
    wire[31:0]      debug_reg4_data;
    wire[31:0]      debug_reg5_data;
    wire[31:0]      debug_reg6_data;
    wire[31:0]      debug_reg7_data;
    wire[31:0]      debug_reg8_data;
    wire[31:0]      debug_reg9_data;
    wire[31:0]      debug_reg10_data;
    wire[31:0]      debug_reg11_data;
    wire[31:0]      debug_reg12_data;
    wire[31:0]      debug_reg13_data;
    wire[31:0]      debug_reg14_data;
    wire[31:0]      debug_reg15_data;
    wire[31:0]      debug_reg16_data;
    wire[31:0]      debug_reg17_data;
    wire[31:0]      debug_reg18_data;
    wire[31:0]      debug_reg19_data;
    wire[31:0]      debug_reg20_data;
    wire[31:0]      debug_reg21_data;
    wire[31:0]      debug_reg22_data;
    wire[31:0]      debug_reg23_data;
    wire[31:0]      debug_reg24_data;
    wire[31:0]      debug_reg25_data;
    wire[31:0]      debug_reg26_data;
    wire[31:0]      debug_reg27_data;
    wire[31:0]      debug_reg28_data;
    wire[31:0]      debug_reg29_data;
    wire[31:0]      debug_reg30_data;
    wire[31:0]      debug_reg31_data;

    RISCV_CPU_top uut(
        .rst(reset),
        .clk(clk),


        .out_pc(pc),
        .out_instruction(instruction),
        .out_opcode(opcode),
        .out_funct3(funct3),
        .out_funct7(funct7),
        .out_imm(imm),

        .out_reg_rd_addr(reg_rd_addr),
        .out_reg_rs1_addr(reg_rs1_addr),
        .out_reg_rs2_addr(reg_rs2_addr),
        
        .out_reg_rs1_data(reg_rs1_data),
        .out_reg_rs2_data(reg_rs2_data),

        .out_src_1_data(src_1_data),
        .out_src_2_data(src_2_data),
        .out_alu_result(alu_result),
        
        .out_write_data(write_data),
        .out_return_addr(return_addr),
        
        .mem_clk(mem_clk),
        .out_load_data(load_data),
        .out_save_data(save_data),

        .out_pc_control_sig(pc_control_sig),
        .out_alu_control_sig(alu_control_sig),
        .out_reg_write_sig(reg_write_sig),
        .out_alu_src1_control_sig(alu_src1_control_sig),
        .out_alu_src2_control_sig(alu_src2_control_sig),
        .out_reg_src_sig(reg_src_sig),
        .out_mem_write_sig(mem_write_sig),

        ._debug_reg0_data(debug_reg0_data),
        ._debug_reg1_data(debug_reg1_data),
        ._debug_reg2_data(debug_reg2_data),
        ._debug_reg3_data(debug_reg3_data),
        ._debug_reg4_data(debug_reg4_data),
        ._debug_reg5_data(debug_reg5_data),
        ._debug_reg6_data(debug_reg6_data),
        ._debug_reg7_data(debug_reg7_data),
        ._debug_reg8_data(debug_reg8_data),
        ._debug_reg9_data(debug_reg9_data),
        ._debug_reg10_data(debug_reg10_data),
        ._debug_reg11_data(debug_reg11_data),
        ._debug_reg12_data(debug_reg12_data),
        ._debug_reg13_data(debug_reg13_data),
        ._debug_reg14_data(debug_reg14_data),
        ._debug_reg15_data(debug_reg15_data),
        ._debug_reg16_data(debug_reg16_data),
        ._debug_reg17_data(debug_reg17_data),
        ._debug_reg18_data(debug_reg18_data),
        ._debug_reg19_data(debug_reg19_data),
        ._debug_reg20_data(debug_reg20_data),
        ._debug_reg21_data(debug_reg21_data),
        ._debug_reg22_data(debug_reg22_data),
        ._debug_reg23_data(debug_reg23_data),
        ._debug_reg24_data(debug_reg24_data),
        ._debug_reg25_data(debug_reg25_data),
        ._debug_reg26_data(debug_reg26_data),
        ._debug_reg27_data(debug_reg27_data),
        ._debug_reg28_data(debug_reg28_data),
        ._debug_reg29_data(debug_reg29_data),
        ._debug_reg30_data(debug_reg30_data),
        ._debug_reg31_data(debug_reg31_data)

    );
    initial begin
        clk = 1;
        reset = 0;
        #1
        reset = 1;
        #651
        $finish;
    end
    always #hperiod clk = ~clk;
    endmodule
