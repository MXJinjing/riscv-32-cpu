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
        output reg [31:0] reg_rs1_data,         //data that read from the first register
        output reg [31:0] reg_rs2_data         //data that read from the second register
    );
    
    reg[31:0]  x[31:0];                       //registers x[0] to x[31]

    
    always@(reg_rs1_addr or reg_rs2_addr or clk)begin 
    if(clk)begin
        reg_rs1_data = x[reg_rs1_addr];        //get data from the registers
        reg_rs2_data = x[reg_rs2_addr];
    end
    end

    always @ (negedge clk) begin
        if(reg_write_sig) begin              //write data from the registers
            x[reg_rd_addr] <= write_data;
        end
        x[0] = 32'h0;                         //x[0] is always set to zero
    end
    
    initial begin 
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
        reg_rs1_data = 32'h0;
        reg_rs2_data = 32'h0;
    end
    
endmodule
