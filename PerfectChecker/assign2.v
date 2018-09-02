module reg_mod(input [15:0] a,input  clk,input clr,input load,output reg [15:0] b);
	//reg [15:0] b;
	always@(posedge clk or posedge clr)
	begin
		if(clr)
			b<=16'b0;
		else
			begin
				if (load)
					b<=a;
				else
					b<=b;

			end	
	end
endmodule


module borrow_status_detector(input [15:0] a,input [15:0] b, output bor); //structural coding of status detector
	wire [15:0] c;
	not(c[0],b[0]);
	not(c[1],b[1]);
	not(c[2],b[2]);
	not(c[3],b[3]);
	not(c[4],b[4]);
	not(c[5],b[5]);
	not(c[6],b[6]);
	not(c[7],b[7]);
	not(c[8],b[8]);
	not(c[9],b[9]);
	not(c[10],b[10]);
	not(c[11],b[11]);
	not(c[12],b[12]);
	not(c[13],b[13]);
	not(c[14],b[14]);
	not(c[15],b[15]);
	wire carry;
	wire in_carry;
	assign in_carry = 1'b1;
	wire temp1,temp2,temp3,temp4;
	and(temp1,a,b);
	and(temp2,a,in_carry);
	and(temp3,b,in_carry);
	or(temp4,temp1,temp2);
	or(carry,temp4,temp3);
	not(bor,carry);

endmodule

module tristate_buff(input [15:0] data_in,input enable,output [15:0] bus);

    assign bus = (enable) ? data_in : 'bz;
endmodule



module ALU(input [15:0] x,input [15:0] y,input [2:0] fselect, output reg  [15:0] z, output bor);
	//reg [15:0] z;
	
    	
	always@(x or y or fselect)
	begin
	    case(fselect)
		    3'b000 : z <= x;
		    3'b001 : z <= x+y;
		    3'b010 : begin
						z <= x-y;
						borrow_status_detector(x,y, bor);
						end
		    3'b011 : z <= x+1;
		    3'b100 : z <= 16'b0;
	    endcase
	end
endmodule


module isPerfect_datapath(input [15:0] x,input TSW,input TN,input clr,input clk,input TI,input TS,input ldN,input ldI,input ldSum,input [2:0] fselect,output [2:0] display,output bor);

	
	wire [15:0] n;wire i;wire [15:0] sum;wire sw;
	wire [15:0] Xbus;
	wire [15:0] Ybus;
	wire [15:0] Zbus;
	
	
	reg_mod R1(x,clk,clr,ldN,n);
	reg_mod R2(16'b0,clk,clr,ldI,i);
	reg_mod R3(16'b0,clk,clr,ldSum,sum);
	
	tristate_buff T1(n,TN,Xbus);
	tristate_buff T2(sw,TSW,Xbus);
	tristate_buff T3(i,TI,Ybus);
	tristate_buff T4(sum,TS,Ybus);
	ALU A(Xbus,Ybus,fselect,ZBus,bor);

endmodule


module divider_datapath(input [15:0] x,input [15:0] y,input [15:0] z,input clk,input clr,input TR,input TD,input TQ,input ldRem, input ldDivor,input ldQuot,input [2:0] fselect,output [15:0] w,output bor);

    wire [15:0] rem;
	reg_mod R4(x,clk,clr,ldRem,rem);
	reg_mod R5(y,clk,clr,ldDivor,divor);
	reg_mod R6(16'b0,clk,clr,ldQuot,quot);

	wire [15:0] Xbus;
	wire [15:0] Ybus;
	wire [15:0] Zbus;

	tristate_buff T4(rem,TR,Xbus);
	tristate_buff T5(divor,TD,YBus);
	tristate_buff T6(quot,TQ,Ybus);

	ALU B(Xbus,Ybus,fselect,ZBus,bor);
endmodule