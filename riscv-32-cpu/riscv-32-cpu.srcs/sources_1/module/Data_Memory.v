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
        input wire          clk,    // CPU时钟
        input wire          mem_write_sig,  // 内存写入信号
        input wire          mem_read_sig,   // 内存读取信号
        input wire[31:0]    mem_addr,       // 内存地址
        input wire[31:0]    mem_write_data, // 内存写入数据

        output wire         mem_clk,        // 内存时钟
        output wire[31:0]   mem_read_data   // 内存读取数据
    );

    wire[31:0]  douta;
    reg [31:0]  data_out;
    wire        wea;

    assign mem_clk = clk_2x;
    assign mem_read_data = data_out;
    assign wea = mem_write_sig & clk;
    
    Frequency_multiplier_2x freq_mul (  // 时钟频率倍频
        .clk(clk),
        .rst(1'b1),
        .clk_out(clk_2x)
    );

    blk_mem_gen_2 bram (    // 内存模块
        .clka(clk_2x),
        .wea(wea),
        .addra(mem_addr[31:2]),
        .dina(mem_write_data),
        .douta(douta)
    );

    always @(douta) begin   // 内存读取数据
        if(mem_read_sig) begin
            data_out <= douta;
        end
    end
    
    initial begin
        data_out <= 0;
    end

endmodule
