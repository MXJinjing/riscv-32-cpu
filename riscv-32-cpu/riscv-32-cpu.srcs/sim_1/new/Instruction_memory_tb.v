`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 23:00:01
// Design Name: 
// Module Name: Instruction_memory_tb
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


module Instruction_memory_tb(
    );
    reg reset;
    reg clk;
    reg [10:0] PC;
    wire [31:0] Dout;
    wire [31:0] test;
    reg  [10:0] i;
    parameter period = 1;
    parameter hperiod =0.5;
    parameter times =10;
    RISCV_CPU_top uut(.rst(reset),.clk(clk),.data1(Dout),.data2(test));
    initial
        begin
        #50
        clk = 0;
         reset = 0;
        #50
        reset =1;
   
    end
    always #hperiod clk = !clk;
    endmodule
