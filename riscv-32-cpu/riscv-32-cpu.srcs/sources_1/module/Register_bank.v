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
        
        input wire[4:0] reg_r1_addr,          //address of the first register to be read
        input wire[4:0] reg_r2_addr,          //address of the second register to be read

        input wire[4:0] reg_w1_addr,          //address of the first register to be write
        
        input wire[31:0] write_data,          //date to be written to the register
        
        output wire[31:0] reg_1_data,         //data that read from the first register
        output wire[31:0] reg_2_data,         //data that read from the second register
        
        output wire debug
    );
    
    reg[31:0]  x[31:0];                       //registers x[0] to x[31]
    
    assign reg_r1_data = x[reg_r1_addr];        //get data from the registers
    assign reg_r2_data = x[reg_r2_addr];
    
    always @ (negedge clk) begin
        if(reg_write_sig) begin              //write data from the registers
            x[reg_w1_addr] <= write_data;
        end
        x[0] = 32'h0;                         //x[0] is always set to zero
    end
    
    initial begin 
        x[0] = 32'h0;
    end
    
endmodule
