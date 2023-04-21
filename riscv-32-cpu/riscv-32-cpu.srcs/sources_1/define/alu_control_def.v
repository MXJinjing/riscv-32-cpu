`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 19:39:43
// Design Name: 
// Module Name: ALU_CONTROL_control_def
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

//-=-=-=-=-=-Logical-=-=-=-=-=-
`define ALU_CONTROL_ADD         4'b0000       //addition
`define ALU_CONTROL_SUB         4'b0001       //subtraction

//-=-=-=-=-Arithmetic-=-=-=-=-=-
`define ALU_CONTROL_AND         4'b0010       //and
`define ALU_CONTROL_OR          4'b0011       //or
`define ALU_CONTROL_XOR         4'b0100       //xor
`define ALU_CONTROL_NOR         4'b0101       //nor

//-=-=-=-=-=-Compare-=-=-=-=-=-
`define ALU_CONTROL_SLT         4'b0110       //set less than
`define ALU_CONTROL_SLTU        4'b0111       //set less than unsigned

//-=-=-=-=-=-Shift-=-=-=-=-=-=-
`define ALU_CONTROL_SLL         4'b1000       //shift left logical
`define ALU_CONTROL_SRL         4'b1001       //shift right logical
`define ALU_CONTROL_SRA         4'b1010       //shift right arithmetic



