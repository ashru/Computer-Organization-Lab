


module FullSub(
    input a,
    input b,
    input c_i,
    output  s,
    output  c_o
    ); 
	  xor(t1,a,b);
	  xor(s,t1,c_i);
	  and(t4,~a,~b,c_i);
	  and(t5,~a,b,~c_i);
	  and(t6,~a,b,c_i);
	  and(t7,a,b,c_i);
	  or(c_o,t4,t5,t6,t7);
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

module Adder9Bit(input [8:0] a,input [8:0] b,input c_i,output  [8:0]s,output  c_o);

	wire[7:0] c;
	FullAdder a1(a[0],b[0],c_i,s[0],c[0]);
	FullAdder a2(a[1],b[1],c[0],s[1],c[1]);
	FullAdder a3(a[2],b[2],c[1],s[2],c[2]);
	FullAdder a4(a[3],b[3],c[2],s[3],c[3]);
	FullAdder a5(a[4],b[4],c[3],s[4],c[4]);
	FullAdder a6(a[5],b[5],c[4],s[5],c[5]);
	FullAdder a7(a[6],b[6],c[5],s[6],c[6]);
	FullAdder a8(a[7],b[7],c[6],s[7],c[7]);
	FullAdder a9(a[8],b[8],c[7],s[8],c_o);
	
endmodule


module subt9bit(input [8:0] a,input [8:0] b,input c_i,output [8:0] s,output bor);
	wire[7:0] c;
	FullSub a1(a[0],b[0],c_i,s[0],c[0]);
	FullSub a2(a[1],b[1],c[0],s[1],c[1]);
	FullSub a3(a[2],b[2],c[1],s[2],c[2]);
	FullSub a4(a[3],b[3],c[2],s[3],c[3]);
	FullSub a5(a[4],b[4],c[3],s[4],c[4]);
	FullSub a6(a[5],b[5],c[4],s[5],c[5]);
	FullSub a7(a[6],b[6],c[5],s[6],c[6]);
	FullSub a8(a[7],b[7],c[6],s[7],c[7]);
	FullSub a9(a[8],b[8],c[7],s[8],bor);
endmodule






module Mux2to1(input a,input b,input ch,output c);
and a1(p,ch,a);
and a2(q,~ch,b);
or o(c,p,q);
endmodule

