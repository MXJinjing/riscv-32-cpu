`timescale 1ns / 1ps
`include "../define/lenth_control_define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 11:58:17
// Design Name: 
// Module Name: Mux_load_lenth
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


module Mux_lenth(
        input wire[2:0]      mux_lenth_sig,
        input wire[31:0]     data_32_bit,      // M[x[rs1] + sext(offset)]

        output wire[31:0]    data_out
    );

    wire[31:0] data_signed_word;
    wire[31:0] data_signed_half;
    wire[31:0] data_signed_byte;
    wire[31:0] data_unsigned_half;
    wire[31:0] data_unsigned_byte;

    assign data_signed_word = data_32_bit;
    assign data_signed_half = (data_32_bit[15])? {16'b1111_1111_1111_1111 , data_32_bit[15:0] } :
                                {16'b0000_0000_0000_0000 , data_32_bit[15:0] };
    assign data_signed_byte = (data_32_bit[7])? {24'b1111_1111_1111_1111_1111_1111 , data_32_bit[7:0] } :
                                {24'b0000_0000_0000_0000_0000_0000 , data_32_bit[7:0] };
    assign data_unsigned_half = { 16'h0000, data_32_bit[15:0] };
    assign data_unsigned_byte = { 24'h000000, data_32_bit[7:0] };

    assign data_out = (ls_lenth_sig == `L_MUX_W) ? data_signed_word:
                    (ls_lenth_sig == `L_MUX_H ) ? data_signed_half:
                    (ls_lenth_sig == `L_MUX_HU) ? data_unsigned_half:
                    (ls_lenth_sig == `L_MUX_B ) ? data_signed_byte:
                    (ls_lenth_sig == `L_MUX_BU) ? data_unsigned_byte : 32'h00000000;
endmodule
