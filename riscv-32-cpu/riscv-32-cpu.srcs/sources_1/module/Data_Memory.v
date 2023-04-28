`timescale 1ns / 1ps
`include "../define/mem_control_define.vh"
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


module Data_memory(
        input wire          clk,
        input wire          mem_write_sig,
        input wire          mem_read_sig,
        input wire[31:0]    mem_addr,
        input wire[31:0]    mem_write_data,

        output wire        mem_clk,
        output reg[31:0]   mem_read_data,
        output reg         load_done_sig,
        output reg         store_done_sig
    );

    
    wire[31:0]  data_out;
    assign mem_clk = clk_2x;
    
    Frequency_multiplier_2x freq_mul (
        .clk(clk),
        .rst(1'b1),
        .clk_out(clk_2x)
    );

    blk_mem_gen_2 bram (
        .clka(mem_clk),
        .wea(store_done_sig),
        .addra(mem_addr[31:2]),
        .dina(mem_write_data),
        .douta(data_out)
    );


    always @(posedge mem_read_sig) begin
        load_done_sig <= `BUSY;
    end
    
    always @(data_out) begin
        mem_read_data <= data_out;
        load_done_sig <= `IDLE;
    end
    
    always @(posedge mem_write_sig) begin
        store_done_sig <= `BUSY;
    end
    
    always @(negedge mem_write_sig) begin
        store_done_sig <= `IDLE;
    end
    
    initial begin
        load_done_sig <= `IDLE;
        store_done_sig <= `IDLE;
    end

endmodule
