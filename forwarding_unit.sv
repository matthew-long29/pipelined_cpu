`timescale 1ns / 1ps

module forwarding_unit(
    input logic ex_mem_regwrite,
    input logic mem_wb_regwrite,
    input logic [4:0] ex_reg1,
    input logic [4:0] ex_reg2,
    input logic [4:0] ex_mem_reg_rd,
    input logic [4:0] mem_wb_reg_rd,
    output logic [1:0] forward_a,
    output logic [1:0] forward_b
    );
    
    always_comb begin

        forward_a = 2'b00;
        forward_b = 2'b00;
        
        if(ex_mem_regwrite && ex_mem_reg_rd == ex_reg1) begin
            forward_a = 2'b10;
        end else if(mem_wb_regwrite && mem_wb_reg_rd == ex_reg1) begin
            forward_a = 2'b01;
        end
        
        if(ex_mem_regwrite && ex_mem_reg_rd == ex_reg2) begin
            forward_b = 2'b10;
        end else if(mem_wb_regwrite && mem_wb_reg_rd == ex_reg2) begin
            eforward_b = 2'b01;
        end
        
    end
endmodule
