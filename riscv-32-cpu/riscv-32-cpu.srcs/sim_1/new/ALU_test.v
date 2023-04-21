`timescale 1ns / 1ps
`include "../../sources_1/define/alu_control_def.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 20:19:25
// Design Name: 
// Module Name: ALU_test
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


module ALU_test(
        input wire clk
    );
    reg[3:0]         sig;
    reg[31:0]        data1;
    reg[31:0]        data2;
    wire[31:0]        result;
    wire              overflow;
    
ALU_unit test_alu_unit_inst(
    .clk(clk),
    .ALU_control_sig(sig),
    .src_1_data(data1),
    .src_2_data(data2),
    .ALU_result(result),
    .overflow_sig(overflow)
);

initial begin
    //test ALU SLT instruction
    sig = `ALU_CONTROL_SLT;
    data1 = 32'h00000000;
    data2 = 32'h00000001;
    #10;
    data1 = 32'h00000001;
    data2 = 32'h00000000;
    #10;
    data1 = 32'h00000001;
    data2 = 32'hffffffff;
    #10;
    data1 = 32'hffffffff;
    data2 = 32'h00000001;
    #10;
    
    sig = `ALU_CONTROL_SLTU;
    data1 = 32'h00000000;
    data2 = 32'h00000001;
    #10;
    data1 = 32'h00000001;
    data2 = 32'h00000000;
    #10;
    data1 = 32'h00000001;
    data2 = 32'hffffffff;
    #10;
    data1 = 32'hffffffff;
    data2 = 32'h00000001;
    #10;
end

endmodule
