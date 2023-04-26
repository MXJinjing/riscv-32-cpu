`define MEM_WRITE_ENABLE  1'b1
`define MEM_WRITE_DISABLE  1'b0

`define MEM_READ_ENABLE  1'b1
`define MEM_READ_DISABLE  1'b0

`define LOAD_WORD  3'b001
`define LOAD_HALF_WORD  3'b010
`define LOAD_BYTE  3'b011

`define STORE_WORD  3'b101
`define STORE_HALF_WORD  3'b110
`define STORE_BYTE  3'b111

`define SPARE  3'b000

`define BUSY 1'b1
`define IDLE 1'b0