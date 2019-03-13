`timescale 1ns / 1ps
module DUT( START,
				CLK,
				IN_MONEY,
				IN_PRICE_CH,
				IN_KIND,
				IN_NUM,
				IN_PRICE_ADMIN,
				IN_PRICE_ADMIN_END,
				IN_MONEY_ENTER,
				OUT_MONEY,
				OUT_JUICE0_MADE,
				OUT_JUICE1_MADE,
				END,
				OUT_1000WON,
				OUT_500WON,
				OUT_100WON,
				OUT_50WON,
				OUT_JUICE0_PRICE,
				OUT_JUICE1_PRICE,
				OUT_CU_SIGNAL
    );

input START, CLK;
input [0:1] IN_MONEY;
input IN_PRICE_CH, IN_KIND;
input [0:2] IN_NUM;
input IN_PRICE_ADMIN, IN_PRICE_ADMIN_END, IN_MONEY_ENTER;

output [0:15] OUT_MONEY;
output OUT_JUICE0_MADE, OUT_JUICE1_MADE, END;
output OUT_1000WON, OUT_500WON, OUT_100WON, OUT_50WON;
output [0:15] OUT_JUICE0_PRICE;
output [0:15] OUT_JUICE1_PRICE;
output [0:22] OUT_CU_SIGNAL;

wire [0:15] money_now_wire;
wire kind_now_wire;
wire [0:2] num_now_wire;
wire [0:15] price0_now_wire;
wire [0:15] price1_now_wire;

wire [0:22] cuout;

wire money_reg_minus_juice_wire;
wire num_dec_wire;
wire kind_save_wire;

assign OUT_CU_SIGNAL = cuout;
assign money_reg_minus_juice_wire = cuout[14] | cuout[16];
assign num_dec_wire = cuout[14] | cuout[16];
assign kind_save_wire = cuout[7] | cuout[2];


ControlUnit CU(CLK,
					money_now_wire, kind_now_wire, num_now_wire, price0_now_wire, price1_now_wire,
					START,
					IN_PRICE_CH, IN_MONEY, IN_PRICE_ADMIN, IN_PRICE_ADMIN_END, IN_MONEY_ENTER,
					cuout
					);
								
MONEY_REG money(	CLK,
						cuout[11], cuout[10], cuout[9], cuout[8],
						cuout[18], cuout[19], cuout[20], cuout[21],
						cuout[1],
						money_reg_minus_juice_wire,
						price0_now_wire,
						price1_now_wire,
						kind_now_wire,
						money_now_wire
						);
						
PRICE_REG price0(CLK, cuout[4], cuout[3], cuout[0], price0_now_wire);
PRICE_REG price1(CLK, cuout[6], cuout[5], cuout[0], price1_now_wire);

JUICE_NUM_REG juice_num(CLK, IN_NUM, cuout[7], num_dec_wire, cuout[1], num_now_wire);

JUICE_KIND_REG juice_kind(CLK, IN_KIND, kind_save_wire, cuout[1], kind_now_wire);

assign OUT_MONEY = money_now_wire;
assign OUT_JUICE0_MADE = cuout[14];
assign OUT_JUICE1_MADE = cuout[16];
assign END = cuout[0];
assign OUT_1000WON = cuout[18];
assign OUT_500WON = cuout[19];
assign OUT_100WON = cuout[20];
assign OUT_50WON = cuout[21];
assign OUT_JUICE0_PRICE = price0_now_wire;
assign OUT_JUICE1_PRICE = price1_now_wire;


endmodule
