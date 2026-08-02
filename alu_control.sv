module alu_control(
    input        [2:0] ALUop,   
    input        [5:0] funct,   
    output logic [3:0] alu_ctrl 
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
        case (ALUop)
            3'b000: alu_ctrl = ALU_ADD; // lw/sw/addi
            3'b001: alu_ctrl = ALU_SUB; // beq
            3'b010: begin               // R-type
                case (funct)
                    6'b100000: alu_ctrl = ALU_ADD;  // add
                    6'b100001: alu_ctrl = ALU_ADD;  // addu
                    6'b100010: alu_ctrl = ALU_SUB;  // sub
                    6'b100011: alu_ctrl = ALU_SUB;  // subu
                    6'b100100: alu_ctrl = ALU_AND;  // and
                    6'b100101: alu_ctrl = ALU_OR;   // or
                    6'b100110: alu_ctrl = ALU_XOR;  // xor
                    6'b100111: alu_ctrl = ALU_NOR;  // nor 
                    6'b101010: alu_ctrl = ALU_SLT;  // slt
                    6'b101011: alu_ctrl = ALU_SLTU; // sltu
                    6'b000000: alu_ctrl = ALU_SLL;  // sll
                    6'b000010: alu_ctrl = ALU_SRL;  // srl
                    6'b000011: alu_ctrl = ALU_SRA;  // sra
                    default:   alu_ctrl = ALU_ADD;  
                endcase
            end
            default: alu_ctrl = ALU_ADD;
        endcase
    end

endmodule