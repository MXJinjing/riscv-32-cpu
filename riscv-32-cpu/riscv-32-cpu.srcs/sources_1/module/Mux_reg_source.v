`timescale 1ns / 1ps
`include "../define/reg_src_control_define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 11:58:17
// Design Name: 
// Module Name: Mux_reg_source
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
        input wire[2:0] reg_src_control_sig,
        input wire[31:0] return_addr
        input wire[31:0] ALU_result,
        input wire[31:0] load_data,
        output wire[31:0] src
    );
    
    assign src = (alu_src_control_sig == `SRC_RETURN_ADDR) ? return_addr :
                (alu_src_control_sig == `SRC_ALU) ? ALU_result:
                (alu_src_control_sig == `SRC_LOAD) ? return_addr : 32'h00000000;

endmodule