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

