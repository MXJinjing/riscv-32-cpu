`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 15:49:06
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
        input wire          clk,
        input wire          mem_wea_signal,
        input wire[31:0]    mem_addr,
        input wire[31:0]    mem_write_data,

        output wire[31:0]   mem_read_data
    );

    blk_mem_gen new_bram_instance (
        .clka(clk),
        .ena(1'b1),
        .wea(mem_wea_signal),
        .addra(mem_addr),
        .dina(mem_write_data),
        .douta(mem_read_data)
    );

endmodule
