
module CPU_top_module(input reset,input clock,input [15:0] Mem_Addr,input [15:0] Write_Data,input MemRead1,input MemWrite1);



wire [2:0] ALU_CS;
wire [1:0] Jump_Flag_Select;
wire [3:0]opcode;
   
wire [2:0]mode;
wire [6:0]state;
    
wire [2:0]jump_instr_type;

   
   
wire[2:0]RegNumberSrc;
    
    
wire [15:0] Read_Data;
wire [15:0] data_in_IR;


datapath_cpu D (reset, MARWrite, MDRWrite,PCRead, T_Write, IRWrite, ALUOutWrite, Z_Write,O_Write, M_Write,C_Write,
					 RegNumberSrc,  ALU_CS, WD_RegFileSrc, MDRMemRead, PCWrite, ALU_Reg_Read, const_0_Read,
					const_2_Read,  Jump_Flag_Select,  ALUOutRegRead, RegFileWrite, RegFileRead, MDRRead, MARRead,MDRSrc, MARSrc, data_in_IR, out1  );

controller C (opcode, mode, state, ready, jump_instr_type, clock, MemRead, MemWrite, MARWrite, MARRead, MARSrc, MDRSrc, MDRRead, MDRMemRead, WD_RegFileSrc, MDRWrite, IRWrite, IRRead, PCWrite, PCRead, RegFileRead, RegFileWrite, WD_RegFileSrc, ALUOutWrite, ALUOutRead, ALUOutRegRead, T_Read, T_Write, ALU_CS, Jump_Flag_Select, RegNumberSrc, const_0_Read, const_2_Read, Z_Write, C_Write, M_Write, O_Write);
   


Memory_Bank M ( reset,  Mem_Addr, Write_Data, MemRead,  MemWrite, MemRead1,MemWrite1 ,Read_Data );
instr_decoder ID (Read_Data,  opcode , mode,  jump_instr_type);
endmodule
