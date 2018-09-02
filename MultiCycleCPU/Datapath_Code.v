/*

Assignment 14
Group:04
Members:
1.Ashrujit Ghoshal(14CS10060)
2.Sayan Ghosh(14CS10061)
*/
//-------------------------------------------- Datapath Modules----------------------------------------------------------------------//

/*Module for D flip-flop*/
module D_FlipFlop ( output reg Q, output reg Q_bar, input D, input Clock, input Reset );
	//reg Q, Q_bar;
	always @(posedge Clock)	begin
		if(Reset == 1) begin
			Q <= 0;
			Q_bar <= 1;
		end
		else begin
			Q <= D;
			Q_bar <= ~D;
		end
	end
endmodule
/*Module for implementation for 1-bit 2-input AND gate*/
module XOR_2_Gate ( input op1,input op2,output out );
	xor(out,op1,op2);
endmodule

/*Module for implementation for 1-bit 2-operand XNOR gate*/
module	XNOR_Gate_1_Bit ( input op1,input op2,output out );
	xnor x1(out,op1,op2);
endmodule

/*Module for implementation for 1-bit 16-input AND gate*/
module 	AND_16_Gate ( input [15:0] In_Data,output Out );
	and a1(Out ,In_Data[15],In_Data[14],In_Data[13],In_Data[12],In_Data[11],In_Data[10],In_Data[9],In_Data[8],In_Data[7],In_Data[6],In_Data[5],In_Data[4],In_Data[3],In_Data[2],In_Data[1],In_Data[0]);
endmodule


/*Module for implementation for MUX_2_to_1*/
module MUX_2_to_1 ( In_1,In_0,Out,select );
	input [15:0] In_0,In_1;
	input select;
	wire [15:0] In_0,In_1;
	wire select;
	output [15:0] Out;
	wire [15:0] Out;	
	assign Out = (select == 1)?(In_1):(In_0);
endmodule

