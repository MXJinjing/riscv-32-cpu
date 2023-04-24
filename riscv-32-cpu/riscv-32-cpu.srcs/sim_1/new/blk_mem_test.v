`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/24 17:37:44
// Design Name: 
// Module Name: blk_mem_test
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


module blk_mem_test(
    );
    //reg [3:0] flag;
    reg clk;
    reg[31:0] mem_address;
    wire[31:0] Dout;
    
    blk_mem_gen_0 uut(.clka(clk),.addra(mem_address[10:0]),.douta(Dout));
    
    
    initial begin
        mem_address <= 0;
        clk = 0;
        #10
        clk = 1;
        #10
        mem_address <= 32'd1;
        clk = 0;
        #10
        clk = 1;
        #10
        mem_address <= 32'd2;
        clk = 0;
        #10
        clk = 1;
        #10
        mem_address <= 32'd3;
        clk = 0;
        #10
        clk = 1;
         #10
        mem_address <= 32'd4;
        clk = 0;
        #10
        clk = 1;
         #10
        mem_address <= 32'd5;
        clk = 0;
        #10
        clk = 1;
         #10
        mem_address <= 32'd6;
        clk = 0;
        #10
        clk = 1;
         #10
        mem_address <= 32'd7;
        clk = 0;
        #10
        clk = 1;
    end
endmodule
