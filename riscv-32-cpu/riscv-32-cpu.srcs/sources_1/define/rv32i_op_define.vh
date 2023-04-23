//Opcode:     XX_OP
//Funct3:     XX_F3    
//Funct7:     XX_F7

//-=-=-=-=-=-SRC-=-=-=-=-=-=-=-
`define IMM_ALU_OP        7'b0010011       //aka I-type
`define REG_ALU_OP        7'b0110011       //aka R-type

//-=-=-=-=-=-Shifts-=-=-=-=-=-
`define SLL_F3         3'b001              //shift left logical
`define SR_F3          3'b101              //shift right

`define SRL_F7      7'b0000000             //shift right logical
`define SRA_F7      3'b0100000             //shift right arithmetic

//-=-=-=-=-Arithmetic-=-=-=-=-
`define ADD_F3         3'b000              //addition
`define SUB_F3         3'b000              //subtraction
`define SUB_CST        7'b0100000          //subtraction constant
    
`define LUI_OP      7'b0110111             //load upper immediate
`define AUIPC_OP    7'b0010111             //add upper immediate to pc

//-=-=-=-=-=-Logical-=-=-=-=-=-
`define XOR_F3         3'b100              //exclusive or
`define OR_F3          3'b110              //or
`define AND_F3         3'b111              //and

//-=-=-=-=-=-Compare-=-=-=-=-=-
`define SLT_F3         3'b010              //set less than
`define SLTU_F3        3'b011              //set less than unsigned

//-=-=-=-=-=-Branches-=-=-=-=-=-
`define BRANCH_OP   7'b1100011          
`define BEQ_F3         3'b000              //branch equal
`define BNE_F3         3'b001              //branch not equal
`define BLT_F3         3'b110              //branch less than
`define BGE_F3         3'b101              //branch greater than
`define BLTU_F3        3'b110              //branch less than unsigned
`define BGEU_F3        3'b111              //branch greater than unsigned

//-=-=-=-JUMPS AND LINKS-=-=-=-=-
`define JAL_OP         7'b1101111          //jump and link
`define JALR_OP        7'b1100111          //jump and link register

//-=-=-=-=-=-=-Synch-=-=-=-=-=-=-
`define SYNCH_OP       7'b0001111
`define FENCH_F3       7'b0001111          //fence
`define FENCHI_F3      7'b0001111          //fencei

//-=-=-=-=-Environment-=-=-=-=-=-
`define ENV_OP      7'b1110011
`define ECALL_CST   12'b000000000000       //environment call
`define EBREAK_CST  12'b000000000001       //environment break

//-=-=-Control Status Register-=-
`define CSR_OP      7'b1110011          
`define CSRRW_F3       3'b001              //control status register read/write
`define CSRRS_F3       3'b010              //control status register read/set
`define CSRRC_F3       3'b011              //control status register read/clear
`define CSRRWI_F3      3'b100              //control status register read/write immediate
`define CSRRSI_F3      3'b110              //control status register read/set immediate
`define CSRRCI_F3      3'b111              //control status register read/clear immediate

//-=-=-=-=-=-=-Loads-=-=-=-=-=-=-
`define LOAD_OP        7'b0000011
`define LB_F3          3'b000              //load byte
`define LH_F3          3'b001              //load halfword
`define LW_F3          3'b010              //load word
`define LBU_F3         3'b100              //load byte unsigned
`define LHU_F3         3'b101              //load halfword unsigned

//-=-=-=-=-=-Stores-=-=-=-=-=-=-
`define STORE_OP       7'b0100011
`define SB_F3          3'b000              //store byte
`define SH_F3          3'b001              //store halfword
`define SW_F3          3'b010              //store word


//-=-=-=-=-=-Types-=-=-=-=-=-=-
`define R_type
`define I_type
`define S_type
`define B_type
`define U_type
`define J_type