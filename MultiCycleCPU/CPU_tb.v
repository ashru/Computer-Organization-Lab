`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:51:18 10/20/2016
// Design Name:   CPU_top_module
// Module Name:   E:/FPGA/CPUMain/tb_CPU_top_module.v
// Project Name:  CPUMain
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU_top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_CPU_top_module;

	// Inputs
	reg reset;
	reg clock;
	reg [15:0] Mem_Addr;
	reg [15:0] Write_Data;
	reg MemRead1;
	reg MemWrite1;

	// Instantiate the Unit Under Test (UUT)
	CPU_top_module uut (
		.reset(reset), 
		.clock(clock), 
		.Mem_Addr(Mem_Addr), 
		.Write_Data(Write_Data),
		.MemRead1(MemRead1),
		.MemWrite1(MemWrite1)
	);

	initial begin
	#100;
		
		// Initialize Inputs
		reset = 1'b0;
		clock = 1'b0;
		Mem_Addr = 16'b0;
		Write_Data = 16'b0;

		$display("fuck");
		$monitor("%b",reset);
		#100;
			reset = 1'b1;
		

		#300;
			reset = 1'b0;
			Write_Data = 16'b0000000000000001;
			Mem_Addr = 16'b0000000000000001;
			
			MemWrite1 = 1'b1;
			
		#100;
			reset = 1'b0;
			Write_Data = 16'b1001000001000000;
			Mem_Addr = 16'b000000000000001;
			
			
	end
      
	always 
begin	#50 clock = ~(clock);
end	
endmodule

