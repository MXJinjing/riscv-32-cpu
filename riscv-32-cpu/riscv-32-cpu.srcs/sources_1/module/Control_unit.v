`timescale 1ns / 1ps
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
        input wire[6:0] opcode,
        input wire[2:0] funct3,
        input wire[6:0] funct7,

        output wire[3:0] PC_control_sig,
        output wire[3:0] ALU_control_sig,
        output wire      reg_write_sig
    );

    

endmodule
