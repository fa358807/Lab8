//************************************************************************
// Filename      : stopwatch.v
// Author        : hp
// Function      : Basic up counter module for digital watch
// Last Modified : Date: 2009-03-10
// Revision      : Revision: 1
// Copyright (c), Laboratory for Reliable Computing (LaRC), EE, NTHU
// All rights reserved
//************************************************************************
`include "global.v"
module downcounter_2d(
  digit5,
  digit4,
  digit3,
  digit2,
  digit1,  // 2nd digit of the down counter
  digit0,  // 1st digit of the down counter
  clk,  // global clock
  rst_n,  // low active reset
  en, // enable/disable for the stopwatch
  init_value_h1,
  init_value_h0,
  init_value_m1,
  init_value_m0,
  en_start,
  led
);

output [`BCD_BIT_WIDTH-1:0] digit5; // 2nd digit of the down counter
output [`BCD_BIT_WIDTH-1:0] digit4; // 2nd digit of the down counter
output [`BCD_BIT_WIDTH-1:0] digit3; // 2nd digit of the down counter
output [`BCD_BIT_WIDTH-1:0] digit2; // 2nd digit of the down counter
output [`BCD_BIT_WIDTH-1:0] digit1; // 2nd digit of the down counter
output [`BCD_BIT_WIDTH-1:0] digit0; // 1st digit of the down counter
output [5:0] led;

input [1:0] en_start;
input clk;  // global clock
input rst_n;  // low active reset
input en; // enable/disable for the stopwatch
input [`BCD_BIT_WIDTH-1:0] init_value_h1,init_value_h0,init_value_m1,init_value_m0;

//wire [`BCD_BIT_WIDTH-1:0] digit5,digit4,digit3,digit2,digit1,digit0;

wire br0,br1; // borrow indicator 
wire decrease_enable;
reg [5:0] led;

assign decrease_enable = (en && en_start[0]) && (~((digit0==`BCD_ZERO)&&(digit1==`BCD_ZERO)&&(digit2==`BCD_ZERO)
&&(digit3==`BCD_ZERO)&&(digit4==`BCD_ZERO)&&(digit5==`BCD_ZERO)));

always @(*)
begin
	if(((digit0==`BCD_ZERO)&&(digit1==`BCD_ZERO)&&(digit2==`BCD_ZERO)
	&&(digit3==`BCD_ZERO)&&(digit4==`BCD_ZERO)&&(digit5==`BCD_ZERO)))
		led = 6'b111_111;
	else
		led = 6'b000_000;
end
  
// second down counter
downcounter Udc0(
  .value(digit0),  // counter value 
  .borrow(br0),  // borrow indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst_n(rst_n),  // low active reset
  .decrease(decrease_enable),  // decrease input from previous stage of counter
  .init_value(`BCD_ZERO),  // initial value for the counter
  .limit(`BCD_NINE),  // limit for the counter
  .en(en)  // enable/disable of the counter
);

downcounter Udc1(
  .value(digit1),  // counter value 
  .borrow(br1),  // borrow indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst_n(rst_n),  // low active reset
  .decrease(br0),  // decrease input from previous stage of counter
  .init_value(`BCD_ZERO),  // initial value for the counter
  .limit(`BCD_FIVE),  // limit for the counter
  .en(en)  // enable/disable of the counter
);
//minute
downcounter Udc2(
  .value(digit2),  // counter value 
  .borrow(br2),  // borrow indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst_n(rst_n),  // low active reset
  .decrease(br1),  // decrease input from previous stage of counter
  .init_value(init_value_m0),  // initial value for the counter
  .limit(`BCD_NINE),  // limit for the counter
  .en(en)  // enable/disable of the counter
);

downcounter Udc3(
  .value(digit3),  // counter value 
  .borrow(br3),  // borrow indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst_n(rst_n),  // low active reset
  .decrease(br2),  // decrease input from previous stage of counter
  .init_value(init_value_m1),  // initial value for the counter
  .limit(`BCD_FIVE),  // limit for the counter
  .en(en)  // enable/disable of the counter
);
//hour
downcounter Udc4(
  .value(digit4),  // counter value 
  .borrow(br4),  // borrow indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst_n(rst_n),  // low active reset
  .decrease(br3),  // decrease input from previous stage of counter
  .init_value(init_value_h0),  // initial value for the counter
  .limit(`BCD_NINE),  // limit for the counter
  .en(en)  // enable/disable of the counter
);

downcounter Udc5(
  .value(digit5),  // counter value 
  .borrow(br5),  // borrow indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst_n(rst_n),  // low active reset
  .decrease(br4),  // decrease input from previous stage of counter
  .init_value(init_value_h1),  // initial value for the counter
  .limit(`BCD_FIVE),  // limit for the counter
  .en(en)  // enable/disable of the counter
);

endmodule
