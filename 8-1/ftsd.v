`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:33:25 03/07/2012 
// Design Name: 
// Module Name:    bcddisplay 
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
module ftsd(
  display, // 14-segment display output
  in  // binary input
);
output [`FTSD_BIT_WIDTH-1:0] display; // 14-segment display out
input [`BCD_BIT_WIDTH-1:0] in; // binary input

reg [`FTSD_BIT_WIDTH-1:0] display; 

// Combinatioanl Logic
always @(in)
  case (in)
    `BCD_BIT_WIDTH'd0: display = `FTSD_ZERO;
	 `BCD_BIT_WIDTH'd1: display = `FTSD_ONE;
	 `BCD_BIT_WIDTH'd2: display = `FTSD_TWO;
	 `BCD_BIT_WIDTH'd3: display = `FTSD_THREE;
	 `BCD_BIT_WIDTH'd4: display = `FTSD_FOUR;
	 `BCD_BIT_WIDTH'd5: display = `FTSD_FIVE;
	 `BCD_BIT_WIDTH'd6: display = `FTSD_SIX;
	 `BCD_BIT_WIDTH'd7: display = `FTSD_SEVEN;
	 `BCD_BIT_WIDTH'd8: display = `FTSD_EIGHT;
	 `BCD_BIT_WIDTH'd9: display = `FTSD_NINE;
	 `BCD_BIT_WIDTH'd10: display = `FTSD_A;
	 `BCD_BIT_WIDTH'd11: display = `FTSD_B;//P
	 `BCD_BIT_WIDTH'd12: display = `FTSD_C;
	 `BCD_BIT_WIDTH'd13: display = `FTSD_D;
	 `BCD_BIT_WIDTH'd14: display = `FTSD_E;
	 `BCD_BIT_WIDTH'd15: display = `FTSD_F;//M
	 default: display = `FTSD_DEF;
  endcase
  
endmodule
