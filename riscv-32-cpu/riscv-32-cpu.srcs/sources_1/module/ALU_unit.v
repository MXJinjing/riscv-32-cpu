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
// Desrciption: arithmetic and logic unit, get instruction by the control unit
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////_data////////


module ALU_unit(
        input clk,                          //clock input signals
        input wire[3:0]  ALU_control_sig,   //control signals

        input wire[31:0] src_1_data,        //input data from source 1
        input wire[31:0] src_2_data,        //input data from source 2

        output reg[31:0] ALU_result,        //output data
        output reg overflow_sig             //overflow signal
    );

    always @(*) begin
        case (ALU_control_sig)
            `ALU_CONTROL_ADD:begin
                
            end
            `ALU_CONTROL_SUB:begin

            end
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
            `ALU_CONTROL_SLT:begin
                if($signed(src_1_data) < $signed(src_2_data)) begin
                    ALU_result <= 1;
                end
                else begin
                    ALU_result <= 0;
                end
            end
            `ALU_CONTROL_SLTU:begin
                if(src_1_data < src_2_data) begin
                    ALU_result <= 1;
                end
                else begin
                    ALU_result <= 0;
                end
            end
            `ALU_CONTROL_SLL:begin
                ALU_result <= src_1_data << src_2_data;
            end
            `ALU_CONTROL_SRL:begin
                ALU_result <= src_1_data >> src_2_data;
            end
            `ALU_CONTROL_SRA:begin
                ALU_result <= src_1_data >>> src_2_data;
            end
            default:begin
                ALU_result <= 0;
            end
        endcase
    end
endmodule
