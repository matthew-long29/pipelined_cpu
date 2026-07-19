`timescale 1ns / 1ps

module fetch_unit(
    input clk,
    input reset,
    input stall,
    input branch,
    input [31:0] branch_addr,
    output logic [31:0] instruction_addr
    );
    
    logic [31:0] pc_d, pc_q;
    
    assign instruction_addr = pc_q;
    always_ff @(posedge clk) begin
        if (reset) begin
            pc_q <= 32'b0;
        end else if (stall) begin
            pc_q <= pc_q;
        end else begin
            pc_q <= pc_d;
        end      
    end
    
    always_comb begin
        case (branch)
            0: begin
                pc_d = pc_q + 4;
            end
            1: begin
                pc_d = branch_addr;
            end
        endcase
    end
    
endmodule
