`timescale 1ns / 1ps

module ALU (
    input [31:0] a,
    input [31:0] b,
    input [3:0] control,
    input [4:0] shamt,
    output logic [31:0] result
    );
    
    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;
    localparam ALU_AND  = 4'b0010;
    localparam ALU_OR   = 4'b0011;
    localparam ALU_XOR  = 4'b0100;
    localparam ALU_NOR  = 4'b0101; 
    localparam ALU_SLT  = 4'b0110;
    localparam ALU_SLTU = 4'b0111;
    localparam ALU_SLL  = 4'b1000;
    localparam ALU_SRL  = 4'b1001; 
    localparam ALU_SRA  = 4'b1010;
    
    always_comb begin
        case(control)
            ALU_ADD: result = $signed(a) + $signed(b);

            ALU_SUB: result = $signed(a) - $signed(b);

            ALU_AND: result = a & b;

            ALU_OR: result = a | b;

            ALU_XOR: result = a ^ b;

            ALU_NOR: result = ~(a | b);

            ALU_SLT: result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;

            ALU_SLTU: result = (a < b) ? 32'd1 : 32'd0;

            ALU_SLL: result = a << shamt;

            ALU_SRL: result = a >> shamt;

            ALU_SRA: result = $signed(a) >>> shamt;

            default: result = 0;
            
        endcase

    end

endmodule
