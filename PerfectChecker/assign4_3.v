// structural encoding of datapath



module reg_mod(input [15:0] a,input [15:0] val,input  clk,input sel,input clr,input load,output reg [15:0] b);
	always@(posedge clk or posedge clr)
	begin
      
		if(clr)
			b<=16'b0;
		else
			begin
				if (load && sel )
					 begin b<=a;end
				else if(load)
				   begin b<=val; end
				
		
			end
			
	end
endmodule

module equal_status_detector (input [15:0] i,input [15:0] n,output e); 
wire [15:0] eq;
xor(eq[0],i[0],n[0]);
xor(eq[1],i[1],n[1]);
xor(eq[2],i[2],n[2]);
xor(eq[3],i[3],n[3]);
xor(eq[4],i[4],n[4]);
xor(eq[5],i[5],n[5]);
xor(eq[6],i[6],n[6]);
xor(eq[7],i[7],n[7]);
xor(eq[8],i[8],n[8]);
xor(eq[9],i[9],n[9]);
xor(eq[10],i[10],n[10]);
xor(eq[11],i[11],n[11]);
xor(eq[12],i[12],n[12]);
xor(eq[13],i[13],n[13]);
xor(eq[14],i[14],n[14]);
xor(eq[15],i[15],n[15]);
nor (e,eq[0],eq[1],eq[2],eq[3],eq[4],eq[5],eq[6],eq[7],eq[8],eq[9],eq[10],eq[11],eq[12],eq[13],eq[14],eq[15]);

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
module borrow_status_detector(input [15:0] y,input [15:0] x,output bor);
wire [15:0] a;wire [15:0] o;wire bor1;
subt16bit vl(x,y,o,bor1);
not n17(bor,o[15]);
endmodule

module MUX(output  a,input y,input x,input ch);
	wire ch1,o1,o2;
	not n1(ch1,ch);
	and a1(o1,y,ch);
	and(a2,x,ch1);
	or(a,o1,o2);
	
endmodule

module buf16(output [15:0] b,input [15:0] a);
buf b15(b[15],a[15]);
buf b14(b[14],a[14]);
buf b13(b[13],a[13]);
buf b12(b[12],a[12]);
buf b11(b[11],a[11]);
buf b10(b[10],a[10]);
buf b9(b[9],a[9]);
buf b8(b[8],a[8]);
buf b7(b[7],a[7]);
buf b6(b[6],a[6]);
buf b5(b[5],a[5]);
buf b4(b[4],a[4]);
buf b3(b[3],a[3]);
buf b2(b[2],a[2]);
buf b1(b[1],a[1]);
buf b0(b[0],a[0]);
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

module ALU(input [15:0] x,input [15:0] y,input [2:0] fselect, output  [15:0] z);

and a1(s1,~fselect[0],~fselect[1],~fselect[2]);
and a2(s2,fselect[0],~fselect[1],~fselect[2]);
and a3(s3,~fselect[0],fselect[1],~fselect[2]);
and a4(s4,fselect[0],fselect[1],~fselect[2]);
and a5(s5,~fselect[0],~fselect[1],fselect[2]);
wire [15:0] sum;wire [15:0] diff;wire [15:0] inc;
wire [15:0] sum1;wire [15:0] diff1;wire [15:0] inc1;
and16 a55(sum1,sum,s12);
wire [15:0] s11;
wire [15:0] s12;
wire [15:0] s13;
wire [15:0] s14;
wire [15:0] s15;
rep r1(s11,s1);
rep r2(s12,s2);
rep r3(s13,s3);
rep r4(s14,s4);
rep r5(s15,s5);
Adder16Bit ad(x,y,0,sum,w2);
subt16bit s(x,y,diff,w1);

Adder16Bit ad1(y,16'b0000000000000001,0,inc,w5);
and16 a15(sum1,sum,s12);
and16 a25(diff1,diff,s13);
and16 a35(inc1,inc,s14);
wire [15:0] temp;
or16 o1(temp,sum1,diff1);
or16 o2(z,temp,inc1);
endmodule
module isPerfect_datapath(input rst,input [15:0] x,input [15:0] rem,input sel,input TSW,input TN,input clr,input clk,input TI,input TS,input ldN,input ldI,input ldSum,input [2:0] fselect,output bor,output [15:0] dividend,output [15:0] divisor,output eq,output rflag);

	
	wire [15:0] sum;
	wire [15:0] n; wire [15:0] i;
	wire sw;
	wire [15:0] Xbus;
	wire [15:0] Ybus;
	wire [15:0] Zbus;
	
	
	
	
	buf16 bf1(dividend,n);
	buf16 bf2(divisor,i);
	reg_mod R1(Zbus,x,clk,sel,clr,ldN,n);
   reg_mod R2(Zbus,16'b0000000000000001,clk,sel,clr,ldI,i);
	reg_mod R3(Zbus,16'b0000000000000000,clk,sel,clr,ldSum,sum);
	
	
	wire [15:0] n1;
	subt16bit(n,16'b1,n1,yy);

	borrow_status_detector b1(i,n1,bor); 
	equal_status_detector b2(sum,n,eq); 
	equal_status_detector b3(rem,i,rflag);
	buf16 f1(Ybus,i);
	wire [15:0] temp1;
	wire [15:0] temp2;
	wire [15:0] TN1;
	wire [15:0] TS1;
	rep rp1(TN1,TN);
	rep rp2(TS1,TS);
	and16 an1(temp1,TN1,n);
	and16 an2(temp2,TS1,sum);
	or16 orr(Xbus,temp1,temp2);
	
  ALU A(Xbus,Ybus,fselect,Zbus);
  
endmodule


module divider_datapath(input sel1 , input [15:0] dividend,input [15:0] divisor,input clk,input clr,input TR,input TD,input TQ,input ldRem, input ldDivor,input ldQuot,input [2:0] fselect,output [15:0] rem,output bor);

   
	
	
	wire [15:0] Xbus;
	wire [15:0] Ybus;
	wire [15:0] Zbus;
	wire [15:0] divor;
	wire [15:0] quot;
	reg_mod R4(Zbus,dividend,clk,sel1,clr,ldRem,rem);
	reg_mod R5(Zbus,divisor,clk,sel1,clr,ldDivor,divor);
  reg_mod R6(Zbus,16'b0000000000000,clk,sel1,clr,ldQuot,quot);
	borrow_status_detector b1(rem,divor,bor); 
	buf16 f1(Xbus,rem);
	buf16 f2(Ybus,divor);
	ALU B(Xbus,Ybus,fselect,Zbus);
	
	
endmodule
module deMUX(output  a,output  b,input x,input ch);
	and a1(a,x,ch);
	and a2(b,x,~ch);

endmodule
module DFF(output reg q,input x,input clk,input clr);
	always@(negedge clk,posedge clr)
		begin 
		if(clr)q<=0;else q<=x; end
	endmodule

