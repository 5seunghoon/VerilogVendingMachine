`timescale 1ns / 1ps
module JUICE_KIND_REG(CLK, IN, SAVE, RST, OUT
    );
	 
input CLK, IN, SAVE, RST;
output reg OUT;

always @(posedge CLK) begin
	if(RST) OUT <= 0;
	else if(SAVE) OUT <= IN;
end

endmodule
