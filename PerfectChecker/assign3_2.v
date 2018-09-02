module reg_mod(input [15:0] a,input [15:0] val,input  clk,input sel,input clr,input load,output reg [15:0] b);
	//reg [15:0] b;
	always@(posedge clk or posedge clr)
	begin
      
		if(clr)
			b<=16'b0;
		else
			begin
				if (load && sel )
					 begin b<=a;  end
				else if(load)
				   begin b<=val; end
				

			end
			
	end
endmodule


module borrow_status_detector(input [15:0] a,input [15:0] b, output reg bor); //structural coding of status detector
  always@(a,b)
    begin if(a>b)bor=0;else bor=1; end
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


module tristate_buff(input [15:0] data_in,input enable,output [15:0] bus);
  
  assign bus = (enable) ? data_in : 'bz;
endmodule



module ALU(input [15:0] x,input [15:0] y,input [2:0] fselect, output reg  [15:0] z, output bor);
	//reg [15:0] z;
  
	

	always@(x or y or fselect)
	begin
      
	    case(fselect)
          3'b000 :begin  z <= x; end
          3'b001 :begin z <= x+y;  end
		    3'b010 : begin
              z <= x-y;
						
						end
          3'b011 :begin  z <= y+16'b0000000000000001;end
		    3'b100 : z <= 16'b0;
	    endcase
	end
endmodule


