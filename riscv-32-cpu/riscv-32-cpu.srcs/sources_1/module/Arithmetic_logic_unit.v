`timescale 1ns / 1ps
`include "../define/alu_control_define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 19:15:54
// Design Name: 
// Module Name: ALU_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Desrciption: arithmetic and logic unit, which is the core of the CPU
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////_data////////


module Arithmetic_logic_unit(
        input               clk,               //clock input signals
        input wire[4:0]     ALU_control_sig,   //control signals

        input wire[31:0]    src_1_data,        //input data from source 1
        input wire[31:0]    src_2_data,        //input data from source 2

        output reg[31:0]    ALU_result,        //output data
        output reg          overflow           //overflow signal
    );

    wire equal;
    wire signed_less_than;
    wire unsigned_less_than;
    wire[31:0] sext_offset;

    assign equal = (src_1_data == src_2_data) ? 1'b1 : 1'b0;
    assign signed_less_than = ($signed(src_1_data) < $signed(src_2_data)) ? 1'b1 : 1'b0;
    assign unsigned_less_than = ($unsigned(src_1_data) < $unsigned(src_2_data)) ? 1'b1 : 1'b0;

    always @(negedge clk) begin
        case (ALU_control_sig)

            //FOR ARITHMETIC INSTRUCTION
            `ALU_ADD:begin
                ALU_result <= src_1_data + src_2_data;
                overflow = ($signed(src_1_data) + $signed(src_2_data) > 32'h7fffffff) || 
                ($signed(src_1_data) + $signed(src_2_data) < 32'h80000000)? 1'b1 : 1'b0;     //report overflow
            end
            `ALU_SUB:begin
                ALU_result <= src_1_data - src_2_data;
                overflow = ($signed(src_1_data) - $signed(src_2_data) > 32'h7fffffff) || 
                ($signed(src_1_data) - $signed(src_2_data) < 32'h80000000)? 1'b1 : 1'b0;     //report overflow
            end

            //FOR LOGIC INSTRUCTION
            `ALU_AND:begin
                ALU_result <= src_1_data & src_2_data;
            end
            `ALU_OR:begin
                ALU_result <= src_1_data | src_2_data;
            end
            `ALU_XOR:begin
                ALU_result <= src_1_data ^ src_2_data;
            end
            `ALU_NOR:begin
                ALU_result <= ~(src_1_data | src_2_data);
            end

            //FOR COMPARE INSTRUCTION
            `ALU_SLT:begin
                ALU_result = (signed_less_than)? 32'b1 : 32'b0;
            end
            `ALU_SLTU:begin
                ALU_result = (unsigned_less_than)? 32'b1 : 32'b0;
            end

            //FOR SHIFT INSTRUCTION
            `ALU_SLL:begin
                ALU_result <= src_1_data << src_2_data[4:0];
            end
            `ALU_SRL:begin
                ALU_result <= src_1_data >> src_2_data[4:0];
            end
            `ALU_SRA:begin
                ALU_result <= src_1_data >>> src_2_data[4:0];
            end

            //FOR BRANCH INSTRUCTION
            `ALU_BEQ:begin
                ALU_result <= (equal)? 1'b1 : 1'b0;
            end
            `ALU_BNE:begin
                ALU_result <= (~equal)? 1'b1 : 1'b0;
            end
           `ALU_BLT:begin
                ALU_result <= (signed_less_than)? 1'b1 : 1'b0;
            end
            `ALU_BGE:begin
                ALU_result <= (~signed_less_than)? 1'b1 : 1'b0;
            end
            `ALU_BLTU:begin
                ALU_result <= (unsigned_less_than)? 1'b1 : 1'b0;
            end
            `ALU_BGEU:begin
                ALU_result <= (~unsigned_less_than)? 1'b1 : 1'b0;
            end
            //DO NOTHING FOR OTHER INSTRUCTION
            default:begin
                ALU_result <= 32'hffffffff;
            end
        endcase
    end
endmodule
