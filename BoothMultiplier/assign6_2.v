//Structural encoding of Datapath
//ALU


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



//Test harnesses of Datapath


module testALU;//test fixture of ALU

	// Inputs
	reg [8:0] x;
	reg [8:0] y;
	reg [1:0] fselect;

	// Outputs
	wire [8:0] z;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.x(x), 
		.y(y), 
		.fselect(fselect), 
		.z(z)
	);

	initial begin
		// Initialize Inputs
		x = 0;
		y = 0;
		fselect = 0;

		// Wait 100 ns for global reset to finish
		
		/*#1000;
		x = 10;
		y = 10;
		fselect = 2'b11;
		#15000
		$display("%d",z);*/
		/*#1000;
		x = 10;
		y = 10;
		fselect = 2'b10;
		$display("%d",z);
		#1000;
		x = 10;
		y = 10;
		fselect = 2'b11;
		$display("%d",z);*/
		/*#1000;
		x = 20;
		y = 10;
		fselect = 2'b00;
		#1000
		$display("%d",z);*/
		#1000;
		x = 30;
		y = 10;
		fselect = 2'b01;
		
        	#1000;
		
		$display("%d",z);
        
		// Add stimulus here

	end
      
endmodule

//Testbench of 9 bit adder


module testAdder9Bit;

	// Inputs
	reg [8:0] a;
	reg [8:0] b;
	reg c_i;

	// Outputs
	wire [8:0] s;
	wire c_o;

	// Instantiate the Unit Under Test (UUT)
	Adder9Bit uut (
		.a(a), 
		.b(b), 
		.c_i(c_i), 
		.s(s), 
		.c_o(c_o)
	);

	initial begin
		// Initialize Inputs
		a = 14;
		b = 22;
		c_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
       $monitor("a = %d , b = %d , c_in = %d , sum = %d , c_out = %d",a,b,c_i,s,c_o);
		// Add stimulus here

	end
      
endmodule


//test fiture of 9 bit subtractor

module testSubt9Bit;

	// Inputs
	reg [8:0] a;
	reg [8:0] b;
	reg c_i;

	// Outputs
	wire [8:0] s;
	wire bor;

	// Instantiate the Unit Under Test (UUT)
	subt9bit uut (
		.a(a), 
		.b(b), 
		.c_i(c_i), 
		.s(s), 
		.bor(bor)
	);

	initial begin
		// Initialize Inputs
		a = 33;
		b = 22;
		c_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
        $monitor("a = %d , b = %d , difference = %d , borrow = %d",a,b,s,bor);
		// Add stimulus here

	end
      
endmodule


//test fixture of 2 to 1 mux



module testMux2to1;

	// Inputs
	reg a;
	reg b;
	reg ch;

	// Outputs
	wire c;

	// Instantiate the Unit Under Test (UUT)
	Mux2to1 uut (
		.a(a), 
		.b(b), 
		.ch(ch), 
		.c(c)
	);

	initial begin
		// Initialize Inputs
		a = 1;
		b = 0;
		ch = 0;

		// Wait 100 ns for global reset to finish
		#100;
               $monitor("a = %d , b = %d , ch = %d , c = %d ",a,b,ch,c);

		// Add stimulus here

	end
      
endmodule


//test fixture of full subtractor



module testFullSub;

	// Inputs
	reg a;
	reg b;
	reg c_i;

	// Outputs
	wire s;
	wire c_o;

	// Instantiate the Unit Under Test (UUT)
	FullSub uut (
		.a(a), 
		.b(b), 
		.c_i(c_i), 
		.s(s), 
		.c_o(c_o)
	);

	initial begin
		// Initialize Inputs
		a = 1;
		b = 0;
		c_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
               $monitor("a = %d , b = %d , diff = %d , bor = %d",a,b,s,c_o);

		// Add stimulus here

	end
      
endmodule



//test fixture of full adder




module testFullAdder;

	// Inputs
	reg a;
	reg b;
	reg c_i;

	// Outputs
	wire s;
	wire c_o;

	// Instantiate the Unit Under Test (UUT)
	FullAdder uut (
		.a(a), 
		.b(b), 
		.c_i(c_i), 
		.s(s), 
		.c_o(c_o)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 1;
		c_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
               $monitor("a = %d , b = %d , c_in = %d , sum = %d , c_out = %d",a,b,c_i,s,c_o);

		// Add stimulus here

	end
      
endmodule






//test fixture of module DecCount


module testDecCount;

	// Inputs
	reg [3:0] a;

	// Outputs
	wire [3:0] s;

	// Instantiate the Unit Under Test (UUT)
	dec uut (
		.a(a), 
		.s(s)
	);

	initial begin
		// Initialize Inputs
		a = 4;

		// Wait 100 ns for global reset to finish
		#100;
        $monitor("a = %d , s = %d ",a,s);
		// Add stimulus here

	end
      
endmodule

//test fixture of module shift_r


module testSHR;

	// Inputs
	reg [7:0] mplier;
	reg [8:0] prd;

	// Outputs
	wire [7:0] mplier_nw;
	wire [8:0] prd_nw;

	// Instantiate the Unit Under Test (UUT)
	shift_r uut (
		.mplier(mplier), 
		.prd(prd), 
		.mplier_nw(mplier_nw), 
		.prd_nw(prd_nw)
	);

	initial begin
		// Initialize Inputs
		mplier = 8'b01101101;
		prd = 8'b101101101;

			#500;
      $monitor("mplier = %b , prd = %b , mplier_new = %b , prd_new = %b",mplier,prd,mplier_nw,prd_nw);  
		// Add stimulus here

	end
      
endmodule




//test fixture of entire datapath



module testDatapath;

	// Inputs
	reg clk;
	reg shr;
	reg clr;
	reg decCnt;
	reg ldPrd;
	reg ldCnt;
	reg ldmpcand;
	reg initPrd;
	reg initmplier;
	reg ldmplier;
	reg TPrd;
	reg TMD;
	reg [3:0] count;
	reg [7:0] multiplier;
	reg [7:0] multiplicand;
	reg [1:0] fselect;

	// Outputs
	wire cnt0;
	wire mix;
	wire all0;
	wire all1;
	reg ff;
	wire last3;
	wire [15:0] product;

	// Instantiate the Unit Under Test (UUT)
	datapath uut (
		.clk(clk), 
		.shr(shr), 
		.clr(clr), 
		.decCnt(decCnt), 
		.ldPrd(ldPrd), 
		.ldCnt(ldCnt), 
		.ldmpcand(ldmpcand), 
		.initPrd(initPrd), 
		.initmplier(initmplier), 
		.ldmplier(ldmplier), 
		.TPrd(TPrd), 
		
		.count(count), 
		.multiplier(multiplier), 
		.multiplicand(multiplicand), 
		.cnt0(cnt0), 
		.mix(mix), 
		.all0(all0), 
		.all1(all1), 
		.ff(ff), 
		.last3(last3), 
		.fselect(fselect), 
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
		ff = 0;
		count = 3'b011;	
		
		shr = 0;
		clr = 0;
		decCnt = 0;
		ldPrd = 1;
		ldCnt =1;
		ldmpcand = 1;
		initPrd = 1;
		initmplier = 1;
		ldmplier = 1;
		TPrd = 1;
	
		count = 0;
		multiplier = 4;
		multiplicand = 3;
		fselect = 0;

		// Wait 100 ns for global reset to finish
		#1000;
        
		$monitor("cnt0 =%d , all0 = %d , all1 = %d , mix = %d ",cnt0,all0,all1,mix);

	end
      
endmodule