module ALU(input [8:0] x ,input[8:0] y,input [1:0] fselect, output  [8:0] z);
	wire [8:0] w;wire [8:0] v;
	wire [8:0] sum;
	wire [8:0] diff;
	
	
	Mux2to1 m1(1'b0,y[0],fselect[0],w[0]);
	Mux2to1 m2(y[0],y[1],fselect[0],w[1]);
	Mux2to1 m3(y[1],y[2],fselect[0],w[2]);
	Mux2to1 m4(y[2],y[3],fselect[0],w[3]);
	Mux2to1 m5(y[3],y[4],fselect[0],w[4]);
	Mux2to1 m6(y[4],y[5],fselect[0],w[5]);
	Mux2to1 m7(y[5],y[6],fselect[0],w[6]);
	Mux2to1 m8(y[6],y[7],fselect[0],w[7]);
	Mux2to1 m9(y[7],y[8],fselect[0],w[8]);
	buf f1(v[8],x[8]);
	buf f2(v[7],x[7]);
	buf f3(v[6],x[6]);
	buf f4(v[5],x[5]);
	buf f5(v[4],x[4]);
	buf f6(v[3],x[3]);
	buf f7(v[2],x[2]);
	buf f8(v[1],x[1]);
	buf f9(v[0],x[0]);
	Adder9Bit xc(v,w,1'b0,sum,wir1);
	subt9bit xc2(v,w,1'b0,diff,wir2);
	

	
	and n0(e0,sum[0],fselect[1]);
	and n1(e1,sum[1],fselect[1]);
	and n2(e2,sum[2],fselect[1]);
	and n3(e3,sum[3],fselect[1]);
	and n4(e4,sum[4],fselect[1]);
	and n5(e5,sum[5],fselect[1]);
	and n6(e6,sum[6],fselect[1]);
	and n7(e7,sum[7],fselect[1]);
	and n8(e8,sum[8],fselect[1]);
	
	
	and d0(j0,diff[0],~fselect[1]);
	and d1(j1,diff[1],~fselect[1]);
	and d2(j2,diff[2],~fselect[1]);
	and d3(j3,diff[3],~fselect[1]);
	and d4(j4,diff[4],~fselect[1]);
	and d5(j5,diff[5],~fselect[1]);
	and d6(j6,diff[6],~fselect[1]);
	and d7(j7,diff[7],~fselect[1]);
	and d8(j8,diff[8],~fselect[1]);
	
	or r0(z[0],e0,j0);
	or r1(z[1],e1,j1);
	or r2(z[2],e2,j2);
	or r3(z[3],e3,j3);
	or r4(z[4],e4,j4);
	or r5(z[5],e5,j5);
	or r6(z[6],e6,j6);
	or r7(z[7],e7,j7);
	or r8(z[8],e8,j8);
	
endmodule



module reg_mod(input [7:0] a,input [7:0] new,input [7:0] val,input  clk,input shr,input clr,input load,input init,output reg [7:0] b);
	always@(posedge clk or negedge clr)
	begin
	if(~clr)
			b<=8'b00000000;
			else if(init)
			b<=val;
		else if(shr)
		b<=new;
		 else if(clr && load)
			b<=a;
			else
			b<=b;
		
	end
endmodule
module reg_mod4(input [8:0] a,input [8:0] new,input [8:0] val,input  clk,input shr,input clr,input load,input init,output reg [8:0] b);
	always@(posedge clk or negedge clr)
	begin
	if(~clr)
			b<=9'b000000000;
			else if(init)
			b<=val;
		else if(shr)
		b<=new;
		 else if(clr && load)
			b<=a;
			else
			b<=b;
		
	end
endmodule

module reg_mod2(input [7:0] val,input  clk,input clr,input load,output reg [7:0] b);
	always@(posedge clk or negedge clr)
	begin
		
		 if(~clr)
			b<=8'b00000000;
			else if(load)
			b<=val;
			else
			b<=b;
		
	end
endmodule


module reg_cnt(input [3:0] val,input [3:0] new,input  clk,input clr,input load,input dec,output reg [3:0] b);
	always@(posedge clk or negedge clr)
	begin
	
	if(~clr)
	begin
		b<=4'b0000;
		
		end
		else if(load)
		begin
		b<=val;
		
		end
	else if(dec)
	begin b<=new;end
	 
	else begin b<=b;end
	end
endmodule

module modbit(input b,input shr,input clk,input clr,output reg o);
always@(posedge clk)
begin
if(shr)
o<=b;
if(~clr)
o<=0;
end
endmodule

module shift_r(input [7:0]mplier,input [8:0] prd,output [7:0] mplier_nw,output [8:0] prd_nw);
buf b1(mplier_nw[0],mplier[2]);
buf b2(mplier_nw[1],mplier[3]);
buf b3(mplier_nw[2],mplier[4]);
buf b4(mplier_nw[3],mplier[5]);
buf b5(mplier_nw[4],mplier[6]);
buf b6(mplier_nw[5],mplier[7]);
buf b7(mplier_nw[6],prd[0]);
buf b8(mplier_nw[7],prd[1]);
buf b9(prd_nw[0],prd[2]);
buf b10(prd_nw[1],prd[3]);
buf b11(prd_nw[2],prd[4]);
buf b12(prd_nw[3],prd[5]);
buf b13(prd_nw[4],prd[6]);
buf b14(prd_nw[5],prd[7]);
buf b15(prd_nw[6],prd[8]);
buf b16(prd_nw[7],prd[8]);
buf b17(prd_nw[8],prd[8]);
endmodule
module dec(input [3:0] a,output [3:0] s);
	wire[2:0] c;
	FullSub a1(a[0],1'b1,1'b0,s[0],c[0]);
	FullSub a2(a[1],1'b0,c[0],s[1],c[1]);
	FullSub a3(a[2],1'b0,c[1],s[2],c[2]);
	FullSub a4(a[3],1'b0,c[2],s[3],c_0);
endmodule


module countdet(input [3:0]count,output s);
nor(s,count[0],count[1],count[2],count[3]);
endmodule

module datapath(input clk,input shr,  input clr , input decCnt , input ldPrd, input ldCnt,input ldmpcand,input initPrd,input initmplier, 
						input ldmplier , input TPrd , input [3:0]count,input [7:0] multiplier,input [7:0] multiplicand,
						output cnt0 , output mix , output all0 , output all1 ,output ff,output last3,input [1:0] fselect,output [15:0] product);
	wire[8:0] Xbus;
	wire[8:0] Ybus;
	wire[8:0] Zbus;

	wire [7:0] temp3;
	wire [3:0] cnt;
	wire [7:0] mplier_nw;
	wire [3:0] cnt_nw;
	wire [8:0] prd_nw;
	wire [8:0] prd;
	wire [7:0] mplier;
	wire [7:0] mpcand;
	countdet cd(cnt,cnt0);
	wire [8:0] temp4;
	buf(temp4[8],Zbus[8]);
	buf(temp4[7],Zbus[7]);
	buf(temp4[6],Zbus[6]);
	buf(temp4[5],Zbus[5]);
	buf(temp4[4],Zbus[4]);
	buf(temp4[3],Zbus[3]);
	buf(temp4[2],Zbus[2]);
	buf(temp4[1],Zbus[1]);
	buf(temp4[0],Zbus[0]);
	reg_mod4 R3(temp4,prd_nw,9'b000000000,clk,shr,clr,ldPrd,initPrd,prd);
	reg_mod R4(temp3,mplier_nw,multiplier,clk,shr,clr,ldmplier,initmplier,mplier);
	reg_mod2 R5(multiplicand, clk,clr,ldmpcand,mpcand);
	reg_cnt R6(count,cnt_nw,clk,clr,ldCnt,decCnt,cnt);
   modbit mb(mplier[1],shr,clk,clr,ff);
	nor a0(all0,ff,mplier[0]);
	and a1(all1,ff,mplier[0]);

shift_r srt(mplier,prd,mplier_nw,prd_nw);
dec dc(cnt, cnt_nw);
xor a3(mix,ff,mplier[0]);


	buf(last3,mplier[1]);
	buf b1(Xbus[8],prd[8]);
	buf b2(Xbus[0],prd[0]);
	buf b3(Xbus[1],prd[1]);
	buf b4(Xbus[2],prd[2]);
	buf b5(Xbus[3],prd[3]);
	buf b6(Xbus[4],prd[4]);
	buf(Xbus[5],prd[5]);
	buf(Xbus[6],prd[6]);
	buf(Xbus[7],prd[7]);
	buf(Ybus[0],mpcand[0]);
	buf(Ybus[1],mpcand[1]);
	buf(Ybus[2],mpcand[2]);
	buf(Ybus[3],mpcand[3]);
	buf(Ybus[4],mpcand[4]);
	buf(Ybus[5],mpcand[5]);
	buf(Ybus[6],mpcand[6]);
	buf(Ybus[7],mpcand[7]);
	buf(Ybus[8],mpcand[7]);
	buf(temp3[0],mplier[0]);
	buf(temp3[1],mplier[1]);
	buf(temp3[2],mplier[2]);
	buf(temp3[3],mplier[3]);
	buf(temp3[4],mplier[4]);
	buf(temp3[5],mplier[5]);
	buf(temp3[6],mplier[6]);
	buf(temp3[7],mplier[7]);
	
	buf(product[0],mplier[0]);
	buf(product[1],mplier[1]);
	buf(product[2],mplier[2]);
	buf(product[3],mplier[3]);
	buf(product[4],mplier[4]);
	buf(product[5],mplier[5]);
	buf(product[6],mplier[6]);
	buf(product[7],mplier[7]);
	buf(product[8],prd[0]);
	buf(product[9],prd[1]);
	buf(product[10],prd[2]);
	buf(product[11],prd[3]);
	buf(product[12],prd[4]);
	buf(product[13],prd[5]);
	buf(product[14],prd[6]);
	buf(product[15],prd[7]);
	
	ALU A(Xbus,Ybus,fselect,Zbus);

endmodule


module deMUX(output  a,output  b,input x,input ch);
	and a1(a,x,ch);
	and a2(b,x,~ch);

endmodule
module DFF(output reg q,input x,input clk,input clr);
	always@(posedge clk,negedge clr)
		begin 
		if(~clr)q<=0;else q<=x; end
endmodule



module controller(input go,input clr,input clk,output [1:0] fselect,output ldPrd,output ldmplier,output initmplier,output initPrd,output ldmpcand,output ldCnt,output TPrd,output shr,output decCnt, input last3,input count0,input mix,input all0, input all1,output over);
	
	
	DFF d0(q0,dq0,clk,clr);
	DFF d1(q1,dq1,clk,clr);
	DFF d2(q2,dq2,clk,clr);
	DFF d3(q3,dq3,clk,clr);
	DFF d4(q4,dq4,clk,clr);
	DFF d5(q5,dq5,clk,clr);
	DFF d6(q6,dq6,clk,clr);
	DFF d7(q7,dq7,clk,clr);
	DFF d8(q8,dq8,clk,clr);
	DFF dtemp1(qtemp1,dqtemp1,clk,clr);
	DFF dtemp2(qtemp2,dqtemp2,clk,clr);
	DFF dtemp3(qtemp3,dqtemp3,clk,clr);
	
	buf b0(dq0,~go);
	and b1(dq1,go,q0);
	and b2(dq2,qtemp2,mix);
	and b3(dq3,qtemp2,all1);
	and b4(dq4,qtemp3,all0);
	and b5(dq5,qtemp3,mix);
	and b11(dir1,qtemp2,all0);
	and b12(dir2,qtemp3,all1);
	or b6(dq6,dir1,dir2,q2,q3,q4,q5);
	buf b7(dq7,q6);
	and b14(temp18,q7,count0);
	and b15(temp28,q1,count0);
	or b8(dq8,temp18,temp28,dq82);
	or btemp1(dqtemp1,dqtemp11,dqtemp12);
	and btemp4(dqtemp11,~count0,q1);
	and btemp5(dqtemp12,~count0,q7);
	and btemp2(dqtemp2,qtemp1,~last3);
	and btemp3(dqtemp3,qtemp1,last3);
	and b51(dq82,q8,go);
	
	
	
	buf n1(ldmpcand,q0);
	buf n20(initmplier,q0);
	buf n2(initPrd,q0);
	buf n21(ldCnt,q0);
	or n22(ldPrd,q2,q3,q4,q5);
	or n23(ldmplier,q2,q3,q4,q5);
	or n7(TMP,q2,q3,q4,q5);
	or n8(TPrd,q2,q3,q4,q5);
	or n9(fselect[0],q3,q4);
	or n15(fselect[1],q2,q3);
	buf n10(shr,q6);
	buf n11(decCnt,q7);
	buf(over,q8);
	
endmodule

module main_module(input go,input clk,input clr,output over,input[7:0] multiplier,input [7:0] multiplicand,output [15:0] product);

wire [1:0] fselect;

datapath d(clk,shr,clr,decCnt,ldPrd,ldCnt,ldmpcand,initPrd,initmplier,ldmplier,TPrd,4'b0011,multiplier,multiplicand,cnt ,mix,all0,all1,ff,last3,fselect,product);
controller c(go,clr,clk,fselect,ldPrd,ldmplier,initmplier,initPrd,ldmpcand,ldCnt,TPrd,shr,decCnt,last3,cnt,mix,all0,all1,over);


endmodule


// TEST BENCH 

module test_complete;

	// Inputs
	reg clk;
	reg clr;
	reg go;
	reg [7:0] multiplier;
	reg [7:0] multiplicand;
	

	// Outputs
	wire over;
	wire [15:0] product;

	// Instantiate the Unit Under Test (UUT)
	main_module uut (
	.go(go),
		.clk(clk), 
		.clr(clr), 
		.over(over), 
		.multiplier(multiplier), 
		.multiplicand(multiplicand),  
		.product(product)
	);
	initial begin 
	 clk = 0;
    forever begin
    
    #15 clk = ~clk;
    end
	 end
	initial begin
		// Initialize Inputs
		
		clr = 0;
		multiplier = 0;
		multiplicand = 0;
		
		go=0;
		// Wait 100 ns for global reset to finish
		#100;
		
        clr = 1;
		multiplier =8'b11111111;
		multiplicand =8'b11111111;
		
		#500
		go=1;
		
		#5000
		$display("%d*%d==%d",multiplicand,multiplier,product);
		// Add stimulus here

	end
      
endmodule

