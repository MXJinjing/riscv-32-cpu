`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 14:03:47
// Design Name: 
// Module Name: CPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: the top module of the cpu, connect all the modules together
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
    
 
        
        
        
        
        wire                  _ALU_result_1bit;         
        wire                  _reg_write_sig;           
        wire                  _reg_read_sig;            
        wire                  _addr_write_sig;          
        wire                  _overflow_sig;            
        wire [1:0]            _PC_control_sig;
        wire [4:0]            _reg_1_addr;
        wire [4:0]            _reg_2_addr;
        wire [4:0]            _ALU_control_sig;
        wire [20:1]           offset;
        wire [31:0]           _pc;
        wire [31:0]           _reg_rd_addr;
        wire [31:0]           _write_data;
        wire [31:0]           _write_addr;
        wire [31:0]           _reg_1_data;
        wire [31:0]           _reg_2_data;
        wire [31:0]           _reg_rs1_data;
        wire [31:0]           _src_1_data;
        wire [31:0]           _src_2_data;
        wire [31:0]           _ALU_result;
        
        
        PC_unit new_pc_unit_inst(
            .clk(clk),
            .rst(rst),
            .PC_control_sig(_PC_control_sig),
            .offset(_offset),
            .reg_rs1_data(_reg_rs1_data),
            .ALU_result_1bit(_ALU_result_1bit),
            .pc(_pc),
            .reg_rd_addr(_reg_rd_addr)
        );

        ALU_unit new_alu_unit_inst(
            .clk(clk),
            .ALU_control_sig(_ALU_control_sig),
            .src_1_data(_src_1_data),
            .src_2_data(_src_2_data),
            .ALU_result(_ALU_result),
            .overflow_sig(_overflow_sig)
        );
        

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