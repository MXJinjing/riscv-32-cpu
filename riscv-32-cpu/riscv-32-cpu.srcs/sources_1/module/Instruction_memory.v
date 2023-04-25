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
    input wire [31:0] pc,           //pc address
    output reg [31:0] instruction         //instruction out
    );
    //reg [3:0] flag;
    
    wire[31:0] _douta;
    blk_mem_gen_0 uut(.clka(clk),.addra(pc[12:2]),.douta(_douta));

    always @(posedge clk) begin
        instruction <= _douta;
    end
    
    
endmodule



