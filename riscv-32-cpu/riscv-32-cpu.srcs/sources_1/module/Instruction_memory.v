`timescale 1ns / 1ps
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
    input wire [31:0] PC,           //pc address
    output wire [31:0] Dout         //instruction out
    );
    //reg [3:0] flag;
    wire[31:0] mem_address;
    assign mem_address = { 1'b0, {PC[31:1]} } ;
    
    blk_mem_gen_0 uut(.clka(clk),.addra(mem_address[10:0]),.douta(Dout));
    
endmodule



