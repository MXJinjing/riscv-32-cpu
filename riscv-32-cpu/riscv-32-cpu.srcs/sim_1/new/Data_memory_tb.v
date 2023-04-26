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

    // Outputs
    wire [31:0] mem_read_data;

    // Instantiate the module under test
    Data_memory dut (
        .clk(clk),
        .mem_write_sig(mem_write_sig),
        .mem_read_sig(mem_read_sig),
        .mem_addr(mem_addr),
        .mem_write_data(mem_write_data),
        .mem_read_data(mem_read_data)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        // Write to memory location 0x00000000
        mem_addr = 32'h00000000;
        mem_write_sig = 1;
        mem_write_data = 32'h12345678;
        #10;
        mem_write_sig = 0;
        #10;

        // Read from memory location 0x00000000
        mem_addr = 32'h00000000;
        mem_read_sig = 1;
        #10;
        mem_read_sig = 0;
        #10;

        // Write to memory location 0x00000004
        mem_addr = 32'h00000004;
        mem_write_sig = 1;
        mem_write_data = 32'habcdef01;
        #10;
        mem_write_sig = 0;
        #10;

        // Read from memory location 0x00000004
        mem_addr = 32'h00000004;
        mem_read_sig = 1;
        #10;
        mem_read_sig = 0;
        #10;

        // End simulation
        $finish;
    end

endmodule
