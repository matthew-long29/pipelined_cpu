`timescale 1ns / 1ps 

module instruction_memory (
    input clk,
    input [31:0] pc,
    output logic [31:0] instruction_code
);
    logic [7:0] memory [108 : 0]; 
    
    //Read in program from file
    
    assign instruction_code = {memory[pc + 3], memory[pc + 2], memory[pc + 1], memory[pc]};

endmodule
