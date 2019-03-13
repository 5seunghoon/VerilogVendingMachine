`timescale 1ns / 1ps
module PRICE_REG(CLK, PLUS_100, MINUS_100, RST, OUT);
	 
input CLK;
input PLUS_100, MINUS_100;
input RST;
output reg [0:15] OUT;

always @(posedge CLK) begin
	if(RST)					OUT <= 200;
	else if(PLUS_100) 	OUT <= OUT + 100;
	else if(MINUS_100)	OUT <= OUT - 100;
end

endmodule
