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
        input wire          clk,                   // ʱ���ź�
        input wire          rst,                   // �����ź�
        input wire[2:0]     PC_control_sig,        // ��������������ź�
        input wire[31:0]    offset,
        input wire[31:0]    ALU_result,            // ALU���������������˷�֧���жϽ�����Լ�JALR��JAL�Ľ����

        output wire[31:0]   pc,                    // ����ĳ��������ֵ
        output reg          im_wait_sig,           // ָ��洢���ĵȴ��ź�
        output wire[31:0]   return_addr            // ���ص�ַ��д�����Ĵ�����
    );
             

    reg[31:0]  pc_reg;          // ����������ļĴ�����ָ����һ��ָ�
    wire[31:0]  pc_add_4;       // pc + 4

    assign pc = pc_reg;
    assign pc_add_4 = pc_reg + 32'd4;
    
    always @ (posedge clk) begin    // ��CPUʱ��������ʱ�����³��������
        if(!rst)begin   // �����ź�Ϊ1ʱ���������������
            pc_reg <= 32'd0;
            im_wait_sig <= `IM_NO_WAIT;
        end else
        case (PC_control_sig)   // ���ݿ����źţ����³��������
            `PC_CONTROL_BRANCH:begin     // ��ָ֧��
                pc_reg <= ALU_result[0] ? pc_reg  -32'd4 + offset   : pc_add_4; // ����ALU�����������ж��Ƿ���ת
                im_wait_sig <= ALU_result ? `IM_WAIT : `IM_NO_WAIT;             // �����ת���ȴ�ָ��洢���������ͣתһ������
            end
            `PC_CONTROL_JALR:begin      // JALRָ��
                pc_reg <= (ALU_result ) & 32'hfffffffe;     // �����λ���㣬д����������
                im_wait_sig <= `IM_WAIT ;                   // �ȴ�ָ��洢���������ͣתһ������
            end
            `PC_CONTROL_JAL:begin       // JALָ��
                pc_reg <= ALU_result;                       // ��ALU��������д����������
                im_wait_sig <= `IM_WAIT;                    // �ȴ�ָ��洢���������ͣתһ������
            end
            default:begin               // ����ָ����ź�Ϊȫ0��
                pc_reg <= pc_add_4;                         
                im_wait_sig <= `IM_NO_WAIT;                 // ���ȴ�ָ��洢�����������������
            end
        endcase
    end

    // ���ݿ����źţ��������������ֵ������Ĵ�������ѡ����
    assign return_addr = (PC_control_sig == `PC_CONTROL_JALR)? pc_reg:
                      (PC_control_sig == `PC_CONTROL_JAL)? pc_reg : 32'b0;
    
    initial begin
        pc_reg = 32'b0;
        im_wait_sig <= `IM_NO_WAIT;
    end
endmodule
