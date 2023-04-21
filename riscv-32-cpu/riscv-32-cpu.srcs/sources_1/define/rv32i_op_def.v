`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 12:06:09
// Design Name: 
// Module Name: rv32i_op_def
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


//Opcode:     XX_OP
//Funct3:     XX    (default)
//Funct7:     XX_F7

//-=-=-=-=-REG OR IMM=-=-=-=-=-
`define IMM_OP        7'b0010011
`define REG_OP        7'b0110011

//-=-=-=-=-=-Shifts-=-=-=-=-=-
`define SLL         3'b001

`define SR          3'b101

`define SRL_F7      7'b0000000
`define SRA_F7      3'b0100000

//-=-=-=-=-Arithmetic-=-=-=-=-
`define ADD         3'b000     
`define SUB         3'b000
    
`define LUI_OP      7'b0110111
`define AUIPC_OP    7'b0010111

//-=-=-=-=-=-Logical-=-=-=-=-=-
`define XOR         3'b100
`define OR          3'b110
`define AND         3'b111

//-=-=-=-=-=-Compare-=-=-=-=-=-
`define SLT         3'b010
`define SLTU        3'b011

//-=-=-=-=-=-Branches-=-=-=-=-=-
`define BRANCH_OP   7'b1100011
`define BEQ         3'b000
`define BNE         3'b001
`define BLT         3'b110
`define BGE         3'b101
`define BLTU        3'b110
`define BGEU        3'b111

//-=-=-=-JUMPS AND LINKS-=-=-=-=-
`define JAL         7'b1101111
`define JALR        7'b1100111

//-=-=-=-=-=-=-Synch-=-=-=-=-=-=-
`define SYNCH_OP    7'b0001111
`define FENCH       7'b0001111
`define FENCHI      7'b0001111

//-=-=-=-=-Environment-=-=-=-=-=-
`define ENV_OP      7'b1110011
`define ECALL       12'b000000000000
`define EBREAK      12'b000000000001

//-=-=-Control Status Register-=-
`define CSR_OP      7'b1110011
`define CSRRW       3'b001
`define CSRRS       3'b010
`define CSRRC       3'b011
`define CSRRWI      3'b100
`define CSRRSI      3'b110
`define CSRRCI      3'b111

//-=-=-=-=-=-=-Loads-=-=-=-=-=-=-
`define LOAD_OP     7'b0000011
`define LB          3'b000
`define LH          3'b001
`define LW          3'b010
`define LBU         3'b100
`define LHU         3'b101

//-=-=-=-=-=-Stores-=-=-=-=-=-=-
`define STORE_op    7'b0100011
`define SB          3'b000
`define SH          3'b001
`define SW          3'b010