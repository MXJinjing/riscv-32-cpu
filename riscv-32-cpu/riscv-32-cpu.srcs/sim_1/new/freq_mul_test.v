`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/25 11:34:29
// Design Name: 
// Module Name: freq_mul_test
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


module freq_mul_test(

    );

    reg clk;
    reg rst;
    wire clk_out_2x;
    wire clk_out_4x;

    Frequency_multiplier_2x f1(
        .clk(clk),
        .rst(rst),
        .clk_out(clk_out_2x)
    );

    Frequency_multiplier_4x f2(
        .clk(clk),
        .rst(rst),
        .clk_out(clk_out_4x)
    );
    
    initial begin
        clk = 0;
        rst = 0;
        #5;
        rst = 1;
        #5;
        rst = 0;
        #5
        rst = 1;
    end  

    always #0.5 clk = ~clk;  

endmodule
