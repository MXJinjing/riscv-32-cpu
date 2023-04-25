`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/25 13:58:18
// Design Name: 
// Module Name: Memory_manager_tb
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

module Menmory_manager_tb;

    // Inputs
    reg cpu_clk;
    reg rst;
    reg[2:0] ram_control_sig;
    reg[31:0] mem_addr;
    reg[31:0] savedata;

    // Outputs
    wire[31:0] loaddata;
    wire[31:0] address;
    wire[31:0] debug;
    wire[31:0] counter;
    wire[31:0] status;
    wire[31:0] _douta;
    wire[31:0] _addra;
    wire       mem_clk;
    wire txcpu_clk;
    wire[2:0] ram_control_sig_reg;

    // Instantiate the Unit Under Test (UUT)
    Menmory_manager uut (
        .cpu_clk(cpu_clk),
        .rst(rst),
        .ram_control_sig(ram_control_sig),
        .mem_addr(mem_addr),
        .savedata(savedata),
        .loaddata(loaddata),
        .debug(debug),
        .debug2(counter),
        .debug3(status),
        .debug4(_douta),
        .debug5(_addra),
        .debug6(address),
        .debug7(ram_control_sig_reg),
        .mem_clk(mem_clk),
        .tx_clk(txcpu_clk)
    );

    initial begin
        // Initialize Inputs
        cpu_clk <= 0;
        rst <= 1;


        // Wait 10 ns for global reset to finish
        #10;
        ram_control_sig <= 3'b010;
        mem_addr <= 32'h00000001;
        savedata <= 32'hEEEEEEEE;

        // Stimulus for half word load at address 0

        #10;
    end
    
    always #0.5 begin
        cpu_clk = ~cpu_clk;  
        mem_addr = mem_addr + 1;
    end

endmodule