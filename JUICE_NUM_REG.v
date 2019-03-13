`timescale 1ns / 1ps
module JUICE_NUM_REG(CLK, IN, SAVE, DEC, RST, OUT
    );

input CLK;
input [0:2] IN;
input SAVE, DEC, RST;
output reg [0:2] OUT;

always @(posedge CLK) begin
	if(RST) 			OUT <= 0;
	else if(SAVE)	OUT <= IN;
	else if(DEC)	OUT <= OUT - 1;
end

endmodule
