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


module Mux_alu_source(
        input wire[2:0] alu_src_control_sig,
        input wire[31:0] reg_rs2_data,
        input wire[31:0] reg_pc_data,   
        input wire[31:0] imm,
        output wire[31:0] src2
    );
    
    always @(*) begin
        case(alu_src_control_sig) begin
            `REG_RS2: src2 = reg_rs2_data;
            `IMM_31_0: src2 = imm;
            `IMM_31_12: src2 = imm[31:12];
            `IMM_20_1: src2 = imm[20:1];
            `IMM_11_0: src2 = imm[11:0];
            `IMM_12_1: src2 = imm[12:1];
            `REG_PC: src2 = reg_pc_data;
            default: src2 = 32'd0;
        end
    end

endmodule
