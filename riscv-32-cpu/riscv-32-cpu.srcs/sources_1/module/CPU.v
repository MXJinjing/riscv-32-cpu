`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 14:03:47
// Design Name: 
// Module Name: cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: the top module of this cpu
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU(
        input wire clk,
        input wire rst,
        
        output wire overflow
    );
    
 
        wire _reg_write_sig;          
        wire _reg_read_sig;
        wire _addr_write_sig;
        wire[4:0] _reg_1_addr;
        wire[4:0] _reg_2_addr;
        wire[31:0] _write_data;
        wire[31:0] _write_addr;
        wire[31:0] _reg_1_data;
        wire[31:0] _reg_2_data;
        
        Reg_unit new_reg_unit_inst(
            .clk(clk),
            .reg_write_sig(_reg_write_sig),
            .reg_read_sig(_reg_read_sig),
            .addr_write_sig(_addr_write_sig),
            .reg_1_addr(_reg_1_addr),
            .reg_2_addr(_reg_2_addr),
            .write_data(_write_data),
            .write_addr(_write_addr),
            .reg_1_data(_reg_1_data),
            .reg_2_data(_reg_2_data)
        );
        
endmodule