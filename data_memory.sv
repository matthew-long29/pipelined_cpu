`timescale 1ns / 1ps 

module data_memory (
    input clk,
    input reset,
    input [31:0] address,
    input [31:0] write_data,
    input write_en,
    output logic [31:0] read_data
);
    logic [31:0] data_mem [31:0];
    always_ff @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < 32; i++) begin
                data_mem[i] = 32'b0;
            end
        end
        else if (write_en) begin
            data_mem[address] <= write_data;
        end
        
        read_data <= data_mem[address];
    end
   
    
endmodule