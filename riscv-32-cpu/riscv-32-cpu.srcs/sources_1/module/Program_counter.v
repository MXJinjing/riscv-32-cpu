`timescale 1ns / 1ps
`include "../define/pc_control_define.vh"
`include "../define/im_wait_define.vh"

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
        input wire[2:0]     PC_control_sig,        // control signals
        input wire[31:0]    offset,
        input wire[31:0]    ALU_result,            //  calculated by alu

        output wire[31:0]   pc,                    // register of program counter  
        output reg          im_wait_sig,           // wait signal  
        output wire[31:0]   return_addr            // return address
    );
             
    wire[31:0]  pc_add_4; 
    reg[31:0]  current_pc;

    assign pc = current_pc;
    assign pc_add_4 = current_pc + 32'd4;
    
    always @ (posedge clk) begin
        if(!rst)begin
            current_pc <= 32'd0;
            im_wait_sig <= `IM_NO_WAIT;
        end else
        
        case (PC_control_sig)
            `PC_CONTROL_BRANCH:begin
                current_pc <= ALU_result ? current_pc  -32'd4 + offset   : pc_add_4;
                im_wait_sig <= ALU_result ? `IM_WAIT : `IM_NO_WAIT;
            end
            `PC_CONTROL_JALR:begin
                current_pc <= (ALU_result ) & 32'hfffffffe;
                im_wait_sig <= `IM_WAIT ;
            end
            `PC_CONTROL_JAL:begin
                current_pc <= ALU_result;
                im_wait_sig <= `IM_WAIT;
            end
            default:begin
                current_pc <= pc_add_4;
                im_wait_sig <= `IM_NO_WAIT;
            end
        endcase
    end

    
    assign return_addr = (PC_control_sig == `PC_CONTROL_JALR)? current_pc:
                      (PC_control_sig == `PC_CONTROL_JAL)? current_pc : 32'b0;
    
    initial begin
        current_pc = 32'b0;
        im_wait_sig <= `IM_NO_WAIT;
    end
endmodule
