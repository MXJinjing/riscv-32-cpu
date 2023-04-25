`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/04/24 18:33:41
// Design Name:
// Module Name: Register_bank_tb
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


module Register_bank_tb(

  );
       reg  clk;                       //clock input signals
       reg  reg_write_sig;             //indicate whether a write operation is required
       reg [4:0] reg_r1_addr;          //address of the first register to be read
       reg [4:0] reg_r2_addr;          //address of the second register to be read
       reg [4:0] reg_w1_addr;         //address of the first register to be write
       reg [31:0] write_data;          //date to be written to the register
       wire [31:0] reg_1_data;         //data that read from the first register
       wire [31:0] reg_2_data;         //data that read from the second register
       wire [31:0] debug;

       Register_bank uut(
         .clk(clk),                       //clock input signals
         .reg_write_sig(reg_write_sig),             //indicate whether a write operation is required
         .reg_rs1_addr(reg_r1_addr),          //address of the first register to be read
         .reg_rs2_addr(reg_r2_addr),          //address of the second register to be read
         .reg_rd_addr(reg_w1_addr),         //address of the first register to be write
         .write_data(write_data),          //date to be written to the register
         .reg_rs1_data(reg_1_data),         //data that read from the first register
         .reg_rs2_data(reg_2_data)         //data that read from the second register
       );
        parameter period = 1;
       parameter hperiod =0.5;
    parameter times =10;
    initial
       begin
        #50
         clk = 0;
         reg_write_sig=1;
         #50
         write_data=12;       //date to be written to the register
         reg_w1_addr=12;
         //reg_write_sig=0;
         #50
         reg_w1_addr=14;
         reg_write_sig=1;
         write_data=14;  
          //reg_write_sig=0;     //date to be written to the register
         #50
         reg_r1_addr=14;          //address of the first register to be read
         reg_r2_addr=12;
        end
        always #hperiod clk = !clk;
endmodule