`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/25 11:29:30
// Design Name: 
// Module Name: Frequency_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: A frequency multiplier is a circuit that produces an output signal whose frequency is a multiple of the input signal frequency.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// This is a frequency multiplier that can multiply the frequency by 2 or 4 times.
module Frequency_multiplier_2x(
        input clk,
        input rst,
        output  wire clk_out 
 );

        reg Q;
        wire NOR_clk;
        always@(posedge NOR_clk or negedge rst)
            begin
            if(!rst)
            Q <= 0;
            else
            #0.25
            Q <= ~Q;
        end

        assign NOR_clk = Q^clk;
        assign clk_out =  NOR_clk; 
        
        initial begin
            Q <= 0;
        end
 
endmodule

module Frequency_multiplier_2x_b(
        input clk,
        input rst,
        output wire clk_out 
 );

        reg Q;
        wire NOR_clk;
        always@(posedge NOR_clk or negedge rst)
            begin
            if(!rst)
            Q <= 0;
            else
            //#0.1
            Q <= ~Q;
        end
        
        initial begin
            Q <= 0;
        end

        assign NOR_clk = Q^clk;
        assign clk_out =  NOR_clk; 
 
endmodule

module Frequency_multiplier_4x(
        input wire clk,
        input wire rst,
        input wire clk_out);

        reg Q;
        reg Q2;

        wire clktemp;

        Frequency_multiplier_2x f(
        .clk(clk),
        .rst(rst),
        .clk_out(clktemp) 
            );

        Frequency_multiplier_2x_b f1(
        .clk(clktemp),
        .rst(rst),
        .clk_out(clk_out) 
            );

         always@(posedge clktemp or negedge rst) 
         begin
            if(!rst)
                Q <= 0;
            else
                Q <= ~Q;
         end

         always@(posedge clk_out or negedge rst) 
         begin
            if(!rst)
                Q2 <= 0;
            else
                Q2 <= ~Q2;
         end
endmodule
