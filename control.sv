`timescale 1ns / 1ps

module control(
    input [5:0] opcode,
    output logic regdst,
    output logic jump,
    output logic branch,
    output logic memread,
    output logic memtoreg,
    output logic [2:0] ALUop,
    output logic memwrite,
    output logic ALUsrc,
    output logic regwrite
    );
    always_comb begin
        regdst = 0;
        jump = 0;
        branch = 0;
        memread = 0;
        memtoreg = 0;
        ALUop = 3'b000;
        memwrite = 0;
        ALUsrc = 0;
        regwrite = 0;
        
        case(opcode)
            6'b000000: begin // R-type
                regdst   = 1;
                regwrite = 1;
                ALUop    = 3'b010;
                end
            6'b100011: begin // lw
                memread  = 1;
                memtoreg = 1;
                ALUsrc   = 1;
                regwrite = 1;
                ALUop    = 3'b000;
            end
            6'b101011: begin // sw
                memwrite = 1;
                ALUsrc   = 1;
                ALUop    = 3'b000;
            end
            6'b000100: begin // beq
                branch   = 1;
                ALUop    = 3'b001;
            end
            6'b000010: begin // j
                jump     = 1;
            end
            6'b001000: begin // addi
                ALUsrc   = 1;
                regwrite = 1;
                ALUop    = 3'b000;
            end
            default: begin
                regdst = 0; 
                jump = 0;
                memread = 0;
                memtoreg = 0; 
                ALUsrc = 0; 
                regwrite = 0;
                ALUop = 3'b000;
            end
            
        endcase
    end
    
    
endmodule
