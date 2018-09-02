
module deMUX(output  a,output  b,input x,input ch);
	and a1(a,x,ch);
	and a2(b,x,~ch);

endmodule
module DFF(output reg q,input x,input clk,input clr);
	always@(posedge clk,negedge clr)
		begin 
		if(~clr)q<=0;else q<=x; end
endmodule



module controller(input go,input clk,output [1:0] fselect,output ldPrd,output ldmplier,output initmplier,output initPrd,output ldmpcand,output ldCnt,output TPrd,output shr,output decCnt, input last3,input count0,input mix,input all0, input all1,output over);
	
	
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


//Main top module

module main_module(input go,input clk,input clr,output over,input[7:0] multiplier,input [7:0] multiplicand,output [15:0] product);

wire [1:0] fselect;

datapath d(clk,shr,clr,decCnt,ldPrd,ldCnt,ldmpcand,initPrd,initmplier,ldmplier,TPrd,4'b0011,multiplier,multiplicand,cnt ,mix,all0,all1,ff,last3,fselect,product);
controller c(go,clk,fselect,ldPrd,ldmplier,initmplier,initPrd,ldmpcand,ldCnt,TPrd,shr,decCnt,last3,cnt,mix,all0,all1,over);


endmodule



//test harness of controller


module testController;

	// Inputs
	reg go;
	reg clk;

	reg last3;
	reg count0;
	reg mix;
	reg all0;
	reg all1;

	// Outputs
	wire [1:0] fselect;
	wire ldPrd;
	wire ldmplier;
	wire initmplier;
	wire initPrd;
	wire ldmpcand;
	wire ldCnt;
	wire TMD;
	wire TPrd;
	wire shr;
	wire decCnt;
	wire over;

	// Instantiate the Unit Under Test (UUT)
	controller uut (
		.go(go), 
		.clk(clk), 
		.fselect(fselect), 
		.ldPrd(ldPrd), 
		.ldmplier(ldmplier), 
		.initmplier(initmplier), 
		.initPrd(initPrd), 
		.ldmpcand(ldmpcand), 
		.ldCnt(ldCnt), 
		
		.TPrd(TPrd), 
		.shr(shr), 
		.decCnt(decCnt), 
	 
		.last3(last3), 
		.count0(count0), 
		.mix(mix), 
		.all0(all0), 
		.all1(all1), 
		.over(over)
	);
	initial begin 
	 clk = 0;
    forever begin
    
    #15 clk = ~clk;
    end
	 end
	initial begin
		// Initialize Inputs
		go=0;
		#100;
		go = 1;
		
		
		last3 = 0;
		count0 = 0;
		mix = 0;
		all0 = 0;
		all1 = 1;

		// Wait 100 ns for global reset to finish
		#1000;
        
		// Add stimulus here
			$monitor("ldPrd = %d, ldMplier = %d , ldMpcand = %d ,  TPrd = %d",ldPrd,ldmplier,ldmpcand,TPrd);
	end
      
endmodule


//test harness of top module of Booth's multiplier

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
		multiplier =8'b00000101;
		multiplicand =8'b00010001;
		
		#500
		go=1;
		
		#5000
		$display("%d*%d==%d",multiplicand,multiplier,product);
		// Add stimulus here

	end
      
endmodule

