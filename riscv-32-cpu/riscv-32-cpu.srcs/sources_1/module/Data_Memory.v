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
        input wire          clk,    // CPUʱ��
        input wire          mem_write_sig,  // �ڴ�д���ź�
        input wire          mem_read_sig,   // �ڴ��ȡ�ź�
        input wire[31:0]    mem_addr,       // �ڴ��ַ
        input wire[31:0]    mem_write_data, // �ڴ�д������

        output wire         mem_clk,        // �ڴ�ʱ��
        output wire[31:0]   mem_read_data   // �ڴ��ȡ����
    );

    wire[31:0]  douta;
    reg [31:0]  data_out;
    wire        wea;

    assign mem_clk = clk_2x;
    assign mem_read_data = data_out;
    assign wea = mem_write_sig & clk;
    
    Frequency_multiplier_2x freq_mul (  // ʱ��Ƶ�ʱ�Ƶ
        .clk(clk),
        .rst(1'b1),
        .clk_out(clk_2x)
    );

    blk_mem_gen_2 bram (    // �ڴ�ģ��
        .clka(clk_2x),
        .wea(wea),
        .addra(mem_addr[31:2]),
        .dina(mem_write_data),
        .douta(douta)
    );

    always @(douta) begin   // �ڴ��ȡ����
        if(mem_read_sig) begin
            data_out <= douta;
        end
    end
    
    initial begin
        data_out <= 0;
    end

endmodule
