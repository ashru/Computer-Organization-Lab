
module datapath_tb;

	// Inputs
	reg [15:0] inswrite_line;
	reg [15:0] insadd_line;
	reg readins;
	reg writeins;
	reg clk;
	reg rst;
	reg Trans1PC;
	reg ldPC;
	reg read1;
	reg read2;
	reg write;
	reg TransX1;
	reg TransX2;
	reg TransX3;
	reg TransY1;
	reg TransY2;
	reg TransY3;
	reg [2:0] func_select;
	reg Trans2PC;
	reg Trans_ALU_Z;
	reg TransYZ;
	reg TDZ;
	reg TopID;
	reg readData;
	reg writeData;

	// Outputs
	wire [15:0] ins_out;
	wire Zin;
	wire Vin;
	wire Sin;
	wire Cin;

	// Instantiate the Unit Under Test (UUT)
	datapath_code uut (
		.ins_out(ins_out), 
		.Zin(Zin), 
		.Vin(Vin), 
		.Sin(Sin), 
		.Cin(Cin), 
		.inswrite_line(inswrite_line), 
		.insadd_line(insadd_line), 
		.readins(readins), 
		.writeins(writeins), 
		.clk(clk), 
		.rst(rst), 
		.Trans1PC(Trans1PC), 
		.ldPC(ldPC), 
		.read1(read1), 
		.read2(read2), 
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
		.writeData(writeData)
	);

	initial begin
		// Initialize Inputs
		inswrite_line = 0;
		insadd_line = 0;
		readins = 0;
		writeins = 0;
		clk = 0;
		rst = 0;
		Trans1PC = 0;
		ldPC = 0;
		read1 = 0;
		read2 = 0;
		write = 0;
		TransX1 = 0;
		TransX2 = 0;
		TransX3 = 0;
		TransY1 = 0;
		TransY2 = 0;
		TransY3 = 0;
		func_select = 0;
		Trans2PC = 0;
		Trans_ALU_Z = 0;
		TransYZ = 0;
		TDZ = 0;
		TopID = 0;
		readData = 0;
		writeData = 0;

	
		 
     inswrite_line=1; 
     insadd_line=16'b0000000000000000;
     inswrite_line=16'b0000010100000101;
	#10
		readins=0;
		writeins=0;
	#10
		readins=1;
		writeins=1;
	
      $monitor($time ,"		Instruction received =  %b",ins_out);
	#10
     insadd_line=16'b0000000000000001;
     inswrite_line=16'b0000001100001111;
 
      //$display($time ,"		Instruction received =  %b",ins_out);
       
	  rst=1;
      #10 
      writeins=1; rst=0;
      readins=1; 
   	 
      Trans1PC=1; 
		ldPC=1; 
      read1=1;
      write=1;
      
		TransY1=0;
		TransY3=0;
		TransX1=0;
		TransX3=0;
		TransX2=0;
      TransY2=1;
		TransYZ=1;
		Trans2PC=0;
		Trans_ALU_Z=0;
		TDZ=0;
   
	
   
      
  end
  
   
   initial
    begin
      readins=1;
      while(1)
		#5 readins=~readins;
    end
	 
  initial
    begin
      clk=1;
      while(1)
		#5 clk=~clk;
    end
	
      
endmodule




module test_sign_extension();
  reg [7:0] in1;
  reg [4:0] in2;
  reg [10:0] in3;
  wire [15:0] out1;
  wire [15:0] out2;
  wire [15:0] out3;

  sign_extension8bit s1(in1,out1);
  sign_extension5bit s2(in2,out2);
  sign_extension11bit s3(in3,out3);

    initial
      begin
	
	#500	
      in1=8'b10101011;
      in2=5'b10111;
 	  in3=11'b11011110111;   
      #1  
    $display($time ,"	Sign extension for 5 bits : Input = %b , Output = %b",in1,out1);
    $display($time ,"	Sign extension for 8 bits : Input = %b , Output = %b", in2,out2);
    $display($time ,"	Sign extension for 11 bits: Input = %b , Output = %b",in3, out3);
  end
  
endmodule




module test_ALU();
 
  wire Carry_Bit_Last, Overflow;
  reg[15:0] X_bus_val;
  reg[15:0] Y_bus_val;
  wire[15:0] Z_bus_val;
  reg[2:0] func_select;
  reg clk;
  
  ALU_DP A ( func_select, X_bus_val, Y_bus_val,Z_bus_val, Carry_Bit_Last, Overflow );
  
  initial
    begin
		#600
		$display("\n\n Displaying the results of ALU operations : ");
      X_bus_val = 16'b0000000000001000;
      Y_bus_val = 16'b0000000000000001;
      func_select=3'b000;
      #1
      $display($time,"		X = %b ,  Y = %b , Z = %b , Carry_out = %b , Overflow = %b",X_bus_val, Y_bus_val,Z_bus_val,Carry_Bit_Last, Overflow);
      #10
       X_bus_val = 16'b0000010000011001;
       Y_bus_val = 16'b0000000000000001;

      func_select=3'b001;
        #1
      $display($time,"		X = %b ,  Y = %b , Z = %b , Carry_out = %b , Overflow = %b",X_bus_val, Y_bus_val,Z_bus_val,Carry_Bit_Last, Overflow);#10
       X_bus_val = 16'b0000001000000011;
       Y_bus_val = 16'b0000001111000001;
     
      func_select=3'b000;
        #1
      $display($time,"		X = %b ,  Y = %b , Z = %b , Carry_out = %b , Overflow = %b",X_bus_val, Y_bus_val,Z_bus_val,Carry_Bit_Last, Overflow);#10
       X_bus_val = 16'b0011110000101001;
       Y_bus_val = 16'b0000000011001001;
     
      func_select=3'b000;
    #1 
	 $display($time,"		X = %b ,  Y = %b , Z = %b , Carry_out = %b , Overflow = %b",X_bus_val, Y_bus_val,Z_bus_val,Carry_Bit_Last, Overflow);  #10
       X_bus_val = 16'b0000000000000001;
       Y_bus_val = 16'b0001111110000001;
    
      func_select=3'b001;
        #1
      
	$display($time,"		X = %b ,  Y = %b , Z = %b , Carry_out = %b , Overflow = %b",X_bus_val, Y_bus_val,Z_bus_val,Carry_Bit_Last, Overflow);	
	end 


	initial
    begin
      
      clk=1;
      while(1)
		#5 clk=~clk;
    end
endmodule




module test_dp_total();
	
	datapath_tb A();
	test_ALU B();
	test_sign_extension C();

endmodule


