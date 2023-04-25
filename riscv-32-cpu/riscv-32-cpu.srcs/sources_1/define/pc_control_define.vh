
`define PC_NEXT                 3'b000

//-=-=-=-=-=-=-Branches-=-=-=-=-=-=-=-
`define PC_CONTROL_BRANCH       3'b001          //branch

//-=-=-=-=-=-=-Jumps-=-=-=-=-=-=-=-=-=-
`define PC_CONTROL_JAL          3'b100          //jump and link
`define PC_CONTROL_JALR         3'b110          //jump and link register
`define PC_CONTROL_AUIPC        3'b101          //add upper immediate to pc

