`timescale 1ns / 1ps
`include "../define/ram_control_define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/25 11:24:39
// Design Name: 
// Module Name: Menmory_manager
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


module Menmory_manager(
        input wire cpu_clk,       // CPU clock
        input wire rst,
        input wire[2:0]           ram_control_sig,    // Memory control signal

        input wire[31:0]          mem_addr,           // Memory address
        input wire[31:0]          savedata,
        output reg[31:0]          loaddata,

        output reg[31:0]          debug,              // debug
        output wire[31:0]          debug2,
        output wire[31:0]          debug3,
        output wire[31:0]          debug4,
        output wire[31:0]          debug5,
        output wire[31:0]          debug6,
        output wire[31:0]          debug7,
        output mem_clk,
        output tx_clk
    );

    wire mem_clk;
    wire tx_clk;
    // generate a new clock
    Frequency_multiplier_4x f4(
        .clk(cpu_clk),
        .rst(rst),
        .clk_out(mem_clk)
    );

    Frequency_multiplier_2x f2(
        .clk(cpu_clk),
        .rst(rst),
        .clk_out(tx_clk)
    );

    wire _wea;
    wire[31:0] _addra;
    wire[7:0] _dina;
    wire[7:0] _douta;

    // generate a new memmory
    blk_mem_gen_1 mem(  
        .clka(mem_clk),
        .wea(_wea),
        .addra(_addra),
        .dina(_dina),
        .douta(_douta)
    );

    // set whether the memory is to be written
    assign _wea = (ram_control_sig == `RAM_STORE_BYTE) || (ram_control_sig == `RAM_STORE_HALF_WORD) || (ram_control_sig == `RAM_STORE_WORD) ? 1'b1 : 1'b0;

    reg[1:0]        counter;    //counter for store word
    reg             status;     //status of the memory: busy or idle
    reg[2:0]        ram_control_sig_reg;    // to sign which instruction is executed

    reg[31:0]       address;          // calculate the address of the memory
    
    assign _addra = address[8:0];    // set the address of the memory
    assign debug2 = counter;
    assign debug3 = status;
    assign debug4 = _douta;
    assign debug5 = _addra;
    assign debug6 = address;
    assign debug7 = ram_control_sig_reg;

    always @(mem_addr) address <= mem_addr[31:0];
    always @(ram_control_sig) ram_control_sig_reg <= ram_control_sig;

    //set status of the memory: busy or idle
    always @(posedge cpu_clk) begin
        counter <= 0;
        if(status == `RAM_BUSY) begin
            debug <= 1;
        end
    end

    assign load_byte = (ram_control_sig_reg == `RAM_LOAD_BYTE) ? 1'b1 : 1'b0;
    assign load_half_word = (ram_control_sig_reg == `RAM_LOAD_HALF_WORD) ? 1'b1 : 1'b0;
    assign load_word = (ram_control_sig_reg == `RAM_LOAD_WORD) ? 1'b1 : 1'b0;

    //load byte from memory
    always @(negedge mem_clk && tx_clk == 1  && status == `RAM_IDLE || status == `RAM_BUSY) begin   //when the memory is busy, the instruction will be executed
        if(load_byte) begin
            status <= `RAM_BUSY;        //set the status of the memory to busy
            loaddata <= _douta[7:0];
            loaddata[31:16] <= {16{loaddata[7]}};        //sign extension
            ram_control_sig_reg <= `RAM_SPARE;
            status <= `RAM_IDLE;        //set the status of the memory to idle
        end else if(load_half_word) begin  
            status <= `RAM_BUSY;
            case(counter)                               // load the data from memory, and sign extension
                2'b00: loaddata[7:0] <= _douta[7:0];     // the first cycle, load the lower 8 bits
                2'b01: loaddata[15:8] <= _douta[7:0];    // the second cycle, load the higher 8 bits
            endcase

            if(counter == 2'b10) begin
                loaddata[31:16] <= {16{loaddata[15]}};    //sign extension
                ram_control_sig_reg <= `RAM_SPARE;
                status <= `RAM_IDLE;
            end else begin
                counter <= counter + 1;
                address <= mem_addr + counter;
            end 

        end else if(load_word) begin  
            status <= `RAM_BUSY;
            case(counter)                               // load the data from memory
                2'b00: loaddata[7:0] <= _douta[7:0];
                2'b01: loaddata[15:8] <= _douta[7:0];
                2'b10: loaddata[23:16] <= _douta[7:0];
                2'b11: loaddata[31:24] <= _douta[7:0];
            endcase

            if(counter == 2'b11) begin
                ram_control_sig_reg <= `RAM_SPARE;
                status <= `RAM_IDLE;
            end else begin
                counter <= counter + 1;
                address <= mem_addr + counter;
            end 
        end
    end

    initial begin
        ram_control_sig_reg <= 0;
        status <= 0;
        counter <= 0;
    end
endmodule
