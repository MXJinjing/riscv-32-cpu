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
        output wire         im_wait_sig,           // ָ��洢���ĵȴ��ź�
        output wire[31:0]   return_addr            // ���ص�ַ��д�����Ĵ�����
    );
    
    reg[2:0]      start_sig;
    reg           im_wait;

    reg[31:0]  pc_reg;          // ����������ļĴ�����ָ����һ��ָ�
    wire[31:0]  pc_add_4;       // pc + 4
    assign pc = pc_reg;
    assign pc_add_4 = pc_reg + 32'd4;
    
    always @ (posedge clk) begin    // ��CPUʱ��������ʱ�����³��������
        if(!rst)begin   // �����ź�Ϊ1ʱ���������������
            pc_reg <= 32'h00000000;
            start_sig <= 2'b00;
        end else if(start_sig == 2'b00) begin
            start_sig <= 2'b01;
        end else begin
            if (start_sig == 2'b01) begin
                start_sig <= 2'b10;
            end

            case (PC_control_sig)   // ���ݿ����źţ����³��������
                 `PC_CONTROL_BRANCH:begin     // ��ָ֧��
                     pc_reg <= ALU_result[0] ? pc_reg  -32'd4 + offset   : pc_add_4; // ����ALU�����������ж��Ƿ���ת
                     im_wait <= ALU_result ? `IM_WAIT : `IM_NO_WAIT;             // �����ת���ȴ�ָ��洢���������ͣתһ������
                 end
                 `PC_CONTROL_JALR:begin      // JALRָ��
                     pc_reg <= (ALU_result ) & 32'hfffffffe;     // �����λ���㣬д����������
                     im_wait <= `IM_WAIT ;
                 end
                 `PC_CONTROL_JAL:begin       // JALָ��
                     pc_reg <= ALU_result;                       // ��ALU��������д����������
                     im_wait <= `IM_WAIT ;
                 end
                 default:begin               // ����ָ����ź�Ϊȫ0��
                     pc_reg <= pc_add_4;  // ���start�ź�Ϊ1����pc+4д����������       
                     im_wait <= `IM_NO_WAIT;               
                 end
             endcase
        end
    end

    assign im_wait_sig =  (start_sig[0]) ?  `IM_WAIT :  im_wait;               

    // ���ݿ����źţ��������������ֵ������Ĵ�������ѡ����
    assign return_addr = (PC_control_sig == `PC_CONTROL_JALR)? pc_reg:
                      (PC_control_sig == `PC_CONTROL_JAL)? pc_reg : 32'b0;
    
    initial begin
        start_sig = 2'b00;
        pc_reg = 32'h00000000;
        im_wait = `IM_NO_WAIT;
    end
endmodule
