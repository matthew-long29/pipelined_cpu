`timescale 1ns / 1ps

module top(
    input clk,
    input reset,
    output logic y
    );
    //------- IF Stage Signals ---------//
    logic [31:0] pc_if;
    logic [31:0] if_instruction,id_instruction;
    logic [31:0] branch_address;
    logic if_id_hazard;
    logic if_branch;
    logic if_stall;
    //------- ID Stage Signals --------//
    logic [31:0] pc_id;
    logic [4:0] id_reg1, id_reg2, id_reg_rd;
    logic [31:0] id_write_data;
    logic [31:0] id_reg_data1, id_reg_data2;
    logic [5:0] id_opcode;
    logic [4:0]  id_shamt;
    logic [5:0]  id_funct;
    logic [31:0] id_imm_val;
    logic id_regdst, id_jump, id_branch, id_memread, id_memtoreg, id_memwrite, id_regwrite, id_regeq;
    logic [2:0] id_ALUop;
    //------- EX Stage Signals-------//
    logic [31:0] pc_ex;
    logic [4:0] ex_reg1, ex_reg2, ex_reg_rd;
    logic [31:0] ex_write_data;
    logic [31:0] ex_reg_data1, ex_reg_data2;
    logic [5:0] ex_opcode;
    logic [31:0] ex_imm_val;
    logic ex_regdst, ex_jump, ex_branch, ex_memread, ex_memtoreg, ex_memwrite, ex_regwrite, ex_regeq;
    logic [2:0] ex_ALUop;
    logic [31:0] ex_ALU_src_a, ex_ALU_src_b1, ex_ALU_src_b2, ex_ALUout;
    logic [4:0] ex_write_reg;
    
    //------- MEM Stage Signals-------//
    logic [31:0] mem_ALUout, mem_write_data, mem_read_data;
    logic [4:0] mem_write_reg;
    logic mem_memwrite, mem_memread, mem_memtoreg, mem_regwrite;
    
    //------- WB Stage Signals-------//
    logic wb_regwrite, wb_memtoreg;
    logic [31:0] wb_ALUout, wb_read_data, wb_value, wb_write_reg;
    
    //-----Forwarding Unit Signals---//
    logic [1:0] forward_a;
    logic [1:0] forward_b;
    
    assign branch_address = pc_id + 4 + (id_imm_val << 2);
    assign if_branch = id_branch & id_regeq;
    fetch_unit u_fetch_unit(
    .clk(clk),
    .reset(reset),
    .stall(if_stall),
    .branch(if_branch),
    .branch_addr(branch_address),
    .instruction_addr(pc_if)
    );
    
    instruction_memory u_instr_mem (
        .clk(clk),
        .reset(reset),
        .instruction_addr(pc_if),
        .instruction_code(if_instruction)
    );
    
    if_id_reg u_if_id (
        .clk(clk),
        .reset(reset),
        .hazard(if_id_hazard),
        .instruction_code_i(if_instruction),
        .pc_i(pc_if),
        .instruction_code_o(id_instruction),
        .pc_o(pc_id)
    );
    
    assign id_opcode = id_instruction[31:26];
    assign id_reg1 = id_instruction[25:21];
    assign id_reg2 = id_instruction[20:16];
    assign id_reg_rd = id_instruction[15:11];
    assign id_shamt   = id_instruction[10:6];
    assign id_funct   = id_instruction[5:0];
    assign id_imm_val = { {16{id_instruction[15]}}, id_instruction[15:0]};
    assign id_regeq = id_reg_data1 == id_reg_data2;
    assign id_write_data = wb_memtoreg ? wb_read_data : wb_ALUout;
    
    register_file u_reg_file(
    .clk(clk),
    .reset(reset),
    .read_reg1(id_reg1),
    .read_reg2(id_reg2),
    .write_reg(wb_write_reg),
    .write_data(id_write_data),
    .write_en(wb_regwrite),
    .read_data1(id_reg_data1),
    .read_data2(id_reg_data2)
    );
   
    control u_control(
    .opcode(id_opcode),
    .regdst(id_regdst),
    .jump(id_jump),
    .branch(id_branch),
    .memread(id_memread),
    .memtoreg(id_memtoreg),
    .ALUop(id_ALUop),
    .memwrite(id_memwrite),
    .ALUsrc(id_ALUsrc),
    .regwrite(id_regwrite)
    );
    
    id_ex_reg u_id_ex (
    .clk(clk),
    .reset(reset),
    .pc_i(pc_id),
    .read_data1_i(id_reg_data1),
    .read_data2_i(id_reg_data2),
    .immediate_i(id_imm_val),
    .rs_i(id_reg1),
    .rt_i(id_reg2),
    .rd_i(id_reg_rd),
    .ALUsrc_i(id_ALUsrc),
    .ALUop_i(id_ALUop),
    .regdst_i(id_regdst),
    .memwrite_i(id_memwrite),
    .memread_i(id_memread),
    .memtoreg_i(id_memtoreg),
    .regwrite_i(id_regwrite),
    .regeq_i(id_regeq),
    .pc_o(pc_ex),
    .read_data1_o(ex_reg_data1),
    .read_data2_o(ex_reg_data2),
    .immediate_o(ex_imm_val),
    .rs_o(ex_reg1),
    .rt_o(ex_reg2),
    .rd_o(ex_reg_rd),
    .ALUsrc_o(ex_ALUsrc),
    .ALUop_o(ex_ALUop),
    .regdst_o(ex_regdst),
    .memwrite_o(ex_memwrite),
    .memread_o(ex_memread),
    .memtoreg_o(ex_memtoreg),
    .regwrite_o(ex_regwrite),
    .regeq_o(ex_regeq)
    );
    
    assign ex_write_reg = ex_regdst ? ex_reg_rd : ex_reg2; 
    assign ex_ALU_src_b2 = ex_ALUsrc ? ex_imm_val : ex_ALU_src_b1;
    ALU u_alu (
    .a(ex_ALU_src_a),
    .b(ex_ALU_src_b2),
    .control(ex_ALUop),
    .result(ex_ALUout)
    );
    
    ex_mem_reg u_ex_mem(
    .clk(clk),
    .reset(reset),
    .ALUresult_i(ex_ALUout),
    .write_data_i(ex_ALU_src_b1),
    .rd_i(ex_write_reg),
    .memwrite_i(ex_memwrite),
    .memread_i(ex_memread),
    .memtoreg_i(ex_memtoreg),
    .regwrite_i(ex_regwrite),
    .ALUresult_o(mem_ALUout),
    .write_data_o(mem_write_data),
    .rd_o(mem_write_reg),
    .memwrite_o(mem_memwrite),
    .memread_o(mem_memread),
    .memtoreg_o(mem_memtoreg),
    .regwrite_o(mem_regwrite)
    );
    
    data_memory u_data_mem(
    .clk(clk),
    .reset(reset),
    .address(mem_ALUout),
    .write_data(mem_write_data),
    .write_en(mem_memwrite),
    .read_data(mem_read_data)
    );
    
    mem_wb_reg u_mem_wb(
    .clk(clk),
    .reset(reset),
    .ALUresult_i(mem_ALUout),
    .mem_data_i(mem_read_data),
    .write_reg_i(mem_write_reg),
    .regwrite_i(mem_regwrite),
    .memtoreg_i(mem_memtoreg),
    .ALUresult_o(wb_ALUout),
    .mem_data_o(wb_read_data),
    .write_reg_o(wb_write_reg),
    .regwrite_o(wb_regwrite),
    .memtoreg_o(wb_memtoreg)
    );
    
    assign wb_value = wb_memtoreg ? wb_read_data : wb_ALUout;
    
    forwarding_unit u_forwarding_unit(
    .ex_mem_regwrite(mem_regwrite),
    .mem_wb_regwrite(wb_regwrite),
    .ex_reg1(ex_reg1),
    .ex_reg2(ex_reg2),
    .ex_mem_reg_rd(mem_write_reg),
    .mem_wb_reg_rd(wb_write_reg),
    .forward_a(forward_a),
    .forward_b(forward_b)
    );
    
    always_comb begin
        case (forward_a)
            2'b00: ex_ALU_src_a = ex_reg_data1;
            2'b01: ex_ALU_src_a = wb_value;
            2'b10: ex_ALU_src_a = mem_ALUout;
            default: ex_ALU_src_a = ex_reg_data1;
        endcase
        
        case (forward_b)
            2'b00: ex_ALU_src_b1 = ex_reg_data2;
            2'b01: ex_ALU_src_b1 = wb_value;
            2'b10: ex_ALU_src_b1 = mem_ALUout;
            default: ex_ALU_src_b1 = ex_reg_data2;
        endcase
    end
endmodule
