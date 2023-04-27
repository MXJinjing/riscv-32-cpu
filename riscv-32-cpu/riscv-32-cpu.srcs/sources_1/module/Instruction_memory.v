`timescale 1ns / 1ps
`include "../define/im_wait_define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 14:42:10
// Design Name: 
// Module Name: Instruction Memory
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


module Instruction_memory (
        input wire clk,
        input wire [31:0] pc,           //pc address
        input wire im_wait_sig,         //wait signal
        output wire [31:0] instruction         //instruction out
    );
    
    reg [31:0] instruction_reg;
    
    wire[31:0] _pc;
    assign _pc = pc;
    
    Frequency_multiplier_2x freq_mul (
        .clk(clk),
        .rst(1'b1),
        .clk_out(clk_2x)
    );
    
    assign instruction = (im_wait_sig)?   32'h00000000 : instruction_reg;
    
    wire[31:0] _douta;
    blk_mem_gen_0 uut(.clka(~clk_2x),.addra(_pc[12:2]),.douta(_douta));

    always @(posedge clk) begin
        instruction_reg <= _douta;
    end
    
    initial begin
        instruction_reg <= 32'h00000000;
    end

endmodule



