`timescale 1ns / 1ps 

module instruction_memory (
    input clk,
    input reset,
    input [31:0] instruction_addr,
    output logic [31:0] instruction_code
);
    logic [7:0] memory [108 : 0]; 
    
    //Read in program from file
    initial begin
        memory[0] = 8'h0a; memory[1] = 8'h00; memory[2] = 8'h01; memory[3] = 8'h20; // addi $1, $0, 10
        memory[4] = 8'h14; memory[5] = 8'h00; memory[6] = 8'h02; memory[7] = 8'h20; // addi $2, $0, 20
        memory[8] = 8'h20; memory[9] = 8'h18; memory[10] = 8'h22; memory[11] = 8'h00; // add  $3, $1, $2
        memory[12] = 8'h22; memory[13] = 8'h20; memory[14] = 8'h41; memory[15] = 8'h00; // sub  $4, $2, $1
        memory[16] = 8'h00; memory[17] = 8'h00; memory[18] = 8'h03; memory[19] = 8'hac; // sw   $3, 0($0)
        memory[20] = 8'h00; memory[21] = 8'h00; memory[22] = 8'h05; memory[23] = 8'h8c; // lw   $5, 0($0)
        memory[24] = 8'h02; memory[25] = 8'h00; memory[26] = 8'h65; memory[27] = 8'h10; // beq  $3, $5, 2
        memory[28] = 8'he7; memory[29] = 8'h03; memory[30] = 8'h06; memory[31] = 8'h20; // addi $6, $0, 999 (skipped)
        memory[32] = 8'he7; memory[33] = 8'h03; memory[34] = 8'h07; memory[35] = 8'h20; // addi $7, $0, 999 (skipped)
        memory[36] = 8'h24; memory[37] = 8'h40; memory[38] = 8'h22; memory[39] = 8'h00; // and  $8, $1, $2  (branch target)
    end
    
    assign instruction_code = {memory[instruction_addr + 3], memory[instruction_addr + 2], memory[instruction_addr + 1], memory[instruction_addr]};

endmodule
