 // Controller FSM of isPerfect module

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


 // Controller FSM of divider module

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

    