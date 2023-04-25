`timescale 1ns / 1ps
`include "../define/alu_src_control_define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 11:58:17
// Design Name: 
// Module Name: Mux_alu_source
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: to pick the source of the alu, whether is from the immediate or the register
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux_alu_source1(
        input wire[2:0] alu_src1_control_sig,
        input wire[31:0] reg_rs1_data,
        input wire[31:0] reg_pc_data,   
        input wire[31:0] imm,
        output wire[31:0] src2
    );
    
    assign src2 = (alu_src1_control_sig == `SRC_REG_RS1) ? reg_rs1_data:
                (alu_src1_control_sig == `SRC_REG_PC) ? reg_pc_data:
                (alu_src1_control_sig == `SRC_IMM) ? imm : 32'h00000000;

endmodule

module Mux_alu_source2(
        input wire[2:0] alu_src2_control_sig,
        input wire[31:0] reg_rs2_data,
        input wire[31:0] reg_pc_data,   
        input wire[31:0] imm,
        output wire[31:0] src2
    );
    
    assign src2 = (alu_src2_control_sig == `SRC_REG_RS2) ? reg_rs2_data:
                (alu_src2_control_sig == `SRC_REG_PC) ? reg_pc_data:
                (alu_src2_control_sig == `SRC_IMM) ? imm : 32'h00000000;

endmodule
