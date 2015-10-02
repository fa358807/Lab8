`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:16:49 09/15/2015 
// Design Name: 
// Module Name:    lab8_1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "global.v"
module lab8_1(
  display, // 14 segment display control
  ftsd_ctl, // scan control for 14-segment display
  state,
  state2,
  clk, // clock
  rst_n, // low active reset
  in, // input control for FSM
  start,
  pause,
  sec,
  hour,
  fast,
  slow
);
output [`FTSD_BIT_WIDTH-1:0] display; // 14 segment display control
output [`FTSD_DIGIT_NUM-1:0] ftsd_ctl; // scan control for 14-segment display
output [1:0] state,state2;
input clk; // clock
input rst_n; // low active reset
input in; // input control for FSM
input start,pause;
input sec,hour,fast,slow;

wire [`FTSD_SCAN_CTL_BIT_WIDTH-1:0] ftsd_ctl_en; // divided output for ssd scan control
wire clk_d; // divided clock
wire clk_debounce;
wire count_enable; // if count is enabled
wire [`BCD_BIT_WIDTH-1:0] dig0,dig1,dig2,dig3; // second counter output
wire [`BCD_BIT_WIDTH-1:0] sec0,sec1,min0,min1,hour0,hour1;
wire [`BCD_BIT_WIDTH-1:0] ftsd_in; // input to 14-segment display decoder
wire [1:0] en_start,en_pause;
reg clk_op;

//**************************************************************
// Functional block
//**************************************************************
// frequency divider 1/(2^25)
freq_div U_FD(
  .clk_out(clk_d), // divided clock
  .clk_ctl(ftsd_ctl_en), // divided clock for scan control 
  .clk_debounce(clk_debounce),
  .clk(clk), // clock from the crystal
  .rst_n(rst_n) // low active reset
);

always@*
begin
	if(fast==1'd0)
		clk_op=clk_debounce;
	else if(slow==1'd0)
		clk_op=clk_d;
	else 
		clk_op=clk_d;
end

// 60 up counter
sixtycounter U_60(
  .sec1(sec1), // digit 1 for second
  .sec0(sec0), // digit 0 for second
  .min1(min1),
  .min0(min0),
  .hour1(hour1),
  .hour0(hour0),
  .clk(clk_op), // global clock
  .rst_n(rst_n), //active low reset
  .start(en_start)
);

//**************************************************************
// Display block
//**************************************************************
// BCD to 14-segment display decoding
// seven-segment display decoder for DISP1

// Scan control
scan_ctl U_SC(
  .ftsd_ctl(ftsd_ctl), // ftsd display control signal 
  .ftsd_in(ftsd_in), // output to ftsd display
  .in0(dig3), // 1st input
  .in1(dig2), // 2nd input
  .in2(dig1), // 3rd input
  .in3(dig0),  // 4th input
  .ftsd_ctl_en(ftsd_ctl_en) // divided clock for scan control
);

// binary to 14-segment display decoder
ftsd U_display(
  .display(display), // 14-segment display output
  .in(ftsd_in)  // BCD number input
);

mux U_mux(
.sec0(sec0),
.sec1(sec1),
.min0(min0),
.min1(min1),
.hour0(hour0),
.hour1(hour1),
.dig0(dig0),
.dig1(dig1),
.dig2(dig2),
.dig3(dig3),
.sec(sec),
.hour(hour),
.pause(en_pause)
    );

one_pulse U_start_onepulse(
  .clk(clk_debounce),  // clock input
  .rst_n(rst_n), //active low reset
  .in_trig(start), // input trigger
  .out_pulse(out_start) // output one pulse 
);
one_pulse U_pause_onepulse(
  .clk(clk_debounce),  // clock input
  .rst_n(rst_n), //active low reset
  .in_trig(pause), // input trigger
  .out_pulse(out_pause) // output one pulse 
);

fsm U_startfsm(
.in(out_start),
.en(en_start),
.state(state),
.clk(clk_debounce),
.rst_n(rst_n)
    );
	 
fsm U_pausefsm(
.in(out_pause),
.en(en_pause),
.state(state2),
.clk(clk_debounce),
.rst_n(rst_n)
    );

endmodule
