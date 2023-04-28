`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/26 20:31:11
// Design Name: 
// Module Name: Data_memory_tb
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

`timescale 1ns / 1ps


module Data_memory_tb;

    // Inputs
    reg clk;
    reg mem_write_sig;
    reg mem_read_sig;
    reg [31:0] mem_addr;
    reg [31:0] mem_write_data;
    reg        mem_write_sig;

    // Outputs
    wire mem_clk;
    wire [31:0] mem_read_data;
    wire [31:0] _addr;
    wire [31:0] _write_data;
    wire _wea;
    wire _read_status;
    wire _write_status;

    // Instantiate the module under test
    Data_memory dut (
        .clk(clk),
        .mem_write_sig(mem_write_sig),
        .mem_read_sig(mem_read_sig),
        .mem_addr(mem_addr),
        .mem_write_data(mem_write_data),

        .mem_clk(mem_clk),
        .mem_read_data(mem_read_data),

        ._addr(_addr),
        ._write_data(_write_data),
        ._wea(_wea),
        ._read_status(_read_status),
        ._write_status(_write_status)
    );



    // Clock generation
    initial clk = 1;
    always #0.5 clk = ~clk;

    // Stimulus
    initial begin
        // Initialize Inputs
        mem_write_sig = 0;
        mem_read_sig = 0;
        mem_addr = 0;
        mem_write_data = 0;

        #1
        // Write to memory location 0x00000000
        mem_addr = 32'h00000000;
        mem_write_sig = 1;
        mem_write_data = 32'h12345678;
        #1;
        mem_write_sig = 0;

        // Read from memory location 0x00000000
        mem_addr = 32'h00000000;
        mem_read_sig = 1;
        #1;
        mem_read_sig = 0;

        // Write to memory location 0x00000004
        mem_addr = 32'h00000004;
        mem_write_sig = 1;
        mem_write_data = 32'habcdef01;
        #1;
        mem_write_sig = 0;

        // Read from memory location 0x00000004
        mem_addr = 32'h00000004;
        mem_read_sig = 1;
        #1;
        mem_read_sig = 0;

        #2;
        // End simulation
        $finish;
    end

endmodule
