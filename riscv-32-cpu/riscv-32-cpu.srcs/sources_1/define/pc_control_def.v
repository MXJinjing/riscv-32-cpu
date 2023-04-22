`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/22 00:27:28
// Design Name: 
// Module Name: pc_control_def
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

`define PC_NEXT                 3'b000

//-=-=-=-=-=-=-Branches-=-=-=-=-=-=-=-
`define PC_CONTROL_BRANCH       3'b001          //branch

//-=-=-=-=-=-=-Jumps-=-=-=-=-=-=-=-=-=-
`define PC_CONTROL_JAL          3'b100          //jump and link
`define PC_CONTROL_JALR         3'b110          //jump and link register

