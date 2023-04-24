`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 11:24:33
// Design Name: 
// Module Name: decoder_test
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


module decoder_test(
    );

    reg[31:0] instruction;
    wire[2:0] funct3;
    wire[6:0] funct7;
    wire[6:0] opcode;
    wire[31:0] imm_32_bit;
    wire[4:0] reg_rd_addr;
    wire[4:0] reg_rs1_addr;
    wire[4:0] reg_rs2_addr;
    
    
    Instruction_decoder decoder(
        .instruction(instruction),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .imm_32_bit(imm_32_bit),
        .reg_rd_addr(reg_rd_addr),
        .reg_rs1_addr(reg_rs1_addr),
        .reg_rs2_addr(reg_rs2_addr)
    );


    
    initial begin
        instruction <= 32'b00000000001100010000000010110011;
        #10
        instruction <= 32'b00000100000000000000000000010011;
        #10
        instruction <= 32'b00000000010000000000000011101111;
        #10
        instruction <= 32'b00000000010000011100000101100011;
    end

endmodule
