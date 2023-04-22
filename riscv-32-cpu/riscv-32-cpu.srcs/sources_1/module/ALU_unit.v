`timescale 1ns / 1ps
`include "../define/alu_control_def.v"
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


module ALU_unit(
        input               clk,               //clock input signals
        input wire[4:0]     ALU_control_sig,   //control signals

        input wire[31:0]    src_1_data,        //input data from source 1
        input wire[31:0]    src_2_data,        //input data from source 2

        output reg[31:0]    ALU_result,        //output data
        output reg          overflow_sig       //overflow signal
    );

    always @(*) begin
        case (ALU_control_sig)

            //FOR ARITHMETIC INSTRUCTION
            `ALU_CONTROL_ADD:begin
                ALU_result <= src_1_data + src_2_data;
                overflow_sig = ($signed(src_1_data) + $signed(src_2_data) > 32'h7fffffff) || 
                ($signed(src_1_data) + $signed(src_2_data) < 32'h80000000)?1:0;     //report overflow
            end
            `ALU_CONTROL_SUB:begin
                ALU_result <= src_1_data - src_2_data;
                overflow_sig = ($signed(src_1_data) - $signed(src_2_data) > 32'h7fffffff) || 
                ($signed(src_1_data) - $signed(src_2_data) < 32'h80000000)?1:0;     //report overflow
            end

            //FOR LOGIC INSTRUCTION
            `ALU_CONTROL_AND:begin
                ALU_result <= src_1_data & src_2_data;
            end
            `ALU_CONTROL_OR:begin
                ALU_result <= src_1_data | src_2_data;
            end
            `ALU_CONTROL_XOR:begin
                ALU_result <= src_1_data ^ src_2_data;
            end
            `ALU_CONTROL_NOR:begin
                ALU_result <= ~(src_1_data | src_2_data);
            end

            //FOR COMPARE INSTRUCTION
            `ALU_CONTROL_SLT:begin
                ALU_result = ($signed(src_1_data) < $signed(src_2_data))?1:0;
            end
            `ALU_CONTROL_SLTU:begin
                ALU_result = ($unsigned(src_1_data) < $unsigned(src_2_data))?1:0;
            end
            `ALU_CONTROL_SLL:begin
                ALU_result <= src_1_data << src_2_data[4:0];
            end
            `ALU_CONTROL_SRL:begin
                ALU_result <= src_1_data >> src_2_data[4:0];
            end
            `ALU_CONTROL_SRA:begin
                ALU_result <= src_1_data >>> src_2_data[4:0];
            end

            //FOR BRANCH INSTRUCTION
            `ALU_CONTROL_BEQ:begin
                ALU_result[0] <= (src_1_data == src_2_data)?1:0;
            end
            `ALU_CONTROL_BNE:begin
                ALU_result[0] <= (src_1_data != src_2_data)?1:0;
            end
            `ALU_CONTROL_BLT:begin
                ALU_result[0] <= ($signed(src_1_data) < $signed(src_2_data))?1:0;
            end
            `ALU_CONTROL_BGE:begin
                ALU_result[0] <= ($signed(src_1_data) >= $signed(src_2_data))?1:0;
            end
            `ALU_CONTROL_BLTU:begin
                ALU_result[0] <= ($unsigned(src_1_data) < $unsigned(src_2_data))?1:0;
            end
            `ALU_CONTROL_BGEU:begin
                ALU_result[0] <= ($unsigned(src_1_data) >= $unsigned(src_2_data))?1:0;
            end

            //DO NOTHING FOR OTHER INSTRUCTION
            default:begin
                ALU_result <= 32'hffffffff;
            end
        endcase
    end
endmodule
