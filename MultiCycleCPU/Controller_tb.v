/******************************************************************************************************************************************************/
                                                                        //  Assignment 15   //  
                                                                        //  Group Number : 4    //
                                                                        //  Member 1 : Ashrujit Ghoshal (14CS10060) //
                                                                        //  Member 2 : Sayan Ghosh (14CS10061)  //

/******************************************************************************************************************************************************/
//-------------------------------------------- Controller Test Bench ----------------------------------------------------------------------//
module tb_controller;
    reg [3:0]opcode ;
    reg [2:0]mode ;
    reg ready, clk;
    reg  [2:0]jump_instr_type;

    
    wire MemRead, MemWrite, MARRead, MARWrite, MDRWrite, MDRSrc, MDRRead, MDRMemRead, MARSrc, IRWrite, IRRead, PCWrite, PCRead, RegFileRead, RegFileWrite, WD_RegFileSrc, ALUOutRead, ALUOutWrite, ALUOutRegRead, T_Read, T_Write,  const_2_Read,  const_0_Read, Z_Write, C_Write, M_Write, O_Write;
    
   wire [6:0]state;
    wire [1:0]RegNumberSrc;

    wire [2:0]ALU_CS;

    wire [1:0]Jump_Flag_Select;

  controller ctr(opcode, mode,state, ready, jump_instr_type, clk, MemRead, MemWrite, MARWrite, MARRead, MARSrc, MDRSrc, MDRRead, MDRMemRead, WD_RegFileSrc, MDRWrite, IRWrite, IRRead, PCWrite, PCRead, RegFileRead, RegFileWrite, WD_RegFileSrc, ALUOutWrite, ALUOutRead, ALUOutRegRead, T_Read, T_Write, ALU_CS, Jump_Flag_Select, RegNumberSrc, const_0_Read, const_2_Read, Z_Write, C_Write, M_Write, O_Write);
    initial begin
    clk = 0;
    $display("\tThe instructions tested are according to the following serial number :\n");
    $display("\t\t1.Load Immediate\n");
    opcode= 4'b1000;
    mode = 3'b001;
    jump_instr_type = 3'b000;
    ready = 0;
     #1000
    $display("\t\t2.Load Indirect\n");
    opcode = 4'b1000;
    mode = 3'b100;
    jump_instr_type = 3'b000;
    ready = 0;
    #1000
    $display("\t\t3.Add Indirect\n");
    opcode = 4'b0000;
    mode = 3'b100;
    jump_instr_type = 3'b000;
    ready = 0;
#1000
    $display("\t\t4.Sub Register\n");
    opcode = 4'b0001;
    mode = 3'b000;
    jump_instr_type= 3'b000;
    ready = 0;
#1000
    $display("\t\t5.And Base-Indexed\n");
    opcode = 4'b0010;
    mode = 3'b010;
    jump_instr_type = 3'b000;
    ready = 0;
#1000
    $display("\t\t6.Jump Unconditional\n");
    opcode = 4'b1010;
    mode = 3'b101;
    jump_instr_type = 3'b000;
    ready = 0;
#1000
    $display("\t\t7.Store Base_addressed\n");
    opcode = 4'b1001;
    mode = 3'b011;
    jump_instr_type = 3'b000;
    ready = 0;
#1000
    $display("\t\t8.jal instruction\n");
    opcode = 4'b1100;
    mode = 3'b011;
    jump_instr_type = 3'b000;
    ready = 0;

    end
    always  #50 clk = ~(clk);
endmodule