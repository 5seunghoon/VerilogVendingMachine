`timescale 1ns / 1ps
module MONEY_REG( CLK,
						PLUS_1000, PLUS_500, PLUS_100, PLUS_50,
						MINUS_1000, MINUS_500, MINUS_100, MINUS_50,
						RST,
						MINUS_JUICE,
						JUICE0_PRICE,
						JUICE1_PRICE,
						JUICE_KIND,
						OUT
    );

input CLK;
input PLUS_1000, PLUS_500, PLUS_100, PLUS_50, MINUS_1000;
input MINUS_500, MINUS_100, MINUS_50;
input RST;
input MINUS_JUICE;
input [0:15] JUICE0_PRICE, JUICE1_PRICE;
input JUICE_KIND;
output reg [0:15] OUT;

always @(posedge CLK) begin
	if(RST) 					OUT <= 0;
	
	else if(PLUS_1000)	OUT <= OUT + 1000;
	else if(PLUS_500)		OUT <= OUT + 500;
	else if(PLUS_100)		OUT <= OUT + 100;
	else if(PLUS_50)		OUT <= OUT + 50;
	
	else if(MINUS_1000)	OUT <= OUT - 1000;
	else if(MINUS_500)	OUT <= OUT - 500;
	else if(MINUS_100)	OUT <= OUT - 100;
	else if(MINUS_50)		OUT <= OUT - 50;
	
	else if(MINUS_JUICE) begin
		if(!JUICE_KIND) 	OUT <= OUT - JUICE0_PRICE;
		else 					OUT <= OUT - JUICE1_PRICE;
	end
	
end


endmodule
