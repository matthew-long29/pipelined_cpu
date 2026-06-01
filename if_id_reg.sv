`timescale 1ns / 1ps

module if_id_reg(
    input clk,
    input reset,
    input hazard,
    input [31:0] instruction_code_i,
    input [31:0] pc_i,
    output logic [31:0] instruction_code_o,
    output logic [31:0] pc_o
    );
    always @(posedge clk) begin
        //Stall register if hazard
        if (reset) begin
            instruction_code_o <= 32'b0;
            pc_o <= 32'b0;
        end
        else if (hazard) begin
            instruction_code_o <= instruction_code_o;
            pc_o <= pc_o;
        end
        //Otherwise pass value
        else begin
            instruction_code_o <= instruction_code_i;
            pc_o <= pc_i;
        end
    end
endmodule
