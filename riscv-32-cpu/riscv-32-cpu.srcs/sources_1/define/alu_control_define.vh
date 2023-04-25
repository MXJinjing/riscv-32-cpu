
//-=-=-=-=-=-Logical-=-=-=-=-=-
`define ALU_ADD         5'b00111       //addition
`define ALU_SUB         5'b01111       //subtraction

//-=-=-=-=-Arithmetic-=-=-=-=-=-
`define ALU_AND         5'b00010       //and
`define ALU_OR          5'b00011       //or
`define ALU_XOR         5'b00100       //xor
`define ALU_NOR         5'b00101       //nor

//-=-=-=-=-=-Compare-=-=-=-=-=-
`define ALU_SLT         5'b00110       //set less than
`define ALU_SLTU        5'b00111       //set less than unsigned

//-=-=-=-=-=-Shift-=-=-=-=-=-=-
`define ALU_SLL         5'b01000       //shift left logical
`define ALU_SRL         5'b01001       //shift right logical
`define ALU_SRA         5'b01010       //shift right arithmetic

//-=-=-=-=-=-Branches-=-=-=-=-=-
`define ALU_BEQ         5'b10000          //branch if equal
`define ALU_BNE         5'b10001          //branch if not equal
`define ALU_BLT         5'b10010          //branch if less than (same code as SLT)
`define ALU_BGE         5'b10011          //branch if greater than
`define ALU_BLTU        5'b10100          //branch if less than unsigned
`define ALU_BGEU        5'b10101          //branch if greater than unsigned

//-=-=-=-=-LOAD AND SAVE-=-=-=-=-
`define ALU_OFFSET      5'b11100          //calculate the offset