/*Module for implementation for MUX_3_to_1_3_bit*/
module MUX_3_to_1_3_bit ( In_2,In_1,In_0,Out,select );
	input [2:0] In_0,In_1,In_2;
	input [1:0] select;
	wire [2:0] In_0,In_1,In_2;
	wire [1:0] select;
	output [2:0] Out;
	wire [2:0] Out;
	assign Out = ((!select[1])&(!select[0]))?(In_0):(((!select[1])&(select[0]))?(In_1):(((select[1])&(!select[0]))?(In_2):(16'bzzzzzzzzzzzzzzzz)));	
endmodule

/*Module for implementation for MUX_4_to_1*/
module MUX_4_to_1_1_Bit ( In_0,In_1,In_2,In_3,Out,select );
	input In_0,In_1,In_2,In_3;
	input [1:0] select;
	wire In_0,In_1,In_2,In_3;
	wire [1:0] select;
	output Out;
	wire Out;	
	assign Out = ((!select[1])&(!select[0]))?(In_0):(((!select[1])&(select[0]))?(In_1):(((select[1])&(!select[0]))?(In_2):(((select[1])&(select[0]))?(In_3):(16'bzzzzzzzzzzzzzzzz))));	
endmodule

/*Module for implementation for MUX_8_to_1*/
module MUX_8_to_1 ( In_7,In_6,In_5,In_4,In_3,In_2,In_1,In_0,Out,select );
	input [15:0] In_0,In_1,In_2,In_3,In_4,In_5,In_6,In_7;
	input [2:0] select;
	wire [15:0] In_0,In_1,In_2,In_3,In_4,In_5,In_6,In_7;
	wire [2:0] select;
	output [15:0] Out;
	wire [15:0] Out;
	assign Out = ((!select[2])&(!select[1])&(!select[0]))?(In_0):(((!select[2])&(!select[1])&(select[0]))?(In_1):(((!select[2])&(select[1])&(!select[0]))?(In_2):(((!select[2])&(select[1])&(select[0]))?(In_3):(((select[2])&(!select[1])&(!select[0]))?(In_4):(((select[2])&(!select[1])&(select[0]))?(In_5):(((select[2])&(select[1])&(!select[0]))?(In_6):(((select[2])&(select[1])&(select[0]))?(In_7):(16'bzzzzzzzzzzzzzzzz))))))));
endmodule

/*Module for implementation for Decoder_3_to_8*/
module Decoder_3_to_8 ( input [2:0] In_Number, output [7:0] lines );
	//wire [2:0] In_Number;
	//wire [7:0] lines;
	assign lines[0] = (!In_Number[2])&(!In_Number[1])&(!In_Number[0]);
	assign lines[1] = (!In_Number[2])&(!In_Number[1])&(In_Number[0]);
	assign lines[2] = (!In_Number[2])&(In_Number[1])&(!In_Number[0]);
	assign lines[3] = (!In_Number[2])&(In_Number[1])&(In_Number[0]);
	assign lines[4] = (In_Number[2])&(!In_Number[1])&(!In_Number[0]);
	assign lines[5] = (In_Number[2])&(!In_Number[1])&(In_Number[0]);
	assign lines[6] = (In_Number[2])&(In_Number[1])&(!In_Number[0]);
	assign lines[7] = (In_Number[2])&(In_Number[1])&(In_Number[0]);
endmodule

/*Module for implementation for Tri_State_Buffer*/
module Tri_State_Buffer ( Input_Val,Enable,Output_Val );
	input [15:0] Input_Val;
	input Enable;
		output [15:0] Output_Val;
	assign Output_Val = (Enable==1)? (Input_Val) : (16'bzzzzzzzzzzzzzzzz);
endmodule

/*Module for structural implementation for Register*/
module Register ( input register_reset, input register_write, input [15:0] data_in, output [15:0] data_out);
	//wire [15:0] data_out;
	wire [15:0] data_out_bar;
	D_FlipFlop bit_0(data_out[0], data_out_bar[0], (register_reset==1)?(1'b0):(data_in[0]), register_write,0);
	D_FlipFlop bit_1(data_out[1], data_out_bar[1], (register_reset==1)?(1'b0):(data_in[1]), register_write,0);
	D_FlipFlop bit_2(data_out[2], data_out_bar[2], (register_reset==1)?(1'b0):(data_in[2]), register_write,0);
	D_FlipFlop bit_3(data_out[3], data_out_bar[3], (register_reset==1)?(1'b0):(data_in[3]), register_write,0);
	D_FlipFlop bit_4(data_out[4], data_out_bar[4], (register_reset==1)?(1'b0):(data_in[4]), register_write,0);
	D_FlipFlop bit_5(data_out[5], data_out_bar[5], (register_reset==1)?(1'b0):(data_in[5]), register_write,0);
	D_FlipFlop bit_6(data_out[6], data_out_bar[6], (register_reset==1)?(1'b0):(data_in[6]), register_write,0);
	D_FlipFlop bit_7(data_out[7], data_out_bar[7], (register_reset==1)?(1'b0):(data_in[7]), register_write,0);
	D_FlipFlop bit_8(data_out[8], data_out_bar[8], (register_reset==1)?(1'b0):(data_in[8]), register_write,0);
	D_FlipFlop bit_9(data_out[9], data_out_bar[9], (register_reset==1)?(1'b0):(data_in[9]), register_write,0);
	D_FlipFlop bit_10(data_out[10], data_out_bar[10], (register_reset==1)?(1'b0):(data_in[10]), register_write,0);
	D_FlipFlop bit_11(data_out[11], data_out_bar[11], (register_reset==1)?(1'b0):(data_in[11]), register_write,0);
	D_FlipFlop bit_12(data_out[12], data_out_bar[12], (register_reset==1)?(1'b0):(data_in[12]), register_write,0);
	D_FlipFlop bit_13(data_out[13], data_out_bar[13], (register_reset==1)?(1'b0):(data_in[13]), register_write,0);
	D_FlipFlop bit_14(data_out[14], data_out_bar[14], (register_reset==1)?(1'b0):(data_in[14]), register_write,0);
	D_FlipFlop bit_15(data_out[15], data_out_bar[15], (register_reset==1)?(1'b0):(data_in[15]), register_write,0);

endmodule

/*Module for structural implementation for Register Bank*/
module Register_Bank_Structural ( input [2:0] Reg_Number, input [15:0] Write_Data, input RegFile_Read, input RegFileWrite, input RegFile_Reset, output [15:0] Read_Data );		
	wire [7:0] decoder_write;
	Decoder_3_to_8 deco_1(.In_Number(Reg_Number), .lines(decoder_write));
	wire [15:0] Register_Out,Register_7,Register_6,Register_5,Register_4,Register_3,Register_2,Register_1,Register_0;	
	
	Register reg_7 (0,decoder_write[7] & RegFileWrite, Write_Data, Register_7);
	Register reg_6 (0,decoder_write[6] & RegFileWrite, Write_Data, Register_6);
	Register reg_5 (0,decoder_write[5] & RegFileWrite, Write_Data, Register_5);
	Register reg_4 (0,decoder_write[4] & RegFileWrite, Write_Data, Register_4);
	Register reg_3 (0,decoder_write[3] & RegFileWrite, Write_Data, Register_3);
	Register reg_2 (0,decoder_write[2] & RegFileWrite, Write_Data, Register_2);
	Register reg_1 (0,decoder_write[1] & RegFileWrite, Write_Data, Register_1);
	Register reg_0 (0,decoder_write[0] & RegFileWrite, Write_Data, Register_0);

	MUX_8_to_1 Reg_Bank_MUX (Register_7,Register_6,Register_5,Register_4,Register_3,Register_2,Register_1,Register_0,Register_Out,Reg_Number);	

	assign Read_Data = (RegFile_Read)?(Register_Out):(16'bzzzzzzzzzzzzzzzz);	
endmodule

/*Modules for structural implementation for ALU of the datapath*/


module FullAdder(
    input a,
    input b,
    input c_i,
    output  s,
    output  c_o
    ); 
	  and(t1,a,b);
	  and(t2,a,c_i);
	  and(t3,b,c_i);
	  or(c_o,t1,t2,t3);
	  and(t4,a,~b,~c_i);
	  and(t5,~a,~b,c_i);
	  and(t6,~a,b,~c_i);
	  and(t7,a,b,c_i);
	  or(s,t4,t5,t6,t7);
endmodule

module Adder8Bit(
    input [7:0] a,
	input [7:0] b,
	input c_i,
	output  [7:0]s,
	output  c_o
	
    );
	wire[6:0] c;
	FullAdder a1(a[0],b[0],c_i,s[0],c[0]);
	FullAdder a2(a[1],b[1],c[0],s[1],c[1]);
	FullAdder a3(a[2],b[2],c[1],s[2],c[2]);
	FullAdder a4(a[3],b[3],c[2],s[3],c[3]);
	FullAdder a5(a[4],b[4],c[3],s[4],c[4]);
	FullAdder a6(a[5],b[5],c[4],s[5],c[5]);
	FullAdder a7(a[6],b[6],c[5],s[6],c[6]);
	FullAdder a8(a[7],b[7],c[6],s[7],c_o);
endmodule

module Adder16Bit(
  input [15:0] a,
	input [15:0] b,
	input c_i,
	output  [15:0]s,
	output  c_o
    );

	wire[14:0] c;
	wire w;
	Adder8Bit a1(a[7:0],b[7:0],c_i,s[7:0],w); 
	Adder8Bit a2(a[15:8],b[15:8],w,s[15:8],c_o);
endmodule

module subt16bit(input [15:0] x,input [15:0] y,output [15:0] o,output bor);
	wire [15:0] a;
	not n1(a[0],y[0]);
	not n2(a[1],y[1]);
	not n3(a[2],y[2]);
	not n4(a[3],y[3]);
	not n5(a[4],y[4]);
	not n6(a[5],y[5]);
	not n7(a[6],y[6]);
	not n8(a[7],y[7]);
	not n9(a[8],y[8]);
	not n10(a[9],y[9]);
	not n11(a[10],y[10]);
	not n12(a[11],y[11]);
	not n13(a[12],y[12]);
	not n14(a[13],y[13]);
	not n15(a[14],y[14]);
	not n16(a[15],y[15]);
	Adder16Bit m(x,a,1'b1,o,bor);
endmodule



module rep(output [15:0] b,input a);
buf b15(b[15],a);
buf b14(b[14],a);
buf b13(b[13],a);
buf b12(b[12],a);
buf b11(b[11],a);
buf b125(b[10],a);
buf b9(b[9],a);
buf b8(b[8],a);
buf b7(b[7],a);
buf b6(b[6],a);
buf b5(b[5],a);
buf b4(b[4],a);
buf b3(b[3],a);
buf b2(b[2],a);
buf b1(b[1],a);
buf b0(b[0],a);
endmodule

module or16(output [15:0] b,input [15:0] a, input [15:0] s);
	or b15(b[15],a[15],s[15]);
	or b14(b[14],a[14],s[14]);
	or b13(b[13],a[13],s[13]);
	or b12(b[12],a[12],s[12]);
	or b11(b[11],a[11],s[11]);
	or b10(b[10],a[10],s[10]);
	or b9(b[9],a[9],s[9]);
	or b8(b[8],a[8],s[8]);
	or b7(b[7],a[7],s[7]);
	or b6(b[6],a[6],s[6]);
	or b5(b[5],a[5],s[5]);
	or b4(b[4],a[4],s[4]);
	or b3(b[3],a[3],s[3]);
	or b2(b[2],a[2],s[2]);
	or b1(b[1],a[1],s[1]);
	or b0(b[0],a[0],s[0]);
endmodule

module and16(output [15:0] b,input [15:0] a, input [15:0] s);
	and b15(b[15],a[15],s[15]);
	and b14(b[14],a[14],s[14]);
	and b13(b[13],a[13],s[13]);
	and b12(b[12],a[12],s[12]);
	and b11(b[11],a[11],s[11]);
	and b10(b[10],a[10],s[10]);
	and b9(b[9],a[9],s[9]);
	and b8(b[8],a[8],s[8]);
	and b7(b[7],a[7],s[7]);
	and b6(b[6],a[6],s[6]);
	and b5(b[5],a[5],s[5]);
	and b4(b[4],a[4],s[4]);
	and b3(b[3],a[3],s[3]);
	and b2(b[2],a[2],s[2]);
	and b1(b[1],a[1],s[1]);
	and b0(b[0],a[0],s[0]);
endmodule

module xor16(output [15:0] b,input [15:0] a, input [15:0] s);
	xor b15(b[15],a[15],s[15]);
	xor b14(b[14],a[14],s[14]);
	xor b13(b[13],a[13],s[13]);
	xor b12(b[12],a[12],s[12]);
	xor b11(b[11],a[11],s[11]);
	xor b10(b[10],a[10],s[10]);
	xor b9(b[9],a[9],s[9]);
	xor b8(b[8],a[8],s[8]);
	xor b7(b[7],a[7],s[7]);
	xor b6(b[6],a[6],s[6]);
	xor b5(b[5],a[5],s[5]);
	xor b4(b[4],a[4],s[4]);
	xor b3(b[3],a[3],s[3]);
	xor b2(b[2],a[2],s[2]);
	xor b1(b[1],a[1],s[1]);
	xor b0(b[0],a[0],s[0]);
endmodule
module Adder15Bit(
    input [14:0] a,
	input [14:0] b,
	input c_i,
	output  [14:0]s,
	output  c_o
	
    );
	wire[13:0] c;
	FullAdder a1(a[0],b[0],c_i,s[0],c[0]);
	FullAdder a2(a[1],b[1],c[0],s[1],c[1]);
	FullAdder a3(a[2],b[2],c[1],s[2],c[2]);
	FullAdder a4(a[3],b[3],c[2],s[3],c[3]);
	FullAdder a5(a[4],b[4],c[3],s[4],c[4]);
	FullAdder a6(a[5],b[5],c[4],s[5],c[5]);
	FullAdder a7(a[6],b[6],c[5],s[6],c[6]);
	FullAdder a8(a[7],b[7],c[6],s[7],c[7]);
	FullAdder a9(a[8],b[8],c[7],s[8],c[8]);
	FullAdder a10(a[9],b[9],c[8],s[9],c[9]);
	FullAdder a11(a[10],b[10],c[9],s[10],c[10]);
	FullAdder a12(a[11],b[11],c[10],s[11],c[11]);
	FullAdder a13(a[12],b[12],c[11],s[12],c[12]);
	FullAdder a14(a[13],b[13],c[12],s[13],c[13]);
	FullAdder a15(a[14],b[14],c[13],s[14],c_o);
	
endmodule

module subt15bit(input [14:0] x,input [14:0] y,output [14:0] o,output bor);
	wire [14:0] a;
	not n1(a[0],y[0]);
	not n2(a[1],y[1]);
	not n3(a[2],y[2]);
	not n4(a[3],y[3]);
	not n5(a[4],y[4]);
	not n6(a[5],y[5]);
	not n7(a[6],y[6]);
	not n8(a[7],y[7]);
	not n9(a[8],y[8]);
	not n10(a[9],y[9]);
	not n11(a[10],y[10]);
	not n12(a[11],y[11]);
	not n13(a[12],y[12]);
	not n14(a[13],y[13]);
	not n15(a[14],y[14]);
	
	Adder15Bit m(x,a,1'b1,o,bor);
endmodule


module ALU_DP ( ALU_Control_Signal, In_1, In_2, Output, Carry_Bit_Last, Carry_Bit_Second_Last );
	 input [2:0] ALU_Control_Signal;
	 input [15:0] In_1;
	 input [15:0] In_2;	 
	 output [15:0] Output;
	 output Carry_Bit_Last, Carry_Bit_Second_Last;
	 
	 
	 wire Carry_Bit_Last, Carry_Bit_Second_Last;
	 wire w1,w2,w3,w4;
	 wire [14:0] temp_sum;
	 wire [14:0] temp_diff;
	and a1(s1,~ALU_Control_Signal[0],~ALU_Control_Signal[1],~ALU_Control_Signal[2]);
	and a2(s2,ALU_Control_Signal[0],~ALU_Control_Signal[1],~ALU_Control_Signal[2]);
	and a3(s3,~ALU_Control_Signal[0],ALU_Control_Signal[1],~ALU_Control_Signal[2]);
	and a4(s4,ALU_Control_Signal[0],ALU_Control_Signal[1],~ALU_Control_Signal[2]);
	and a5(s5,~ALU_Control_Signal[0],~ALU_Control_Signal[1],ALU_Control_Signal[2]);
	and a6(s6,ALU_Control_Signal[0],~ALU_Control_Signal[1],ALU_Control_Signal[2]);
	wire [15:0] sum;wire [15:0] diff;wire [15:0] and0;wire [15:0] or0;wire [15:0] not0;wire [15:0] mns;
	wire [15:0] sum1;wire [15:0] diff1;wire [15:0] and1;wire [15:0] or1;wire [15:0] not1;wire [15:0] mns1;
	wire [15:0] s11;
	wire [15:0] s12;
	wire [15:0] s13;
	wire [15:0] s14;
	wire [15:0] s15;
	wire [15:0] s16;
	rep r1(s11,s1);
	rep r2(s12,s2);
	rep r3(s13,s3);
	rep r4(s14,s4);
	rep r5(s15,s5);
	rep r6(s16,s6);
	and16 n50(and0,In_1,In_2);
	or16 n501(or0,In_1,In_2);
	xor16 n502(not0,In_1,In_2);
	Adder16Bit ad(In_1,In_2,0,sum,w2);
	subt16bit s(In_1,In_2,diff,w1);
	and a89(ta1,s11,w2);
	and a99(ta2,s12,w1);
	or o199(Carry_Bit_Last,ta1,ta2);
	Adder15Bit ad1(In_1[14:0],In_2[14:0],1'b0,temp_sum,w3);
	subt15bit ad2(In_1[14:0],In_2[14:0],temp_diff,w4);

	and a889(ta3,s11,w3);
	and a999(ta4,s12,w4);
	or o99(Carry_Bit_Second_Last,ta3,ta4);



	and16 a15(sum1,sum,s11);
	and16 a25(diff1,diff,s12);
	and16 a35(and1,and0,s13);
	and16 a45(or1,or0,s14);
	and16 a55(not1,not0,s15);
	and16 a65(mns1,diff,s16);
	wire [15:0] temp;
	wire [15:0]tem1;
	wire [15:0]tem2;
	wire [15:0]tem3;
	wire [15:0]tem4;
	or16 o1(tem1,sum1,diff1);
	or16 o2(tem2,tem1,and1);
	or16 o3(tem3,tem2,or1);
	or16 o4(tem4,tem3,not1);
	or16 o5(Output,tem4,mns1);
	
endmodule


module datapath_cpu(input reset,input MAR_Write,input MDR_Write,input PCRead,input T_Write,input IR_Write,input ALUOutWrite,input Z_Write,input O_Write,input M_Write,input C_Write,
					input [2:0] RegNumberSrc,input Reg_Number,input [2:0] ALU_Control_Signal,input TRD,input TMDR,input TPC,input ALU_Reg_Read,input Const_0_Read,
					input Const_2_Read,input [1:0] JumpFlagSelect,input ALUOutRead,input RegFileWrite,input RegFile_Read,input MDRRead,input MARRead,input MDRSrc,input MARSrc,output data_in_IR,output out1  );

	wire [15:0] Bus1;
	wire [15:0] Bus2;
	wire [15:0] OutputALU;
	
	Register MDR(  reset,  MDR_Write,   data_in_MDR,   data_out_MDR);
	Register MAR(  reset,  MAR_Write,   data_in_MAR,   data_out_MAR);
	Register PC(  reset,  PCRead,   data_in_PC,   data_out_PC);
	Register T(  reset,  T_Write,   data_in_T,   data_out_T);
	Register IR(  reset,  IR_Write,   data_in_IR,   data_out_IR);
	Register R0(  reset,  1,   16'b0000000000000000,   data_out_R0);
	Register R2(  reset,  1,   16'b0000000000000010,   data_out_R2);
	Register ALUOut(  reset,  ALUOutWrite,   data_in_ALUOut,   data_out_ALUOut);
	Register Z(  reset,  Z_Write,   data_in_Z,   data_out_Z);
	Register M(  reset,  M_Write,   data_in_M,   data_out_M);
	Register O(  reset,  O_Write,   data_in_O,   data_out_O);
	Register C(  reset,  C_Write,   data_in_C,   data_out_C);



	Register_Bank_Structural RB(  Reg_Number,   RegBankWrite,  RegFile_Read,  RegFileWrite, reset,   Read_Data );

	Tri_State_Buffer T1( data_out_MDR,TMDR,Bus1 );
	Tri_State_Buffer T2( data_out_PC,TPC,Bus1 );
	Tri_State_Buffer T3( Read_Data,TRD,Bus1 );
	Tri_State_Buffer T4( data_out_ALUOut,ALUOut_Reg_Read,Bus1 );
	Tri_State_Buffer T5( data_out_R2,Const_2_Read,Bus1 );
	Tri_State_Buffer T6( data_out_R0,Const_0_Read,Busl );
	Tri_State_Buffer T7( OutputALU,ALUOutRead,Bus2 );



	ALU_DP alu( ALU_Control_Signal, data_in_T, Bus1, OutputALU, Carry_Bit_Last, Carry_Bit_Second_Last );
	
	nor(data_in_Z,OutputALU[0],OutputALU[1],OutputALU[2],OutputALU[3],OutputALU[4],OutputALU[5],OutputALU[6],OutputALU[7],OutputALU[8],OutputALU[9],OutputALU[10],OutputALU[11],OutputALU[12],OutputALU[13],OutputALU[14],OutputALU[15]);
	buf(data_in_C,Carry_Bit_Last);
	xor(data_in_O,Carry_Bit_Last,Carry_Bit_Second_Last);
	buf(data_in_M,OutputALU[15]);
	
	
	MUX_2_to_1 M1( Bus1,Bus2,data_in_MAR,MARSrc );
	MUX_2_to_1 M2( Mem,Bus2,data_in_MDR,MDRSrc );
	
	MUX_2_to_1 M3( Bus1,Bus2,RegBankWrite,select );

	

	MUX_3_to_1_3_bit M4( opcode,op1,op2,Out,RegNumberSrc );


	wire Out1;
	MUX_4_to_1_1_Bit M5( data_out_M,data_out_Z,data_out_O,data_out_C,Out1,JumpFlagSelect );



endmodule

