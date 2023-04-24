`timescale 1ns / 1ps
`include "../define/rv32i_op_define.vh"
`include "../define/pc_control_define.vh"
`include "../define/alu_control_define.vh"
`include "../define/alu_src_control_define.vh"
`include "../define/ls_control_define.vh"
`include "../ram_control_define.vh"
`include "../reg_control_define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 12:43:47
// Design Name: 
// Module Name: Control_unit
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


module Control_unit(
        input wire[6:0]      opcode,
        input wire[2:0]      funct3,
        input wire[6:0]      funct7,

        output wire[3:0]     PC_control_sig,
        output wire[3:0]     ALU_control_sig,
        output wire          reg_write_sig,
        output wire          blk_mem_we_sig,
        output wire          mux_lenth_ls_sig,
        output wire          mux_lenth_jalr_sig,
        output wire[2:0]      ALU_source_sig
    );
    
    
    

endmodule
