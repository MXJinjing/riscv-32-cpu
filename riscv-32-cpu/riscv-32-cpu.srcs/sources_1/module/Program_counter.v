`timescale 1ns / 1ps
`include "../define/pc_control_define.vh"
`include "../define/im_wait_define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/22 00:31:55
// Design Name: 
// Module Name: Program Counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Program Counter, used to store the address of the next instruction
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Program_counter(
        input wire          clk,                   // 时钟信号
        input wire          rst,                   // 重置信号
        input wire[2:0]     PC_control_sig,        // 程序计数器控制信号
        input wire[31:0]    offset,
        input wire[31:0]    ALU_result,            // ALU的运算结果（包含了分支的判断结果、以及JALR、JAL的结果）

        output wire[31:0]   pc,                    // 输出的程序计数数值
        output wire         im_wait_sig,           // 指令存储器的等待信号
        output wire[31:0]   return_addr            // 返回地址（写入至寄存器）
    );
    
    reg[2:0]      start_sig;
    reg           im_wait;

    reg[31:0]  pc_reg;          // 程序计数器的寄存器（指向下一条指令）
    wire[31:0]  pc_add_4;       // pc + 4
    assign pc = pc_reg;
    assign pc_add_4 = pc_reg + 32'd4;
    
    always @ (posedge clk) begin    // 在CPU时钟上升沿时，更新程序计数器
        if(!rst)begin   // 重置信号为1时，程序计数器清零
            pc_reg <= 32'h00000000;
            start_sig <= 2'b00;
        end else if(start_sig == 2'b00) begin
            start_sig <= 2'b01;
        end else begin
            if (start_sig == 2'b01) begin
                start_sig <= 2'b10;
            end

            case (PC_control_sig)   // 根据控制信号，更新程序计数器
                 `PC_CONTROL_BRANCH:begin     // 分支指令
                     pc_reg <= ALU_result[0] ? pc_reg  -32'd4 + offset   : pc_add_4; // 根据ALU的运算结果，判断是否跳转
                     im_wait <= ALU_result ? `IM_WAIT : `IM_NO_WAIT;             // 如果跳转，等待指令存储器的输出，停转一个周期
                 end
                 `PC_CONTROL_JALR:begin      // JALR指令
                     pc_reg <= (ALU_result ) & 32'hfffffffe;     // 将最低位置零，写入程序计数器
                     im_wait <= `IM_WAIT ;
                 end
                 `PC_CONTROL_JAL:begin       // JAL指令
                     pc_reg <= ALU_result;                       // 将ALU的运算结果写入程序计数器
                     im_wait <= `IM_WAIT ;
                 end
                 default:begin               // 其他指令（如信号为全0）
                     pc_reg <= pc_add_4;  // 如果start信号为1，将pc+4写入程序计数器       
                     im_wait <= `IM_NO_WAIT;               
                 end
             endcase
        end
    end

    assign im_wait_sig =  (start_sig[0]) ?  `IM_WAIT :  im_wait;               

    // 根据控制信号，将程序计数器的值传输给寄存器数据选择器
    assign return_addr = (PC_control_sig == `PC_CONTROL_JALR)? pc_reg:
                      (PC_control_sig == `PC_CONTROL_JAL)? pc_reg : 32'b0;
    
    initial begin
        start_sig = 2'b00;
        pc_reg = 32'h00000000;
        im_wait = `IM_NO_WAIT;
    end
endmodule
