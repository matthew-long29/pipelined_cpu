`timescale 1ns / 1ps

module register_file(
    input clk,
    input reset,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    input write_en,
    output logic [31:0] read_data1,
    output logic [31:0] read_data2
    );
    logic [31:0] reg_file [31:0];
    
    always_ff @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < 32; i++) begin
                reg_file[i] = 32'b0;
            end
        end
        if (write_en && write_reg != 5'b0) begin
            reg_file[write_reg] <= write_data;
        end     
    end
    assign read_data1 = (read_reg1 == 0)? 0 : reg_file[read_reg1];  
    assign read_data2 = (read_reg1 == 0)? 0 : reg_file[read_reg2];
    
endmodule
