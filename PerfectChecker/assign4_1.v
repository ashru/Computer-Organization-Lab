//MAIN MODULE
module main_module(input [15:0] x,input clk,input go,input clr,output display);
  wire [2:0] fselect;wire [2:0] fselect1;wire[15:0] dividend,divisor,rem;
  isPerfect_datapath A(rst,x,rem,sel,TSW,TN,clr,clk,TI,TS,ldN,ldI,ldSum,fselect,bor,dividend,divisor,eq,rflag1);
  divider_datapath B(sel1 , dividend,divisor,clk,clr,TR,TD,TQ,ldRem,ldDivor,ldQuot,fselect1,rem,bor1);
  FSM_isP C(reset,TSW,TN,clr,clk,TI,TS,ldN,ldI,ldSum,fselect,bor,divide,sel,display,go,over,over_main,eq,rflag1);
  FSM_divider D(reset,clr,clk,divide,TD,TR,ldDivor,ldQuot,ldRem,fselect1,bor1,sel1,over);
  
endmodule

//TEST BENCH
//PLEASE SIMULATE THE CODE FOR MORE THAN 10000 ns for THE PROCESS TO COMPLETE
module test_main;

	// Inputs
	reg [15:0] x;
	reg clk;reg go,clr;

	// Outputs
	wire display;

	// Instantiate the Unit Under Test (UUT)
	main_module uut (
		.x(x), 
		.clk(clk), 
      .go(go),
		.display(display),
		.clr(clr)
	);
  
	initial begin 
	 clk = 0;
    forever begin
    
    #15 clk = ~clk;
    end
end
	initial begin
		// Initialize Inputs
		clr=1;
		#100
		clr=0;
		go=0;
		x=6;
		#100 ;
		
      go=1;
		
		
      	
      #5000 ;    
        $monitor("no = %d , result = %d",x,display);
      
		
   
	end
   	
endmodule