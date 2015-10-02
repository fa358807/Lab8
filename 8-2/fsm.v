`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:30:37 09/15/2015 
// Design Name: 
// Module Name:    fsm 
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
`define STAT_DEF 2'b00
`define STAT_START 2'b01
`define STAT_STOP 2'b10
`define ENABLED 1
`define DISABLED 0
module fsm(
in,
en,
state,
clk,
rst_n
    );

input in;
input clk;
input rst_n;
output [1:0]en;
output [1:0]state;
reg [1:0]state,next_state;
reg [1:0]en;

always@*
	case(state)
		`STAT_DEF:
		if(in)
		begin
			next_state = `STAT_START;
			en = 2'b01;
		end
		else
		begin
			next_state = `STAT_DEF;
			en = 2'b00;
		end
		`STAT_START:
		if(in)
		begin
			next_state = `STAT_STOP;
			en = 2'b10;
		end
		else
		begin
			next_state = `STAT_START;
			en = 2'b01;
		end
		`STAT_STOP:
		if(in)
		begin
			next_state = `STAT_START;
			en = 2'b01;
		end
		else
		begin
			next_state = `STAT_STOP;
			en = 2'b10;
		end
		default:
		begin
			next_state = `STAT_DEF;
			en = 2'b00;
		end
	endcase
	
always @(posedge clk or negedge rst_n)
	if (~rst_n)
		state <= `STAT_DEF;
	else
		state <= next_state;	

endmodule
