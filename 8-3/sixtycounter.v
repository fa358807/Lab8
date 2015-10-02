`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:57:30 04/15/2013 
// Design Name: 
// Module Name:    sixtycounter 
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
module sixtycounter(
hour1,
hour0,
sec1, // digit 1 for second
sec0, // digit 0 for second
clk, // global clock
rst_n, //active low reset
set,
set_hour,
set_minute
);

// outputs
output [`BCD_BIT_WIDTH-1:0] hour1; // digit 1 for second
output [`BCD_BIT_WIDTH-1:0] hour0; // digit 1 for second
output [`BCD_BIT_WIDTH-1:0] sec1; // digit 1 for second
output [`BCD_BIT_WIDTH-1:0] sec0; // digit 0 for second
// inputs
input clk; // global clock signal
input rst_n; // low active reset
input set,set_hour,set_minute;


// temporatory nets
reg load_def_sec,load_def_hour; // enabled to load second value
wire cout_sec0, cout_sec1, cout_hour1, cout_hour0; // BCD counter carryout
reg clk_min,clk_hour;

always@*
begin
	if((set==1'd1)&&(set_minute==1'd0))
	begin
		clk_min = clk;
	end
	if(set==1'd0)
	begin
		clk_min = `DISABLED;
	end
end

always@*
begin
	if((set)&&(~set_hour))
	begin
		clk_hour = clk;
	end
	if(~set)
	begin
		clk_hour = `DISABLED;
	end
end



// return from 59 to 00
always @(sec0 or sec1)
  if ((sec1==`BCD_FIVE)&&(sec0==`BCD_NINE))
    load_def_sec = `ENABLED;
  else
    load_def_sec = `DISABLED;
	 
// return from 59 to 00
always @(hour0 or hour1)
  if ((hour1==`BCD_TWO)&&(hour0==`BCD_THREE))
    load_def_hour = `ENABLED;
  else
    load_def_hour = `DISABLED;
	 

//*******************************************************
// minute counter
//*******************************************************
// counter for digit 0
hcounter Udig0(
  .value(sec0),  // digit 0 of second
  .carry(cout_sec0),  // carry out for digit 0
  .clk(clk_min),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(`ENABLED),  // always increasing
  .load_default(load_def_sec),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

// counter for digit 1
hcounter Udig1(
  .value(sec1),  // digit 1 of second
  .carry(cout_sec1),  // carry out for digit 1
  .clk(clk_min),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(cout_sec0),  // increasing when digit 0 carry out
  .load_default(load_def_sec),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

//*******************************************************
// minute hour
//*******************************************************
hcounter Udig2(
  .value(hour0),  // digit 0 of second
  .carry(cout_hour0),  // carry out for digit 0
  .clk(clk_hour),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(`ENABLED),  // always increasing
  .load_default(load_def_hour),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

hcounter Udig3(
  .value(hour1),  // digit 1 of second
  .carry(cout_hour1),  // carry out for digit 1
  .clk(clk_hour),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(cout_hour0),  // increasing when digit 0 carry out
  .load_default(load_def_hour),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

endmodule
