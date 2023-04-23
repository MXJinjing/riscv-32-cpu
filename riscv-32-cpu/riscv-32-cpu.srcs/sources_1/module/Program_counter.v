`timescale 1ns / 1ps
`include "../define/pc_control_define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/22 00:31:55
// Design Name: 
// Module Name: Program Counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Program Counter Unit
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Program_counter(
        input wire          clk,                   // input clock signal
        input wire          rst,                   // reset signal
        input wire[1:0]     PC_control_sig,        // control signals
        input wire[20:1]    offset,                // offset 20bit
        input wire[31:0]    reg_rs1_data,          // register rs1 
        input wire          ALU_result_1bit,       // equality calculated by alu

        output reg[31:0]    pc,                    // register of program counter    
        output reg[31:0]    reg_rd_addr            // return address
    );

    wire[31:0]  current_pc;           // current pc
    assign current_pc = pc;           // update current_pc from result
    
    wire[31:0]  sign_extended_12;
    wire[31:0]  sign_extended_20;
    wire[31:0]  pc_add_4;
    
    assign sign_extended_12 =(offset[12])? { 20'b1111_1111_1111_1111_1111 , offset[12:1] }:{ 20'b0000_0000_0000_0000_0000 , offset[12:1] };
    assign sign_extended_20 =(offset[20])? { 12'b1111_1111_1111 , offset[20:1] }:{ 12'b0000_0000_0000 , offset[20:1] };
    assign pc_add_4 = current_pc + 32'd4;
    
    always @ (negedge clk) begin
        if(rst)begin
            pc <= 32'd0;
        end
        else begin
        case (PC_control_sig)
            `PC_NEXT:begin
                pc <= pc_add_4;
            end
            `PC_CONTROL_BRANCH:begin
                pc <= (ALU_result_1bit)? current_pc + sign_extended_12 : pc_add_4;
            end
            `PC_CONTROL_JALR:begin
                reg_rd_addr <= current_pc +  32'd4;
                pc <= (reg_rs1_data + sign_extended_12) & 32'hfffffffe;
            end
            `PC_CONTROL_JAL:begin
                reg_rd_addr <= current_pc + 32'd4;
                pc <= current_pc + sign_extended_20;
            end
            default:begin
                pc <= pc_add_4;
            end
        endcase
        end
    end

endmodule