`timescale 1ns / 1ps

module hazard_detection(
    input [4:0] id_reg1,
    input [4:0] id_reg2,
    input ex_memread,
    input [4:0] ex_write_reg,
    input mem_memread,
    input [4:0] mem_write_reg,
    output logic stall
    );
    
    always_comb begin
        stall = 0;
        
        if (ex_memread && (ex_write_reg == id_reg1 || ex_write_reg == id_reg2) ) begin
           stall = 1;
        end 
        else if (mem_memread && (mem_write_reg == id_reg1 || mem_write_reg == id_reg2) ) begin
           stall = 1;
        end
    end
endmodule
