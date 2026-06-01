`timescale 1ns / 1ps

module ALU (
    input [31:0] a,
    input [31:0] b,
    input [2:0] control,
    output logic [31:0] result
    );

    
    always_comb begin
        case(control)
            3'b000: result = $signed(a) + $signed(b);
            
            3'b001: result = $signed(a) - $signed(b); 
            
            3'b010: result = $signed(a) << $b;
            
            3'b011: result = $signed(a) >> $b; 
            
            3'b100: result = a & b;
            
            3'b101: result = a | b;
            
            3'b110: result = a ^ b;
            
            3'b111: result = ~a;
            
            default: result = 0;
            
        endcase

    end

endmodule
