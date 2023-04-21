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

//-=-=-=-=-=-SRC-=-=-=-=-=-=-=-
`define IMM_OP        7'b0010011
`define REG_OP        7'b0110011

//-=-=-=-=-=-Shifts-=-=-=-=-=-
`define SLL         3'b001              //shift left logical
`define SR          3'b101              //shift right

`define SRL_F7      7'b0000000          //shift right logical
`define SRA_F7      3'b0100000          //shift right arithmetic

//-=-=-=-=-Arithmetic-=-=-=-=-
`define ADD         3'b000              //addition
`define SUB         3'b000              //subtraction
    
`define LUI_OP      7'b0110111          //load upper immediate
`define AUIPC_OP    7'b0010111          //add upper immediate to pc

//-=-=-=-=-=-Logical-=-=-=-=-=-
`define XOR         3'b100              //exclusive or
`define OR          3'b110              //or
`define AND         3'b111              //and

//-=-=-=-=-=-Compare-=-=-=-=-=-
`define SLT         3'b010              //set less than
`define SLTU        3'b011              //set less than unsigned

//-=-=-=-=-=-Branches-=-=-=-=-=-
`define BRANCH_OP   7'b1100011          
`define BEQ         3'b000              //branch equal
`define BNE         3'b001              //branch not equal
`define BLT         3'b110              //branch less than
`define BGE         3'b101              //branch greater than
`define BLTU        3'b110              //branch less than unsigned
`define BGEU        3'b111              //branch greater than unsigned

//-=-=-=-JUMPS AND LINKS-=-=-=-=-
`define JAL         7'b1101111          //jump and link
`define JALR        7'b1100111          //jump and link register

//-=-=-=-=-=-=-Synch-=-=-=-=-=-=-
`define SYNCH_OP    7'b0001111
`define FENCH       7'b0001111          //fence
`define FENCHI      7'b0001111          //fencei

//-=-=-=-=-Environment-=-=-=-=-=-
`define ENV_OP      7'b1110011
`define ECALL_IMM   12'b000000000000    //environment call
`define EBREAK_IMM  12'b000000000001    //environment break

//-=-=-Control Status Register-=-
`define CSR_OP      7'b1110011          
`define CSRRW       3'b001              //control status register read/write
`define CSRRS       3'b010              //control status register read/set
`define CSRRC       3'b011              //control status register read/clear
`define CSRRWI      3'b100              //control status register read/write immediate
`define CSRRSI      3'b110              //control status register read/set immediate
`define CSRRCI      3'b111              //control status register read/clear immediate

//-=-=-=-=-=-=-Loads-=-=-=-=-=-=-
`define LOAD_OP     7'b0000011
`define LB          3'b000              //load byte
`define LH          3'b001              //load halfword
`define LW          3'b010              //load word
`define LBU         3'b100              //load byte unsigned
`define LHU         3'b101              //load halfword unsigned

//-=-=-=-=-=-Stores-=-=-=-=-=-=-
`define STORE_OP    7'b0100011
`define SB          3'b000              //store byte
`define SH          3'b001              //store halfword
`define SW          3'b010              //store word