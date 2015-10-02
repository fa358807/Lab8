//************************************************************************
// Filename      : stopwatch_disp.v
// Author        : hp
// Function      : stopwatch display unit
// Last Modified : Date: 2009-03-10
// Revision      : Revision: 1
// Copyright (c), Laboratory for Reliable Computing (LaRC), EE, NTHU
// All rights reserved
//************************************************************************
`include "global.v"
module stopwatch(
  display, // 14 segment display control
  ftsd_ctl, // scan control for 14-segment display
  clk, // clock
  rst_n, // low active reset
  in, // input control for FSM
  set,
  set_hour,
  set_minute,
  start,
  pause,
  state_start,
  state_pause,
  led
);

output [5:0] led;
output [1:0] state_start,state_pause;
output [`FTSD_BIT_WIDTH-1:0] display; // 14 segment display control
output [`FTSD_DIGIT_NUM-1:0] ftsd_ctl; // scan control for 14-segment display
input clk; // clock
input rst_n; // low active reset
input in; // input control for FSM
input set;
input set_hour,set_minute;
input start,pause;

wire [`FTSD_SCAN_CTL_BIT_WIDTH-1:0] ftsd_ctl_en; // divided output for ssd scan control
wire clk_d,clk_debounce; // divided clock
wire out_start,out_pause;
wire [1:0] en_start,en_pause;
wire count_enable; // if count is enabled
wire [`BCD_BIT_WIDTH-1:0] init_value_h1,init_value_h0,init_value_m1,init_value_m0;
wire [`BCD_BIT_WIDTH-1:0] dig0,dig1,dig2,dig3,dig4,dig5; // second counter output
wire [`BCD_BIT_WIDTH-1:0] out0,out1,out2,out3;
wire [`BCD_BIT_WIDTH-1:0] ftsd_in; // input to 14-segment display decoder

//**************************************************************
// Functional block
//**************************************************************
// frequency divider 1/(2^25)
freq_div U_FD(
  .clk_out(clk_d), // divided clock
  .clk_debounce(clk_debounce),
  .clk_ctl(ftsd_ctl_en), // divided clock for scan control 
  .clk(clk), // clock from the crystal
  .rst_n(rst_n) // low active reset
);


// stopwatch module
downcounter_2d U_sw(
  .digit5(dig5),
  .digit4(dig4),
  .digit3(dig3),
  .digit2(dig2),
  .digit1(dig1),  // 2nd digit of the down counter
  .digit0(dig0),  // 1st digit of the down counter
  .clk(clk_debounce),  // global clock
  .rst_n(rst_n),  // low active reset
  .en(~set), // enable/disable for the stopwatch
  .init_value_h1(init_value_h1),
  .init_value_h0(init_value_h0),
  .init_value_m1(init_value_m1),
  .init_value_m0(init_value_m0),
  .en_start(en_start),
  .led(led)
);

sixtycounter timer_sixtycounter(
.hour1(init_value_h1), // digit 1 for second
.hour0(init_value_h0), // digit 0 for second
.sec1(init_value_m1), // digit 1 for second
.sec0(init_value_m0), // digit 0 for second
.clk(clk_debounce), // global clock
.rst_n(rst_n), //active low reset
.set(set),
.set_hour(set_hour),
.set_minute(set_minute)
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
  .in0(out3), // 1st input
  .in1(out2), // 2nd input
  .in2(out1), // 3rd input
  .in3(out0),  // 4th input
  .ftsd_ctl_en(ftsd_ctl_en) // divided clock for scan control
);

// binary to 14-segment display decoder
ftsd U_display(
  .display(display), // 14-segment display output
  .in(ftsd_in)  // BCD number input
);

mux U_mux(
  .init_value_h1(init_value_h1),
  .init_value_h0(init_value_h0),
  .init_value_m1(init_value_m1),
  .init_value_m0(init_value_m0),
  .dig5(dig5),
  .dig4(dig4),
  .dig3(dig3),
  .dig2(dig2),
  .dig1(dig1),  
  .dig0(dig0),
  .set(set),
  .out0(out0),
  .out1(out1),
  .out2(out2),
  .out3(out3),
  .en_pause(en_pause)
);

one_pulse start_onepulse(
  .clk(clk_debounce),  // clock input
  .rst_n(rst_n), //active low reset
  .in_trig(start), // input trigger
  .out_pulse(out_start) // output one pulse 
);

one_pulse pause_onepulse(
  .clk(clk_debounce),  // clock input
  .rst_n(rst_n), //active low reset
  .in_trig(pause), // input trigger
  .out_pulse(out_pause) // output one pulse 
);

fsm start_fsm(
.in(out_start),
.en(en_start),
.state(state_start),
.clk(clk_debounce),
.rst_n(rst_n)
    );
	 
fsm pause_fsm(
.in(out_pause),
.en(en_pause),
.state(state_pause),
.clk(clk_debounce),
.rst_n(rst_n)
    );
	 
endmodule
