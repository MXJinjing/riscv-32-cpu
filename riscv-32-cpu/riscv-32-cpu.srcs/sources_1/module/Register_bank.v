`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 12:32:29
// Design Name: 
// Module Name: Reg_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Register bank to save data in registers
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Register_bank(
        input wire clk,                       //clock input signals
        input wire reg_write_sig,             //indicate whether a write operation is required
        input wire[4:0] reg_rs1_addr,          //address of the first register to be read
        input wire[4:0] reg_rs2_addr,          //address of the second register to be read
        input wire[4:0] reg_rd_addr,         //address of the first register to be write
        input wire[31:0] write_data,          //date to be written to the register
        output wire[31:0] reg_rs1_data,         //data that read from the first register
        output wire[31:0] reg_rs2_data,         //data that read from the second register

        output wire[31:0] debug_reg0_data,
        output wire[31:0] debug_reg1_data,
        output wire[31:0] debug_reg2_data,
        output wire[31:0] debug_reg3_data,
        output wire[31:0] debug_reg4_data,
        output wire[31:0] debug_reg5_data,
        output wire[31:0] debug_reg6_data,
        output wire[31:0] debug_reg7_data,
        output wire[31:0] debug_reg8_data,
        output wire[31:0] debug_reg9_data,
        output wire[31:0] debug_reg10_data,
        output wire[31:0] debug_reg11_data,
        output wire[31:0] debug_reg12_data,
        output wire[31:0] debug_reg13_data,
        output wire[31:0] debug_reg14_data,
        output wire[31:0] debug_reg15_data,
        output wire[31:0] debug_reg16_data,
        output wire[31:0] debug_reg17_data,
        output wire[31:0] debug_reg18_data,
        output wire[31:0] debug_reg19_data,
        output wire[31:0] debug_reg20_data,
        output wire[31:0] debug_reg21_data,
        output wire[31:0] debug_reg22_data,
        output wire[31:0] debug_reg23_data,
        output wire[31:0] debug_reg24_data,
        output wire[31:0] debug_reg25_data,
        output wire[31:0] debug_reg26_data,
        output wire[31:0] debug_reg27_data,
        output wire[31:0] debug_reg28_data,
        output wire[31:0] debug_reg29_data,
        output wire[31:0] debug_reg30_data,
        output wire[31:0] debug_reg31_data

    );
    
    reg[31:0]  x[31:0];                       //registers x[0] to x[31]
    
    
    assign reg_rs1_data = x[reg_rs1_addr];        //get data from the registers
    assign reg_rs2_data = x[reg_rs2_addr];


    always @ (negedge clk) begin
        if(reg_write_sig == `REG_WRITE_ENABLE) begin              //write data from the registers
            x[reg_rd_addr] <= write_data;
        end                        
    end

    assign debug_reg0_data = x[0];
    assign debug_reg1_data = x[1];
    assign debug_reg2_data = x[2];
    assign debug_reg3_data = x[3];
    assign debug_reg4_data = x[4];
    assign debug_reg5_data = x[5];
    assign debug_reg6_data = x[6];
    assign debug_reg7_data = x[7];
    assign debug_reg8_data = x[8];
    assign debug_reg9_data = x[9];
    assign debug_reg10_data = x[10];
    assign debug_reg11_data = x[11];
    assign debug_reg12_data = x[12];
    assign debug_reg13_data = x[13];
    assign debug_reg14_data = x[14];
    assign debug_reg15_data = x[15];
    assign debug_reg16_data = x[16];
    assign debug_reg17_data = x[17];
    assign debug_reg18_data = x[18];
    assign debug_reg19_data = x[19];
    assign debug_reg20_data = x[20];
    assign debug_reg21_data = x[21];
    assign debug_reg22_data = x[22];
    assign debug_reg23_data = x[23];
    assign debug_reg24_data = x[24];
    assign debug_reg25_data = x[25];
    assign debug_reg26_data = x[26];
    assign debug_reg27_data = x[27];
    assign debug_reg28_data = x[28];
    assign debug_reg29_data = x[29];
    assign debug_reg30_data = x[30];
    assign debug_reg31_data = x[31];
    
    initial begin                          //initialize all registers to zero
        x[0] = 32'h0;
        x[1] = 32'h0;
        x[2] = 32'h0;
        x[3] = 32'h0;
        x[4] = 32'h0;
        x[5] = 32'h0;
        x[6] = 32'h0;
        x[7] = 32'h0;
        x[8] = 32'h0;
        x[9] = 32'h0;
        x[10] = 32'h0;
        x[11] = 32'h0;
        x[12] = 32'h0;
        x[13] = 32'h0;
        x[14] = 32'h0;
        x[15] = 32'h0;
        x[16] = 32'h0;
        x[17] = 32'h0;
        x[18] = 32'h0;
        x[19] = 32'h0;
        x[20] = 32'h0;
        x[21] = 32'h0;
        x[22] = 32'h0;
        x[23] = 32'h0;
        x[24] = 32'h0;
        x[25] = 32'h0;
        x[26] = 32'h0;
        x[27] = 32'h0;
        x[28] = 32'h0;
        x[29] = 32'h0;
        x[30] = 32'h0;
        x[31] = 32'h0;
    end
    
endmodule
