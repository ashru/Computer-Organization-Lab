module sign_extension8bit(input [7:0] a, output [15:0] b,input p,output q);
	or(b[0],a[0],1'b0);
	or(b[1],a[1],1'b0);
	or(b[2],a[2],1'b0);
	or(b[3],a[3],1'b0);
	or(b[4],a[4],1'b0);
	or(b[5],a[5],1'b0);
	or(b[6],a[6],1'b0);
	or(b[7],a[7],1'b0);
	or(b[8],a[7],1'b0);
	or(b[9],a[7],1'b0);
	or(b[10],a[7],1'b0);
	or(b[11],a[7],1'b0);
	or(b[12],a[7],1'b0);
	or(b[13],a[7],1'b0);
	or(b[14],a[7],1'b0);
	or(b[15],a[7],1'b0);
endmodule		

module sign_extension5bit(input [4:0] a , output[15:0]b ,input p,output q);
	or(b[0],a[0],1'b0);
	or(b[1],a[1],1'b0);
	or(b[2],a[2],1'b0);
	or(b[3],a[3],1'b0);
	or(b[4],a[4],1'b0);
	or(b[5],a[4],1'b0);
	or(b[6],a[4],1'b0);
	or(b[7],a[4],1'b0);
	or(b[8],a[4],1'b0);
	or(b[9],a[4],1'b0);
	or(b[10],a[4],1'b0);
	or(b[11],a[4],1'b0);
	or(b[12],a[4],1'b0);
	or(b[13],a[4],1'b0);
	or(b[14],a[4],1'b0);
	or(b[15],a[4],1'b0);
endmodule

module sign_extension11bit(input [10:0] a, output[15:0] b,input p,output q);
	or(b[0],a[0],1'b0);
	or(b[1],a[1],1'b0);
	or(b[2],a[2],1'b0);
	or(b[3],a[3],1'b0);
	or(b[4],a[4],1'b0);
	or(b[5],a[5],1'b0);
	or(b[6],a[6],1'b0);
	or(b[7],a[7],1'b0);
	or(b[8],a[8],1'b0);
	or(b[9],a[9],1'b0);
	or(b[10],a[10],1'b0);
	or(b[11],a[10],1'b0);
	or(b[12],a[10],1'b0);
	or(b[13],a[10],1'b0);
	or(b[14],a[10],1'b0);
	or(b[15],a[10],1'b0);
endmodule

module Data_memory(input read,input write,input clk,input rst,input m,output n,input [15:0] Address_bus,input [15:0] Data_bus,output reg [15:0] out);
	reg [15:0]VN[200:0];
  
  always@(negedge clk)
  begin
         if(write)
            VN[Address_bus]<= Data_bus;
end				
          
         
      		
  always@(posedge clk )        
  begin
	  	if(read)
		   	out<= VN[Address_bus];
				end
          
        
	endmodule		


	
module Instruction_memory(input read,input write,input clk,input rst,input m,output n,input [15:0] addline,input [15:0] Iaddline,input [15:0] writeline,output reg[15:0] out);
  
	reg [15:0]VN[200:0];
  
  always@(posedge read)        
	 begin
   if(write)
          VN[Iaddline]= writeline;   
	 	if(read)
          out= VN[addline];
		   
     end			
endmodule		




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


module ALU_DP ( ALU_Control_Signal, In_1, In_2, Output, Carry_Bit_Last, Overflow );
	 input [2:0] ALU_Control_Signal;
	 input [15:0] In_1;
	 input [15:0] In_2;	 
	 output [15:0] Output;
	 output Carry_Bit_Last, Overflow;
	 //xor x(Overflow,Carry_Bit_last,Carry_Bit_Second_Last);
	 
	 
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
	rep r5(s15,s6);
	rep r6(s16,s5);
	and16 n50(and0,In_1,In_2);
	or16 n501(or0,In_1,In_2);
	xor16 n502(not0,In_1,In_2);
	Adder16Bit ad(In_1,In_2,1'b0,sum,w2);
	subt16bit s(In_1,In_2,diff,w1);
	and a89(ta1,s1,w2);
	and a99(ta2,s2,w1);
	or o199(Overflow,ta1,ta2);
	Adder15Bit ad1(In_1[14:0],In_2[14:0],1'b0,temp_sum,w3);
	subt15bit ad2(In_1[14:0],In_2[14:0],temp_diff,w4);

	and a889(ta3,s1,w3);
	and a999(ta4,s2,w4);
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

module nor16bit(input [15:0] in, output b);
  or(b1,in[0],in[1],in[2],in[3],in[4],in[5],in[6],in[7],in[8],in[9],in[10],in[11],in[12],in[13],in[14],in[15]);
  xor(b,b1,1'b1,1'b0);
endmodule

module buffer_tristate(input signal,input [15:0] b,output [15:0] a,input temp);
	assign a=(signal)?b:16'bz;
endmodule


module helper(input clk,input reset,input t,output y,input gg,output hh,input [15:0] a,output reg [15:0] b,input ld);
always@(negedge clk)

	begin
	case(reset)
	1'b0:begin
			case(ld)
			1'b0:b<=b;
			1'b1:b<=a;
			endcase
			end
		
	1'b1 : 
			b<=16'b0;
	endcase
	end
endmodule


module D_FlipFlop ( output reg Q, output reg Q_bar, input D, input Clock, input Reset );

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
module Decoder_3_to_8 ( input [2:0] In_Number, output [7:0] lines );
	
	assign lines[0] = (!In_Number[2])&(!In_Number[1])&(!In_Number[0]);
	assign lines[1] = (!In_Number[2])&(!In_Number[1])&(In_Number[0]);
	assign lines[2] = (!In_Number[2])&(In_Number[1])&(!In_Number[0]);
	assign lines[3] = (!In_Number[2])&(In_Number[1])&(In_Number[0]);
	assign lines[4] = (In_Number[2])&(!In_Number[1])&(!In_Number[0]);
	assign lines[5] = (In_Number[2])&(!In_Number[1])&(In_Number[0]);
	assign lines[6] = (In_Number[2])&(In_Number[1])&(!In_Number[0]);
	assign lines[7] = (In_Number[2])&(In_Number[1])&(In_Number[0]);
endmodule

/*Module for structural implementation for Register*/
module Register ( input register_reset, input register_write, input [15:0] data_in, output [15:0] data_out);
	
	wire [15:0] data_out_bar;
	D_FlipFlop bit_0(data_out[0], data_out_bar[0], (register_reset==1)?(1'b0):(data_in[0]), register_write,1'b0);
	D_FlipFlop bit_1(data_out[1], data_out_bar[1], (register_reset==1)?(1'b0):(data_in[1]), register_write,1'b0);
	D_FlipFlop bit_2(data_out[2], data_out_bar[2], (register_reset==1)?(1'b0):(data_in[2]), register_write,1'b0);
	D_FlipFlop bit_3(data_out[3], data_out_bar[3], (register_reset==1)?(1'b0):(data_in[3]), register_write,1'b0);
	D_FlipFlop bit_4(data_out[4], data_out_bar[4], (register_reset==1)?(1'b0):(data_in[4]), register_write,1'b0);
	D_FlipFlop bit_5(data_out[5], data_out_bar[5], (register_reset==1)?(1'b0):(data_in[5]), register_write,1'b0);
	D_FlipFlop bit_6(data_out[6], data_out_bar[6], (register_reset==1)?(1'b0):(data_in[6]), register_write,1'b0);
	D_FlipFlop bit_7(data_out[7], data_out_bar[7], (register_reset==1)?(1'b0):(data_in[7]), register_write,1'b0);
	D_FlipFlop bit_8(data_out[8], data_out_bar[8], (register_reset==1)?(1'b0):(data_in[8]), register_write,1'b0);
	D_FlipFlop bit_9(data_out[9], data_out_bar[9], (register_reset==1)?(1'b0):(data_in[9]), register_write,1'b0);
	D_FlipFlop bit_10(data_out[10], data_out_bar[10], (register_reset==1'b1)?(1'b0):(data_in[10]), register_write,1'b0);
	D_FlipFlop bit_11(data_out[11], data_out_bar[11], (register_reset==1'b1)?(1'b0):(data_in[11]), register_write,1'b0);
	D_FlipFlop bit_12(data_out[12], data_out_bar[12], (register_reset==1'b1)?(1'b0):(data_in[12]), register_write,1'b0);
	D_FlipFlop bit_13(data_out[13], data_out_bar[13], (register_reset==1'b1)?(1'b0):(data_in[13]), register_write,1'b0);
	D_FlipFlop bit_14(data_out[14], data_out_bar[14], (register_reset==1'b1)?(1'b0):(data_in[14]), register_write,1'b0);
	D_FlipFlop bit_15(data_out[15], data_out_bar[15], (register_reset==1'b1)?(1'b0):(data_in[15]), register_write,1'b0);

endmodule
module MUX_8_to_1 ( In_7,In_6,In_5,In_4,In_3,In_2,In_1,In_0,Out,select );
	input [15:0] In_0,In_1,In_2,In_3,In_4,In_5,In_6,In_7;
	input [2:0] select;
	wire [15:0] In_0,In_1,In_2,In_3,In_4,In_5,In_6,In_7;
	wire [2:0] select;
	output [15:0] Out;
	wire [15:0] Out;
	assign Out = ((!select[2])&(!select[1])&(!select[0]))?(In_0):(((!select[2])&(!select[1])&(select[0]))?(In_1):(((!select[2])&(select[1])&(!select[0]))?(In_2):(((!select[2])&(select[1])&(select[0]))?(In_3):(((select[2])&(!select[1])&(!select[0]))?(In_4):(((select[2])&(!select[1])&(select[0]))?(In_5):(((select[2])&(select[1])&(!select[0]))?(In_6):(((select[2])&(select[1])&(select[0]))?(In_7):(16'bzzzzzzzzzzzzzzzz))))))));
endmodule

/*Module for structural implementation for Register Bank*/
module Register_Bank_Structural ( output [15:0] Read_Data1,output [15:0] Read_Data2,input clk,input [2:0] Reg_Number1,input [2:0] Reg_Number2, input RegFile_Read1,input RegFile_Read2,input[2:0]Reg_Number3,  input RegFileWrite,input [15:0] Write_Data   ,input t20);		
	wire [7:0] decoder_write;
	wire [15:0] Register_Out1,Register_Out2,Register_7,Register_6,Register_5,Register_4,Register_3,Register_2,Register_1,Register_0;	
		Decoder_3_to_8 d0(Reg_Number3, decoder_write);

	Register reg_7 (1'b0,decoder_write[7] & RegFileWrite, Write_Data, Register_7);
	Register reg_6 (1'b0,decoder_write[6] & RegFileWrite, Write_Data, Register_6);
	Register reg_5 (1'b0,decoder_write[5] & RegFileWrite, Write_Data, Register_5);
	Register reg_4 (1'b0,decoder_write[4] & RegFileWrite, Write_Data, Register_4);
	Register reg_3 (1'b0,decoder_write[3] & RegFileWrite, Write_Data, Register_3);
	Register reg_2 (1'b0,decoder_write[2] & RegFileWrite, Write_Data, Register_2);
	Register reg_1 (1'b0,decoder_write[1] & RegFileWrite, Write_Data, Register_1);
	Register reg_0 (1'b0,decoder_write[0] & RegFileWrite, Write_Data, Register_0);

	MUX_8_to_1 Reg_Bank_MUX1 (Register_7,Register_6,Register_5,Register_4,Register_3,Register_2,Register_1,Register_0,Register_Out1,Reg_Number1);	
	MUX_8_to_1 Reg_Bank_MUX2 (Register_7,Register_6,Register_5,Register_4,Register_3,Register_2,Register_1,Register_0,Register_Out2,Reg_Number2);	


	assign Read_Data1 = (RegFile_Read1)?(Register_Out1):(16'bzzzzzzzzzzzzzzzz);
	assign Read_Data2 = (RegFile_Read2)?(Register_Out2):(16'bzzzzzzzzzzzzzzzz);	
	endmodule


	
module datapath_code(output [15:0] ins_out,output Zin,output Vin,output Sin,output Cin,input [15:0] inswrite_line, input [15:0]insadd_line, input readins,input writeins,input clk,input rst,input Trans1PC,input ldPC,input read1,input read2,input write,input TransX1,input TransX2,input TransX3,input TransY1,input TransY2,input TransY3,input [2:0]func_select,input Trans2PC,input Trans_ALU_Z,input TransYZ, input TDZ,input TopID,input readData,input writeData,input TransAD);
    wire [15:0] PCin;
	 wire [15:0] PCout;
	 wire [15:0] addtoup;
	 wire [15:0] soutput1;
	 wire [15:0] soutput2;
	 wire [15:0] soutput3;
	 wire [15:0] Abus;
	 wire [15:0] A1bus;
	 wire [15:0] Dout;
	 wire [15:0] Dbus;
	 wire [15:0] Xbus;
	 wire [15:0] Ybus;
	 wire [15:0] Zbus;
	 wire [15:0] output1;
	 wire [15:0] output2;
	 
	 buffer_tristate BT1(Trans1PC,addtoup,PCin,t30);
	 buffer_tristate BT2(TransX3,addtoup,Xbus,t31);
	 buffer_tristate BT3(TransX1,output1,Xbus,t32);
	 buffer_tristate BT4(TransX2,soutput2,Xbus,t33);
	 buffer_tristate BT5(TransY1,output2,Ybus,t34);
	 buffer_tristate BT6(TransY2,soutput1,Ybus,t35);
	 buffer_tristate BT7(TransY3,soutput3,Ybus,t36);
	 buffer_tristate BT8(Trans2PC,Abus,PCin,t37);
	 buffer_tristate BT9(Trans_ALU_Z,Abus,Zbus,t38);
	 buffer_tristate BT10(TransAD,Abus,A1bus,t39);
	 buffer_tristate BT11(TopID,output1,Dbus,t40);
	 buffer_tristate BT12(TransYZ,Ybus,Zbus,t41);
	 buffer_tristate BT13(TDZ,Dout,Zbus,t42);
		
	 nor16bit no(Abus,Zin);
	
	 or(Sin,Abus[15],1'b0);
	 Adder16Bit d(PCout,16'b1,1'b0,addtoup,carryout);
	 helper h(clk,rst,t00,t01,t17,t18,PCin,PCout,ldPC);
	 sign_extension8bit se1(ins_out[7:0],soutput1,t15,t02);
	 sign_extension5bit se2(ins_out[4:0],soutput2,t03,t04);
	 sign_extension11bit se3(ins_out[10:0],soutput3,t05,t06);
	 Register_Bank_Structural rb(output1,output2,clk,ins_out[10:8],ins_out[7:5],read1,read2,ins_out[10:8],write,Zbus,t20);
	 Instruction_memory mem1(readins,writeins,clk,rst,t11,t12,PCout,insadd_line,inswrite_line,ins_out);
	 Data_memory mddm(readData,writeData,clk,rst,to9,t10,A1bus,Dbus,Dout);
	 ALU_DP alu( func_select, Xbus, Ybus,Abus, Cin, Vin );
	
	 
	 
	 
endmodule






module datapath_tb;

	// Inputs
	reg [15:0] inswrite_line;
	reg [15:0] insadd_line;
	reg readins;
	reg writeins;
	reg clk;
	reg rst;
	reg Trans1PC;
	reg ldPC;
	reg read1;
	reg read2;
	reg write;
	reg TransX1;
	reg TransX2;
	reg TransX3;
	reg TransY1;
	reg TransY2;
	reg TransY3;
	reg [2:0] func_select;
	reg Trans2PC;
	reg Trans_ALU_Z;
	reg TransYZ;
	reg TDZ;
	reg TopID;
	reg readData;
	reg writeData;

	// Outputs
	wire [15:0] ins_out;
	wire Zin;
	wire Vin;
	wire Sin;
	wire Cin;

	// Instantiate the Unit Under Test (UUT)
	datapath_code uut (
		.ins_out(ins_out), 
		.Zin(Zin), 
		.Vin(Vin), 
		.Sin(Sin), 
		.Cin(Cin), 
		.inswrite_line(inswrite_line), 
		.insadd_line(insadd_line), 
		.readins(readins), 
		.writeins(writeins), 
		.clk(clk), 
		.rst(rst), 
		.Trans1PC(Trans1PC), 
		.ldPC(ldPC), 
		.read1(read1), 
		.read2(read2), 
		.write(write), 
		.TransX1(TransX1), 
		.TransX2(TransX2), 
		.TransX3(TransX3), 
		.TransY1(TransY1), 
		.TransY2(TransY2), 
		.TransY3(TransY3), 
		.func_select(func_select), 
		.Trans2PC(Trans2PC), 
		.Trans_ALU_Z(Trans_ALU_Z), 
		.TransYZ(TransYZ), 
		.TDZ(TDZ), 
		.TopID(TopID), 
		.readData(readData), 
		.writeData(writeData)
	);

	initial begin
		// Initialize Inputs
		inswrite_line = 0;
		insadd_line = 0;
		readins = 0;
		writeins = 0;
		clk = 0;
		rst = 0;
		Trans1PC = 0;
		ldPC = 0;
		read1 = 0;
		read2 = 0;
		write = 0;
		TransX1 = 0;
		TransX2 = 0;
		TransX3 = 0;
		TransY1 = 0;
		TransY2 = 0;
		TransY3 = 0;
		func_select = 0;
		Trans2PC = 0;
		Trans_ALU_Z = 0;
		TransYZ = 0;
		TDZ = 0;
		TopID = 0;
		readData = 0;
		writeData = 0;

	
		 
     inswrite_line=1; 
     insadd_line=16'b0000000000000000;
     inswrite_line=16'b0000010100000101;
	#10
		readins=0;
		writeins=0;
	#10
		readins=1;
		writeins=1;
	
      $monitor($time ,"		Instruction received =  %b",ins_out);
	#10
     insadd_line=16'b0000000000000001;
     inswrite_line=16'b0000001100001111;
 
      //$display($time ,"		Instruction received =  %b",ins_out);
       
	  rst=1;
      #10 
      writeins=1; rst=0;
      readins=1; 
   	 
      Trans1PC=1; 
		ldPC=1; 
      read1=1;
      write=1;
      
		TransY1=0;
		TransY3=0;
		TransX1=0;
		TransX3=0;
		TransX2=0;
      TransY2=1;
		TransYZ=1;
		Trans2PC=0;
		Trans_ALU_Z=0;
		TDZ=0;
   
	
   
      
  end
  
   
   initial
    begin
      readins=1;
      while(1)
		#5 readins=~readins;
    end
	 
  initial
    begin
      clk=1;
      while(1)
		#5 clk=~clk;
    end
	
      
endmodule




module test_sign_extension();
  reg [7:0] in1;
  reg [4:0] in2;
  reg [10:0] in3;
  wire [15:0] out1;
  wire [15:0] out2;
  wire [15:0] out3;

  sign_extension8bit s1(in1,out1);
  sign_extension5bit s2(in2,out2);
  sign_extension11bit s3(in3,out3);

    initial
      begin
	
	#500	
      in1=8'b10101011;
      in2=5'b10111;
 	  in3=11'b11011110111;   
      #1  
    $display($time ,"	Sign extension for 5 bits : Input = %b , Output = %b",in1,out1);
    $display($time ,"	Sign extension for 8 bits : Input = %b , Output = %b", in2,out2);
    $display($time ,"	Sign extension for 11 bits: Input = %b , Output = %b",in3, out3);
  end
  
endmodule




module test_ALU();
 
  wire Carry_Bit_Last, Overflow;
  reg[15:0] X_bus_val;
  reg[15:0] Y_bus_val;
  wire[15:0] Z_bus_val;
  reg[2:0] func_select;
  reg clk;
  
  ALU_DP A ( func_select, X_bus_val, Y_bus_val,Z_bus_val, Carry_Bit_Last, Overflow );
  
  initial
    begin
		#600
		$display("\n\n Displaying the results of ALU operations : ");
      X_bus_val = 16'b0000000000001000;
      Y_bus_val = 16'b0000000000000001;
      func_select=3'b000;
      #1
      $display($time,"		X = %b ,  Y = %b , Z = %b , Carry_out = %b , Overflow = %b",X_bus_val, Y_bus_val,Z_bus_val,Carry_Bit_Last, Overflow);
      #10
       X_bus_val = 16'b0000010000011001;
       Y_bus_val = 16'b0000000000000001;

      func_select=3'b001;
        #1
      $display($time,"		X = %b ,  Y = %b , Z = %b , Carry_out = %b , Overflow = %b",X_bus_val, Y_bus_val,Z_bus_val,Carry_Bit_Last, Overflow);#10
       X_bus_val = 16'b0000001000000011;
       Y_bus_val = 16'b0000001111000001;
     
      func_select=3'b000;
        #1
      $display($time,"		X = %b ,  Y = %b , Z = %b , Carry_out = %b , Overflow = %b",X_bus_val, Y_bus_val,Z_bus_val,Carry_Bit_Last, Overflow);#10
       X_bus_val = 16'b0011110000101001;
       Y_bus_val = 16'b0000000011001001;
     
      func_select=3'b000;
    #1 
	 $display($time,"		X = %b ,  Y = %b , Z = %b , Carry_out = %b , Overflow = %b",X_bus_val, Y_bus_val,Z_bus_val,Carry_Bit_Last, Overflow);  #10
       X_bus_val = 16'b0000000000000001;
       Y_bus_val = 16'b0001111110000001;
    
      func_select=3'b001;
        #1
      
	$display($time,"		X = %b ,  Y = %b , Z = %b , Carry_out = %b , Overflow = %b",X_bus_val, Y_bus_val,Z_bus_val,Carry_Bit_Last, Overflow);	
	end 


	initial
    begin
      
      clk=1;
      while(1)
		#5 clk=~clk;
    end
endmodule




module test_dp_total();
	
	datapath_tb A();
	test_ALU B();
	test_sign_extension C();

endmodule



module Controller(input [15:0] ins,input Zin, input Vin,input Sin,input Cin,input clk,input rst,
	output reg Trans1PC,output reg ldPC, output reg read2, output reg read1, output reg write, output reg TransX1, output reg TransX2, output reg TransX3,
	output reg TransY1, output reg TransY2, output reg TransY3, output reg [2:0] func_select, output reg Trans2PC, output reg Trans_ALU_Z,
	output reg TransYZ, output reg TDZ, output reg TopID, output reg readData, output reg writeData, output reg TransAD);
	 /*wire [15:0] state;
	 wire [15:0] nextstate;*/
	 //addi
	always@(posedge clk)
	begin
		if(ins[15:14]==2'b10)
		 begin
			//reg-alu
			func_select = ins[13:11];
			read1 = 1'b1;
			if(ins[13:11] != 3'b101) read2 = 1'b1;
			
			TransX1 = 1'b1;
			Trans1PC = 1'b1;
			Trans_ALU_Z = 1'b1;
			TransY1 = 1'b1;
			
			$display("ALU REG MODE : FUNC_SEL = %b",func_select);
			
		 end
		 else if(ins[15:14]==2'b11)
		 begin
			//im-alu
			func_select = ins[13:11];
			read1 = 1'b1;
			if(ins[13:11] != 3'b101) read2 = 1'b1;
			
			TransX1 = 1'b1;
			Trans1PC = 1'b1;
			Trans_ALU_Z = 1'b1;
			TransY2 = 1'b1;
			
			$display("ALU IMM MODE : FUNC_SEL = %b",func_select);
			
		 end
		 else if(ins[15:13]==3'b001)
		 begin
			if(ins[12:11]==2'b00)
			begin
				//load reg
				
				read1 = 1'b1;
				read2 = 1'b1;
				TransY1 = 1'b1;
				TransYZ = 1'b1;
				ldPC = 1'b1;
				write = 1'b1;
				$display("\nload reg\n");
				
			end
			else if(ins[12:11]==2'b01)
			begin
				//load imm 
				read1 = 1'b1;
				TransY2 = 1'b1;
				TransYZ = 1'b1;
				ldPC = 1'b1;
				Trans1PC = 1'b1;
				write = 1'b1;
				$display("\nload imm\n");
			end
			else if(ins[12:11]==2'b10)
			begin
				//load base addr
				read2 = 1'b1;
				TransX2 = 1'b1;
				TransY1 = 1'b1;
				TransAD = 1'b1;
				readData  = 1'b1;
				TDZ = 1'b1;
				ldPC = 1'b1;
				write = 1'b1;
				$display("\nload base addr\n");
			end
			else if(ins[12:11]==2'b11)
			begin
				//store base addr
				read1 = 1'b1;
				read2 = 1'b1;
				TopID = 1'b1;
				TransX2 = 1'b1;
				TransY1 = 1'b1;
				func_select = 3'b000;
				writeData = 1'b1;
				TransAD = 1'b1;
				ldPC = 1'b1;
				$display("\nstore base addr\n");
			end
			
		 end
		 else if(ins[15:13]==3'b000)
		 begin
			if(ins[12:11]==2'b10)
			begin
				//jal
				$display("\nJump and link\n");
			end
			else if(ins[12:11]==2'b11)
			begin
				//ret
				$display("\nReturn\n");
			end
			else if(ins[12:11]==2'b00)
			begin
				//unconditional jump
				TransX3 = 1'b1;
				TransY3 = 1'b1;
				Trans2PC = 1'b1;
				ldPC = 1'b1;
				$display("\nJump unconditional\n");
			end
		 end
		 else if(ins[15:14]==2'b01)
		 begin
			if(ins[13:11]==3'b000)
			begin
			
				//jz
				if(Zin) 
					begin
						TransX3 = 1'b1;
						TransY3 = 1'b1;
						Trans2PC = 1'b1;
						ldPC = 1'b1;
						$display("\nJump zero\n");
					end
			end
			else if(ins[13:11]==3'b001)
			begin
				//jnz
				if(!Zin)
					begin
						Trans1PC = 1'b1;
						ldPC = 1'b1;
						$display("\nJump not zero\n");
					end
			end
			else if(ins[13:11]==3'b010)
			begin
				//jc
				if(Cin)
					begin
						TransX3 = 1'b1;
						TransY3 = 1'b1;
						Trans2PC = 1'b1;
						ldPC = 1'b1;
						$display("\nJump Carry\n");
					end
			end
			else if(ins[13:11]==3'b011)
			begin
				//jnc
				if(!Cin)
					begin
						Trans1PC = 1'b1;
						ldPC = 1'b1;
						$display("\nJump not Carry\n");
					end
			end
			else if(ins[13:11]==3'b100)
			begin
				//jv
				if(Vin)
					begin
						TransX3 = 1'b1;
						TransY3 = 1'b1;
						Trans2PC = 1'b1;
						ldPC = 1'b1;
						$display("\nJump overflow\n");
					end
			end
			else if(ins[13:11]==3'b101)
			begin
				//jnv
				if(!Vin)
					begin
						Trans1PC = 1'b1;
						ldPC = 1'b1;
						$display("\nJump not overflow\n");
					end
			end
			else if(ins[13:11]==3'b110)
			begin
				//js
				if(Sin)
					begin
						TransX3 = 1'b1;
						TransY3 = 1'b1;
						Trans2PC = 1'b1;
						ldPC = 1'b1;
						$display("\nJump sign\n");
					end
			end
			else if(ins[13:11]==3'b111)
			begin
				//jns
				if(!Sin)
					begin
						Trans1PC = 1'b1;
						ldPC = 1'b1;
						$display("\nJump not sign\n");
					end
			end
		 end
		 
	end

endmodule

module controller_tb;

	// Inputs
	reg [15:0] ins;
	reg Zin;
	reg Vin;
	reg Sin;
	reg Cin;
	reg clk;
	reg rst;

	// Outputs
	wire Trans1PC;
	wire ldPC;
	wire read2;
	wire read1;
	wire write;
	wire TransX1;
	wire TransX2;
	wire TransX3;
	wire TransY1;
	wire TransY2;
	wire TransY3;
	wire [2:0] func_select;
	wire Trans2PC;
	wire Trans_ALU_Z;
	wire TransYZ;
	wire TDZ;
	wire TopID;
	wire readData;
	wire writeData;
	wire TransAD;

	// Instantiate the Unit Under Test (UUT)
	Controller uut (
		.ins(ins), 
		.Zin(Zin), 
		.Vin(Vin), 
		.Sin(Sin), 
		.Cin(Cin), 
		.clk(clk), 
		.rst(rst), 
		.Trans1PC(Trans1PC), 
		.ldPC(ldPC), 
		.read2(read2), 
		.read1(read1), 
		.write(write), 
		.TransX1(TransX1), 
		.TransX2(TransX2), 
		.TransX3(TransX3), 
		.TransY1(TransY1), 
		.TransY2(TransY2), 
		.TransY3(TransY3), 
		.func_select(func_select), 
		.Trans2PC(Trans2PC), 
		.Trans_ALU_Z(Trans_ALU_Z), 
		.TransYZ(TransYZ), 
		.TDZ(TDZ), 
		.TopID(TopID), 
		.readData(readData), 
		.writeData(writeData), 
		.TransAD(TransAD)
	);

	initial begin
		// Initialize Inputs
		ins = 0;
		Zin = 0;
		Vin = 0;
		Sin = 0;
		Cin = 0;
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		$monitor("Trans1PC = %b, Trans2PC = %b, read1 = %b, read2 = %b, TransX1 = %b, TransX2 = %b, TransX3 = %b, TransY1 = %b,\n",Trans1PC, Trans2PC, read1, read2, TransX1, TransX2, TransX3, TransY1);
		$monitor("readData = %b, writeData = %b, Trans_ALU_Z = %b , func_select = %b",readData,writeData,Trans_ALU_Z,func_select);
		
		#100;
			ins = 16'b1000000000110101;

		#100;
			Zin=1'b1;
			ins = 16'b0100000000110101;

		#100;
			Zin=1'b0;
			ins = 16'b0100100000110101;
			
		#100;
			Cin=1'b0;
			ins = 16'b0101000000110101;
		
		#100;
			Cin=1'b0;
			ins = 16'b0101100000110101;
			
		#100;
			Vin=1'b0;
			ins = 16'b0110000000110101;
		
		#100;
			Vin=1'b0;
			ins = 16'b0110100000110101;	

		#100;
			Sin=1'b0;
			ins = 16'b0111000000110101;

		#100;
			Sin=1'b0;
			ins = 16'b0111100000110101;

		#100;
			
			ins = 16'b0001000000110101;

		#100;
			ins = 16'b0001100000110101;			


		#100;
			ins = 16'b0000000000110101;			
		
		#100;
			ins = 16'b0010000000110101;		

		#100;
			ins = 16'b0010100000110101;			

		#100;
			ins = 16'b0011000000110101;			

		#100;
			ins = 16'b0001110000110101;	

		#100;
			ins = 16'b0011110000110101;		

		#100;
			Zin=1'b0;
			ins = 16'b0100000000110101;
		// Add stimulus here

		
	end
   initial
		begin
			
			forever #50 clk = ~(clk);
		end
endmodule




module TopModule(input [15:0] ins,input clk, input rst,input [15:0] inswrite_line,
 input [15:0]insadd_line, input readins,input writeins
    );

wire [2:0] func_select;
wire [15:0] ins_out;

Controller C(ins,Zin, Vin, Sin, Cin, clk, rst,
	 Trans1PC, ldPC, read2, read1,  write,  TransX1,  TransX2,  TransX3,
	 TransY1, TransY2,  TransY3, func_select,  Trans2PC,  Trans_ALU_Z,
	 TransYZ, TDZ,  TopID,  readData,  writeData,  TransAD);
	 controller_tb A();
	 test_ALU AA();
datapath_code D( ins_out,Zin, Vin, Sin, Cin,inswrite_line,
 insadd_line, readins,writeins, clk, rst,Trans1PC, ldPC,
  read1,read2, write, TransX1, TransX2, TransX3, TransY1, TransY2,
  TransY3,func_select, Trans2PC,Trans_ALU_Z, TransYZ,  TDZ, TopID,
  readData, writeData,TransAD);


endmodule








module TopModule_tb;

	// Inputs
	reg [15:0] ins;
	reg clk;
	reg rst;
	reg [15:0] inswrite_line;
	reg [15:0] insadd_line;
	reg readins;
	reg writeins;
	reg over;
	

	// Instantiate the Unit Under Test (UUT)
	TopModule uut (
		.ins(ins), 
		.clk(clk), 
		.rst(rst), 
		.inswrite_line(inswrite_line), 
		.insadd_line(insadd_line), 
		.readins(readins), 
		.writeins(writeins)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		over = 1'b0;
		
		// Wait 100 ns for global reset to finish
		#100;
      ins = 16'b0001000000110101;
		inswrite_line = 16'b0000000000000001;
		insadd_line = 16'b0000000000000010;
		readins = 1;
		writeins = 0;
		
		
		#100;
      ins = 16'b1000000000110101;
		inswrite_line = 16'b0000000000000001;
		insadd_line = 16'b0000000000000010;
		readins = 1;
		writeins = 0;
		
		#100;
      ins = 16'b1000000000110101;
		inswrite_line = 16'b0000000000000001;
		insadd_line = 16'b0000000000000010;
		readins = 1;
		writeins = 0;
		
		
		#100;
      ins = 16'b0000100000110101;
		inswrite_line = 16'b0000000000000001;
		insadd_line = 16'b0000000000000010;
		readins = 1;
		writeins = 0;
		
		
		
  
		// Add stimulus here

	end
	initial
		begin
			
			forever begin
					//if (!over)
					#50 clk = ~(clk);
					//else clk = 1'b0;
					end
		end
      
endmodule

