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

        input wire          ALU_result,       // equality calculated by alu

        output reg[31:0]    pc,                    // register of program counter    
        output reg[31:0]    return_addr            // return address
    );

    wire[31:0]  current_pc;           // current pc
    assign current_pc = pc;           // update current_pc from result

    wire[31:0]  pc_add_4;
    
    assign pc_add_4 = current_pc + 32'd4;
    
    always @ (posedge clk) begin
        if(rst)begin
            pc <= 32'd0;
        end
        else begin
        case (PC_control_sig)
            `PC_NEXT:begin
                pc <= pc_add_4;
            end
            `PC_CONTROL_BRANCH:begin
                pc <= ALU_result ? current_pc + offset : pc_add_4;
            end
            `PC_CONTROL_JALR:begin
                return_addr <= current_pc +  32'd4;
                pc <= ALU_result & 32'hfffffffe;
            end
            `PC_CONTROL_JAL:begin
                return_addr <= current_pc + 32'd4;
                pc <= ALU_result;
            end
            default:begin
                pc <= pc_add_4;
            end
        endcase
        end
    end
    
    initial begin
        pc <= 32'b0;
    end
endmodule
