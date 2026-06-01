`timescale 1ns / 1ps

module id_ex_reg(
    input clk,
    input reset,
    input [31:0] pc_i,
    input [31:0] read_data1_i,
    input [31:0] read_data2_i,
    input [31:0] immediate_i,
    input [4:0] rs_i,
    input [4:0] rt_i,
    input [4:0] rd_i,
    input ALUsrc_i,
    input [2:0] ALUop_i,
    input regdst_i,
    input memwrite_i,
    input memread_i,
    input memtoreg_i,
    input regwrite_i,
    output logic [31:0] pc_o,
    output logic [31:0] read_data1_o,
    output logic [31:0] read_data2_o,
    output logic [31:0] immediate_o,
    output logic [4:0] rs_o,
    output logic [4:0] rt_o,
    output logic [4:0] rd_o,
    output logic ALUsrc_o,
    output logic [2:0] ALUop_o,
    output logic regdst_o,
    output logic memwrite_o,
    output logic memread_o,
    output logic memtoreg_o,
    output logic regwrite_o
    );
    
    always @(posedge clk) begin
        if (reset) begin
            pc_o <= 32'b0;
            read_data1_o <= 32'b0;
            read_data2_o <= 32'b0;
            immediate_o <= 32'b0;
            rs_o <= 5'b0;
            rt_o <= 5'b0;
            rd_o <= 5'b0;
            ALUsrc_o <= 1'b0;
            ALUop_o <= 3'b0;
            regdst_o <= 1'b0;
            memwrite_o <= 1'b0;
            memread_o <= 1'b0;
            memtoreg_o <= 1'b0;
            regwrite_o <= 1'b0; 
        end else begin
            pc_o <= pc_i;
            read_data1_o <= read_data1_i;
            read_data2_o <= read_data2_i;
            immediate_o  <= immediate_i;
            rs_o <= rs_i;
            rt_o <= rt_i;
            rd_o <= rd_i;
            ALUsrc_o <= ALUsrc_i;
            ALUop_o <= ALUop_i;
            regdst_o <= regdst_i;
            memwrite_o <= memwrite_i;
            memread_o <= memread_i;
            memtoreg_o <= memtoreg_i;
            regwrite_o <= regwrite_i;
        end
    end
    
endmodule
