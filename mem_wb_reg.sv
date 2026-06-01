`timescale 1ns / 1ps

module mem_wb_reg(
    input clk,
    input reset,
    input [31:0] ALUresult_i,
    input [31:0] mem_data_i,
    input regwrite_i,
    input memtoreg_i,
    output logic [31:0] ALUresult_o,
    output logic [31:0] mem_data_o,
    output logic regwrite_o,
    output logic memtoreg_o
    );
    always @(posedge clk) begin
        if (reset) begin
            ALUresult_o <= 32'b0;
            mem_data_o <= 32'b0;
            regwrite_o <= 1'b0;
            memtoreg_o <= 1'b0;
        end else begin
            ALUresult_o <= ALUresult_i;
            mem_data_o <= mem_data_i;
            regwrite_o <= regwrite_i;
            memtoreg_o <= memtoreg_i;
        end
    end
    
endmodule
