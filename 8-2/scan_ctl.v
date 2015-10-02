`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:32 04/11/2009 
// Design Name: 
// Module Name:    scan_ctl 
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
module scan_ctl(
  ftsd_ctl, // ftsd display control signal 
  ftsd_in, // output to ftsd display
  in0, // 1st input
  in1, // 2nd input
  in2, // 3rd input
  in3,  // 4th input
  ftsd_ctl_en // divided clock for scan control
);

output [`BCD_BIT_WIDTH-1:0] ftsd_in; // Binary data 
output [`FTSD_NUM-1:0] ftsd_ctl; // scan control for 14-segment display
input [`BCD_BIT_WIDTH-1:0] in0,in1,in2,in3; // binary input control for the four digits 
input [`FTSD_SCAN_CTL_BIT_WIDTH-1:0] ftsd_ctl_en; // divided clock for scan control

reg [`FTSD_NUM-1:0] ftsd_ctl; // scan control for 14-segment display (in the always block)
reg [`BCD_BIT_WIDTH-1:0] ftsd_in; // 14 segment display control (in the always block)

always @(ftsd_ctl_en)
  case (ftsd_ctl_en)
    2'b00: 
    begin
      ftsd_ctl=`FTSD_SCAN_CTL_DISP1;
      ftsd_in=in0;
    end
    2'b01: 
    begin
      ftsd_ctl=`FTSD_SCAN_CTL_DISP2;
      ftsd_in=in1;
    end
    2'b10: 
    begin
      ftsd_ctl=`FTSD_SCAN_CTL_DISP3;
      ftsd_in=in2;
    end
    2'b11: 
    begin
      ftsd_ctl=`FTSD_SCAN_CTL_DISP4;
      ftsd_in=in3;
    end
    default: 
    begin
      ftsd_ctl=`FTSD_SCAN_CTL_DISPALL;
      ftsd_in=in0;
    end
  endcase

endmodule
