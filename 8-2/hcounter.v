`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:32:25 09/14/2015 
// Design Name: 
// Module Name:    hcounter 
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
module hcounter(
value, //counter value
carry, // carry out to enable counting in next stage
clk, //global clock
rst_n, // active low reset
increase, // enable control of the counter
load_default, // enable to load default value
def_value // default value
);

// outputs
output [`BCD_BIT_WIDTH-1:0] value;  // counter value
output carry;  // carry out to enable counting for next stag
// inputs
input clk;  // global clock
input rst_n;  // active low reset
input load_default;  // enable to load default value
input increase;  // enable control of the counter 
input [`BCD_BIT_WIDTH-1:0] def_value;  // counter upper limit

reg [`BCD_BIT_WIDTH-1:0] value; // output (in always block)
reg [`BCD_BIT_WIDTH-1:0] value_tmp; // input to dff (in always block)
reg carry; // carry out indicator for counter to next stage 

// combinational part for BCD counter 
always @*
  if ((increase==`DISABLED)&&(load_default==`DISABLED))
    value_tmp = value;
  else if (load_default==`ENABLED)
    value_tmp = def_value;
  else if ((increase==`ENABLED)&&(value==`BCD_NINE))
    value_tmp = `BCD_ZERO;
  else
    value_tmp = value + `INCREMENT;

always @*
  if ((increase==`ENABLED)&&(value == `BCD_NINE))
    carry = `ENABLED;
  else
    carry = `DISABLED;

// register part for BCD counter
always @(posedge clk or negedge rst_n)
  if (~rst_n) value <= def_value;
  else value <= value_tmp;

endmodule