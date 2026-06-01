`timescale 1ns / 1ps

module ex_mem_reg(
    input clk,
    input reset,
    input [31:0] ALUresult_i,
    input [31:0] write_data_i,
    input[4:0] rd_i,
    input memwrite_i,
    input memread_i,
    input memtoreg_i,
    input regwrite_i,
    output logic [31:0] ALUresult_o,
    output logic [31:0] write_data_o,
    output logic [4:0] rd_o,
    output logic memwrite_o,
    output logic memread_o,
    output logic memtoreg_o,
    output logic regwrite_o
    );
    
    always @(posedge clk) begin
        if (reset) begin
            ALUresult_o  <= 32'b0;
            write_data_o  <= 32'b0;
            rd_o          <= 5'b0;
            memwrite_o    <= 1'b0;
            memread_o     <= 1'b0;
            memtoreg_o    <= 1'b0;
            regwrite_o    <= 1'b0;
        end else begin
            ALUresult_o  <= ALUresult_i;
            write_data_o  <= write_data_i;
            rd_o          <= rd_i;
            memwrite_o    <= memwrite_i;
            memread_o     <= memread_i;
            memtoreg_o    <= memtoreg_i;
            regwrite_o    <= regwrite_i;
        
        end
    end
endmodule
