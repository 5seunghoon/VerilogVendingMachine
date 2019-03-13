`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:53:44 06/08/2018
// Design Name:   DUT
// Module Name:   /home/ise/ISE_SHARED/vending/DUT_testbench01.v
// Project Name:  vending
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DUT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DUT_testbench01;

	// Inputs
	reg START;
	reg CLK;
	reg [0:1] IN_MONEY;
	reg IN_PRICE_CH;
	reg IN_KIND;
	reg [0:2] IN_NUM;
	reg IN_PRICE_ADMIN;
	reg IN_PRICE_ADMIN_END;
	reg IN_MONEY_ENTER;

	// Outputs
	wire [0:15] OUT_MONEY;
	wire OUT_JUICE0_MADE;
	wire OUT_JUICE1_MADE;
	wire END;
	wire OUT_1000WON;
	wire OUT_500WON;
	wire OUT_100WON;
	wire OUT_50WON;
	wire [0:15] OUT_JUICE0_PRICE;
	wire [0:15] OUT_JUICE1_PRICE;
	wire [0:22] OUT_CU_SIGNAL;

	// Instantiate the Unit Under Test (UUT)
	DUT uut (
		.START(START), 
		.CLK(CLK), 
		.IN_MONEY(IN_MONEY), 
		.IN_PRICE_CH(IN_PRICE_CH), 
		.IN_KIND(IN_KIND), 
		.IN_NUM(IN_NUM), 
		.IN_PRICE_ADMIN(IN_PRICE_ADMIN), 
		.IN_PRICE_ADMIN_END(IN_PRICE_ADMIN_END), 
		.IN_MONEY_ENTER(IN_MONEY_ENTER), 
		.OUT_MONEY(OUT_MONEY), 
		.OUT_JUICE0_MADE(OUT_JUICE0_MADE), 
		.OUT_JUICE1_MADE(OUT_JUICE1_MADE), 
		.END(END), 
		.OUT_1000WON(OUT_1000WON), 
		.OUT_500WON(OUT_500WON), 
		.OUT_100WON(OUT_100WON), 
		.OUT_50WON(OUT_50WON), 
		.OUT_JUICE0_PRICE(OUT_JUICE0_PRICE), 
		.OUT_JUICE1_PRICE(OUT_JUICE1_PRICE), 
		.OUT_CU_SIGNAL(OUT_CU_SIGNAL)
	);

	initial begin
		// Initialize Inputs
		START = 0;
		CLK = 0;
		IN_MONEY = 0;
		IN_PRICE_CH = 0;
		IN_KIND = 0;
		IN_NUM = 0;
		IN_PRICE_ADMIN = 0;
		IN_PRICE_ADMIN_END = 0;
		IN_MONEY_ENTER = 0;

		// Wait 100 ns for global reset to finish
		/*
		#48;
		// Add stimulus here
		START = 1;
		#20 		START = 0;
					IN_PRICE_ADMIN = 1;
					IN_KIND = 0;
					IN_PRICE_CH = 1;
		#60		IN_KIND = 1;
		#40		IN_PRICE_ADMIN = 0;
					IN_PRICE_ADMIN_END = 1;
		#80		START = 1;
		#20		START = 0;
					IN_MONEY = 1;
		#120		IN_MONEY = 3;
		#160		IN_MONEY = 2;
		#80		IN_MONEY = 0;
		#280		IN_MONEY_ENTER = 1;
					IN_KIND = 1;
					IN_NUM = 4;
		#40		IN_MONEY_ENTER = 0;
		*/
		
		#480		START = 1;
		#200		START = 0;
					IN_MONEY = 3;
		#400		IN_MONEY_ENTER = 1;
					IN_NUM = 3;
					IN_KIND = 0;
		#400		IN_MONEY_ENTER = 0;
		
	end
	always begin
		#100 CLK = !CLK;
	end
      
endmodule

