`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 15:00:54
// Design Name: 
// Module Name: RAM_bank
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


module RAM_bank(
        input wire clk,                       // clock input signals
        input wire ram_control_sig,             // ram control signals

        input wire[31:0] reg_rs1_data,        // menmory address saved in reg_rs1
        input wire[31:0] reg_rs2_data,        // save data from reg_rs2 to memory
        input wire[31:0] reg_rd_addr,         // menmory data to be saved in reg_rd

        input wire[11:0] offset,              // offset of the memory address

        output wire mem_addr,                  // address of the memory
        output wire[31:0] mem_datain          // data read from the memory

    );
    
    assign mem_datain = reg_rs2_data;
    assign mem_addr = reg_rs1_data + offset;
    
endmodule
