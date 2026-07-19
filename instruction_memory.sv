`timescale 1ns / 1ps 

module instruction_memory (
    input clk,
    input reset,
    input [31:0] instruction_addr,
    output logic [31:0] instruction_code
);
    logic [7:0] memory [108 : 0]; 
    
    //Read in program from file
    
    assign instruction_code = {memory[instruction_addr + 3], memory[instruction_addr + 2], memory[instruction_addr + 1], memory[instruction_addr]};

endmodule
