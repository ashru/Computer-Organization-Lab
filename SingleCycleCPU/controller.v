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