module isPerfect_datapath(input rst,input [15:0] x,input [15:0] rem,input sel,input TSW,input TN,input clr,input clk,input TI,input TS,input ldN,input ldI,input ldSum,input [2:0] fselect,output bor,output [15:0] dividend,output [15:0] divisor,output eq,output rflag);

	
	wire [15:0] sum;
	wire [15:0] n; wire [15:0] i;
	wire sw;
	wire [15:0] Xbus;
	wire [15:0] Ybus;
	wire [15:0] Zbus;
	
	
	assign dividend = n;
   assign divisor = i;

	reg_mod R1(Zbus,x,clk,sel,clr,ldN,n);
   reg_mod R2(Zbus,16'b0000000000000001,clk,sel,clr,ldI,i);
	reg_mod R3(Zbus,16'b0000000000000000,clk,sel,clr,ldSum,sum);
	borrow_status_detector b1(i,n,bor); 
	equal_status_detector b2(sum,n,eq); 
	equal_status_detector b3(rem,16'b0000000000000000,rflag);
	
	tristate_buff T1(n,TN,Xbus);
	tristate_buff T2(i,TI,Ybus);
	tristate_buff T3(sum,TS,Xbus);
  ALU A(Xbus,Ybus,fselect,Zbus,bor1);
  
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
	tristate_buff T4(rem,TR,Xbus);
	tristate_buff T5(divor,TD,Ybus);
	//tristate_buff T6(quot,TQ,Ybus);

	ALU B(Xbus,Ybus,fselect,Zbus,bor);
	
	
endmodule

module FSM_isP(output reg reset,output reg TSW,output reg TN,output reg clr,input clk,output reg TI,output reg TS,output reg ldN,output reg ldI,output reg ldSum,output reg [2:0] fselect,input bor,output reg divide,output reg sel,output reg display,input go,input over,output reg over_main,input eq,input rflag);
     parameter q0=4'b0000,q1=4'b0001,q2=4'b0010,q3=4'b0011,q4=4'b0100,q5=4'b0101,q6=4'b0110,q7=4'b0111,q8=4'b1000,q9=4'b1001,q10=4'b1010;
     reg [3:0] state,next_state;
     
initial begin
  TSW = 0;
      TN=0;
      clr=0;
    	TI = 0;
      TS=0;
      ldI=0;
      ldN = 0;
      ldSum =0;
      divide=0;
		state = q0;
		next_state=q0;
		
end
  
  always@(posedge clk)
    begin  state<=next_state;
	end
  //always@clk
  //$display("ps=%d",state);
	always@(go,ldI,divide,over,ldSum,bor,ldN)
	begin 
     
    next_state=q0;
	case (state)
      q0:begin  if(go)begin next_state=q1;  end else next_state=q0; end
      q1:begin if(bor==1)next_state=q3 ;else if(eq) next_state=q7; else begin next_state=q8; end 
       
          end
			 q3:next_state=q2;
      q2:begin if(over)next_state=q4;else next_state=q2; end
      q4:begin if(rflag)next_state=q5;else next_state=q6; end
      q5:begin next_state=q6;  end
		q6:begin if(bor)next_state=q3;else if(eq)next_state=q7;else next_state=q8; end
	  
      q7:begin next_state=q9; end
      q8:begin next_state=q9; end
      q9:begin if(go)next_state=q9;else next_state=q0; end
      
    endcase
    end
  always@(state)
	begin 
		TSW = 0;
      TN=0;
      clr=0;
    	TI = 0;
      TS=0;
      ldI=0;
      ldN = 0;
      ldSum =0;
      divide=0;
		sel = 0;
     
	case (state)
      q0:begin sel=0;ldN=1; end
      q1:begin sel=0;ldSum=1;sel=0;ldI=1; end
		q2:begin divide=1;  end
      q3:begin reset=1;end
	q4:begin divide=0; reset=0;  end
	q5:	begin 
      
		ldSum=1; TS=1; TI=1; fselect=3'b001;sel=1; ldSum=1;  //sum<=sum+i;
		end
	q6: begin 
      
		 sel=1;ldI=1;TI=1; fselect=3'b011; 
		end//i<=i+1
	
    q7: display = 1;
    q8: display = 0;
    q9: over_main = 1;
    endcase
    end
endmodule




module FSM_divider(input reset,output reg clr,input clk,input divide,output reg TD,output reg TR,output reg ldDivor,output reg ldQuot,output reg ldRem,output reg [2:0] fselect,input bor,output reg sel1,output reg over);
     parameter q0=4'b0000,q1=4'b0001,q2=4'b0010,q3=4'b0011,q4=4'b0100,q5=4'b0101,q6=4'b0110,q7=4'b0111,q8=4'b1000,q9=4'b1001,q10=4'b1010;
     reg [3:0] state,next_state;
	  initial begin
  clr=0;
      TD=0;
      TR=0;
      ldDivor=0;
      ldQuot=0;
      ldRem=0;
      over=0;
		sel1=0;
		state<=q0;
		next_state<=q0;
end
     always@(divide)
	  state<=q0;
     always@(posedge clk)
     state<=next_state;
  
	always@(divide,TD,TR,ldRem,ldDivor,ldRem)
	begin 
    next_state=q0;  
	case (state)
	q0:begin if (divide) next_state<=q1; else next_state<=q0;end
	q1:begin  if(bor) next_state<=q3; else next_state<=q2; end
	q2:begin  if(bor) next_state<=q3; else next_state<=q4; end
	q3:next_state<=q0;
	q4:next_state<=q2;
	
	
    endcase
    end
    always@(state)
	begin 
		clr=0;
      TD=0;
      TR=0;
      ldDivor=0;
      ldQuot=0;
      ldRem=0;
      over=0;
		sel1=0;
	case (state)
	q0:begin  sel1=0; ldRem=1;sel1 = 0;ldDivor=1;sel1=0;end
	q1:begin  sel1=0; ldRem=1;sel1 = 0;ldDivor=1;sel1=0; end
	q4:begin TR=1;TD=1; fselect=3'b010;sel1=1;ldRem=1; end
	q3:begin over=1;end
	
	
    endcase
    end
	 
endmodule

    

module main_module(input [15:0] x,input clk,input go,output display);
  wire [2:0] fselect;wire [2:0] fselect1;wire[15:0] dividend,divisor,rem;
  isPerfect_datapath A(rst,x,rem,sel,TSW,TN,clr,clk,TI,TS,ldN,ldI,ldSum,fselect,bor,dividend,divisor,eq,rflag1);
  divider_datapath B(sel1 , dividend,divisor,clk,clr,TR,TD,TQ,ldRem,ldDivor,ldQuot,fselect1,rem,bor1);
  FSM_isP C(reset,TSW,TN,clr,clk,TI,TS,ldN,ldI,ldSum,fselect,bor,divide,sel,display,go,over,over_main,eq,rflag1);
  FSM_divider D(reset,clr,clk,divide,TD,TR,ldDivor,ldQuot,ldRem,fselect1,bor1,sel1,over);
  
endmodule



//BELOW IS THE TEST HARNESS





module test_main;

	// Inputs
	reg [15:0] x;
	reg clk;reg go;

	// Outputs
	wire display;

	// Instantiate the Unit Under Test (UUT)
	main_module uut (
		.x(x), 
		.clk(clk), 
      .go(go),
		.display(display)
	);
  
	initial begin 
	 clk = 0;
    forever begin
    
    #1 clk = ~clk;
    end
end
	initial begin
		// Initialize Inputs

		
		  go=0;
		x=28;
		#10   ;
		
      go=1;
		
		
      	
      #5000 ;    
        $display("no = %d , result = %d",x,display);
      
		
   
	end
   	
endmodule