
//-=-=-=-=-=-Logical-=-=-=-=-=-
`define ALU_CONTROL_ADD         5'b00000       //addition
`define ALU_CONTROL_SUB         5'b00001       //subtraction

//-=-=-=-=-Arithmetic-=-=-=-=-=-
`define ALU_CONTROL_AND         5'b00010       //and
`define ALU_CONTROL_OR          5'b00011       //or
`define ALU_CONTROL_XOR         5'b00100       //xor
`define ALU_CONTROL_NOR         5'b00101       //nor

//-=-=-=-=-=-Compare-=-=-=-=-=-
`define ALU_CONTROL_SLT         5'b00110       //set less than
`define ALU_CONTROL_SLTU        5'b00111       //set less than unsigned

//-=-=-=-=-=-Shift-=-=-=-=-=-=-
`define ALU_CONTROL_SLL         5'b01000       //shift left logical
`define ALU_CONTROL_SRL         5'b01001       //shift right logical
`define ALU_CONTROL_SRA         5'b01010       //shift right arithmetic

//-=-=-=-=-=-Branches-=-=-=-=-=-
`define ALU_CONTROL_BEQ         5'b10000          //branch if equal
`define ALU_CONTROL_BNE         5'b11000          //branch if not equal
`define ALU_CONTROL_BLT         5'b11100          //branch if less than (same code as SLT)
`define ALU_CONTROL_BGE         5'b10110          //branch if greater than
`define ALU_CONTROL_BLTU        5'b10011          //branch if less than unsigned
`define ALU_CONTROL_BGEU        5'b11001          //branch if greater than unsigned

//-=-=-=-=-LOAD AND SAVE-=-=-=-=-
