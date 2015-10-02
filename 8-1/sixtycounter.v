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
sec1, // digit 1 for second
sec0, // digit 0 for second
min1, // digit 1 for minute
min0, // digit 0 for minute
hour1,// digit 1 for hour
hour0,// digit 0 for hour
clk, // global clock
rst_n, //active low reset
start
);

// outputs
output [`BCD_BIT_WIDTH-1:0] sec1; // digit 1 for second
output [`BCD_BIT_WIDTH-1:0] sec0; // digit 0 for second
output [`BCD_BIT_WIDTH-1:0] min1; // digit 1 for second
output [`BCD_BIT_WIDTH-1:0] min0; // digit 0 for second
output [`BCD_BIT_WIDTH-1:0] hour1; // digit 1 for second
output [`BCD_BIT_WIDTH-1:0] hour0; // digit 0 for second
// inputs
input clk; // global clock signal
input rst_n; // low active reset
input [1:0]start;
// temporatory nets
reg load_def_sec,load_def_min,load_def_hour,load_def_hour1,out_sec1,out_min1,out_hour1; // enabled to load second value
wire cout_sec0, cout_sec1, cout_min0, cout_min1, cout_hour0, cout_hour1; // BCD counter carryout
reg clk_o;

always@*
begin
	if(start==2'b01)
	begin
		clk_o = clk;
	end
	if(start==2'b10)
	begin
		clk_o = `DISABLED;
	end
end

// return from 59 to 00
always @(sec0 or sec1)
begin
  if ((sec1==`BCD_FIVE)&&(sec0==`BCD_NINE))
  begin
    load_def_sec = `ENABLED;
	 out_sec1 = `ENABLED;
	end
  else
  begin
    load_def_sec = `DISABLED;
	 out_sec1 = `DISABLED;
  end
end

always @(min0 or min1)
begin
  if ((min1==`BCD_FIVE)&&(min0==`BCD_NINE)&&(sec1==`BCD_FIVE)&&(sec0==`BCD_NINE))
  begin
    load_def_min = `ENABLED;
	 out_min1 = `ENABLED;
  end
  else
  begin
    load_def_min = `DISABLED;
	 out_min1 = `DISABLED;
  end
end

  
always @(hour0 or hour1)
begin
  if ((hour1==4'd2)&&(hour0==4'd3)&&(min1==`BCD_FIVE)&&(min0==`BCD_NINE)&&(sec1==`BCD_FIVE)&&(sec0==`BCD_NINE))
  begin
    load_def_hour = `ENABLED;
	 //out_hour1 = `ENABLED;
  end
  else
  begin
    load_def_hour = `DISABLED;
	 //out_hour1 = `DISABLED;
  end
end



// counter for digit 0
hcounter Udig0(
  .value(sec0),  // digit 0 of second
  .carry(cout_sec0),  // carry out for digit 0
  .clk(clk_o),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(`ENABLED),  // always increasing
  .load_default(load_def_sec),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

// counter for digit 1
hcounter Udig1(
  .value(sec1),  // digit 1 of second
  .carry(cout_sec1),  // carry out for digit 1
  .clk(clk_o),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(cout_sec0),  // increasing when digit 0 carry out
  .load_default(load_def_sec),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

hcounter Umin0(
  .value(min0),  // digit 1 of second
  .carry(cout_min0),  // carry out for digit 1
  .clk(clk_o),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(out_sec1),  // increasing when digit 0 carry out
  .load_default(load_def_min),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

hcounter Umin1(
  .value(min1),  // digit 1 of second
  .carry(cout_min1),  // carry out for digit 1
  .clk(clk_o),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(cout_min0),  // increasing when digit 0 carry out
  .load_default(load_def_min),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

hcounter Uhour0(
  .value(hour0),  // digit 1 of second
  .carry(cout_hour0),  // carry out for digit 1
  .clk(clk_o),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(out_min1),  // increasing when digit 0 carry out
  .load_default(load_def_hour),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);

hcounter Uhour1(
  .value(hour1),  // digit 1 of second
  .carry(cout_hour1),  // carry out for digit 1
  .clk(clk_o),  // clock
  .rst_n(rst_n),  // asynchronous low active reset
  .increase(cout_hour0),  // increasing when digit 0 carry out
  .load_default(load_def_hour),  // enable load default value
  .def_value(`BCD_ZERO) // default value for counter
);



endmodule
