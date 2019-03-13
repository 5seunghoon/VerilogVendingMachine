`timescale 1ns / 1ps
module ControlUnit( 
CLK,
MONEY_NOW, KIND_NOW, NUM_NOW, PRICE0_NOW, PRICE1_NOW, 
START, 
IN_PRICE_CH, IN_PRICE_MONEY, IN_PRICE_ADMIN, IN_PRICE_ADMIN_END, IN_MONEY_ENTER,
OUT
);

input CLK;
input [0:15] MONEY_NOW;
input KIND_NOW;
input [0:2] NUM_NOW;
input [0:15] PRICE0_NOW;
input [0:15] PRICE1_NOW;
input START, IN_PRICE_CH;
input [0:1] IN_PRICE_MONEY;
input IN_PRICE_ADMIN, IN_PRICE_ADMIN_END, IN_MONEY_ENTER;

output reg [0:22] OUT;

reg [0:22] next_state, state;


parameter IDLE 					= 23'b10000000000000000000000;

parameter START_STATE 			= 23'b01000000000000000000000;
parameter PRICE_ADMIN 			= 23'b00100000000000000000000;
parameter PRICE_DOWN_JUICE0	= 23'b00010000000000000000000;
parameter PRICE_UP_JUICE0		= 23'b00001000000000000000000;
parameter PRICE_DOWN_JUICE1	= 23'b00000100000000000000000;
parameter PRICE_UP_JUICE1		= 23'b00000010000000000000000;

parameter MONEY_INPUT			= 23'b00000001000000000000000;
parameter MONEY_50UP				= 23'b00000000100000000000000;
parameter MONEY_100UP			= 23'b00000000010000000000000;
parameter MONEY_500UP			= 23'b00000000001000000000000;
parameter MONEY_1000UP			= 23'b00000000000100000000000;

parameter MONEY_JUDGE			= 23'b00000000000010000000000;
parameter JUICE0_OUT_READY		= 23'b00000000000001000000000;
parameter JUICE0_OUT_SUC		= 23'b00000000000000100000000;
parameter JUICE1_OUT_READY 	= 23'b00000000000000010000000;
parameter JUICE1_OUT_SUC		= 23'b00000000000000001000000;

parameter MONEY_RETURN			= 23'b00000000000000000100000;
parameter MONEY_RETURN_1000	= 23'b00000000000000000010000;
parameter MONEY_RETURN_500		= 23'b00000000000000000001000;
parameter MONEY_RETURN_100 	= 23'b00000000000000000000100;
parameter MONEY_RETURN_50		= 23'b00000000000000000000010;
parameter END						= 23'b00000000000000000000001;



always @(state, 
			MONEY_NOW, KIND_NOW, NUM_NOW, PRICE0_NOW, PRICE1_NOW, 
			START, 
			IN_PRICE_CH, IN_PRICE_MONEY, IN_PRICE_ADMIN, 
			IN_PRICE_ADMIN_END, IN_MONEY_ENTER ) begin
			
	case(state)
		IDLE: begin
			if(START) 	next_state = START_STATE;
			else 			next_state = IDLE;
		end
		
		START_STATE: begin
			if(IN_PRICE_ADMIN) 	next_state = PRICE_ADMIN;
			else 						next_state = MONEY_INPUT;
		end
		
		PRICE_ADMIN: begin
			if(!KIND_NOW & !IN_PRICE_CH) 		next_state = PRICE_DOWN_JUICE0;
			else if(!KIND_NOW & IN_PRICE_CH) next_state = PRICE_UP_JUICE0;
			else if(KIND_NOW & !IN_PRICE_CH)	next_state = PRICE_DOWN_JUICE1;
			else if(KIND_NOW & IN_PRICE_CH)	next_state = PRICE_UP_JUICE1;
		end
			
		PRICE_DOWN_JUICE0: begin
			if(IN_PRICE_ADMIN_END) 	next_state = START_STATE;
			else							next_state = PRICE_ADMIN;
		end
			
		PRICE_UP_JUICE0: begin
			if(IN_PRICE_ADMIN_END) 	next_state = START_STATE;
			else							next_state = PRICE_ADMIN;
		end
			
		PRICE_DOWN_JUICE1: begin
			if(IN_PRICE_ADMIN_END) 	next_state = START_STATE;
			else							next_state = PRICE_ADMIN;
		end
							
		PRICE_UP_JUICE1: begin
			if(IN_PRICE_ADMIN_END) 	next_state = START_STATE;
			else							next_state = PRICE_ADMIN;
		end
			
		MONEY_INPUT: begin
			if(IN_MONEY_ENTER)		next_state = MONEY_JUDGE;
			else begin
				if(IN_PRICE_MONEY == 0) 		next_state = MONEY_50UP;
				else if(IN_PRICE_MONEY == 1) next_state = MONEY_100UP;
				else if(IN_PRICE_MONEY == 2) next_state = MONEY_500UP;
				else if(IN_PRICE_MONEY == 3)	next_state = MONEY_1000UP;
			end
		end
		
		MONEY_50UP: begin
			next_state = MONEY_INPUT;
		end
		
		MONEY_100UP: begin
			next_state = MONEY_INPUT;
		end
		
		MONEY_500UP: begin
			next_state = MONEY_INPUT;
		end	
		
		MONEY_1000UP: begin
			next_state = MONEY_INPUT;
		end
		
		MONEY_JUDGE: begin
			if(NUM_NOW <= 0)							next_state = MONEY_RETURN;
			else begin
				if(!KIND_NOW) begin
					if(MONEY_NOW >= PRICE0_NOW) 	next_state = JUICE0_OUT_READY;
					else 									next_state = MONEY_RETURN;
				end
				else begin
					if(MONEY_NOW >= PRICE1_NOW) 	next_state = JUICE1_OUT_READY;
					else									next_state = MONEY_RETURN;
				end
			end
		end
		
		JUICE0_OUT_READY: begin
			next_state = JUICE0_OUT_SUC;
		end
		
		JUICE0_OUT_SUC: begin
			next_state = MONEY_JUDGE;
		end
		
		JUICE1_OUT_READY: begin
			next_state = JUICE1_OUT_SUC;
		end
		
		JUICE1_OUT_SUC: begin
			next_state = MONEY_JUDGE;
		end
		
		MONEY_RETURN: begin		
			if(MONEY_NOW >= 1000) 		next_state = MONEY_RETURN_1000;
			else if(MONEY_NOW >= 500)	next_state = MONEY_RETURN_500;
			else if(MONEY_NOW >= 100)	next_state = MONEY_RETURN_100;
			else if(MONEY_NOW >= 50)	next_state = MONEY_RETURN_50;
			else 								next_state = END;
		end
		
		MONEY_RETURN_1000: begin
			next_state = MONEY_RETURN;
		end
		
		MONEY_RETURN_500: begin
			next_state = MONEY_RETURN;
		end		
		
		MONEY_RETURN_100: begin
			next_state = MONEY_RETURN;
		end		
		
		MONEY_RETURN_50: begin
			next_state = MONEY_RETURN;
		end		
		
		END: begin
			next_state = IDLE;
		end
		
		default: next_state = IDLE;
	endcase		
end

always @(posedge CLK) begin
	state <= next_state;
end

always @(state) begin
	OUT = state;
end

endmodule
