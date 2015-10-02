`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:36 09/15/2015 
// Design Name: 
// Module Name:    mux 
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
module mux(
out0,out1,out2,out3,
set,
dig0,dig1,dig2,dig3,dig4,dig5,
init_value_m0,init_value_m1,init_value_h0,init_value_h1,
en_pause
    );

output [3:0] out0,out1,out2,out3;
input set;
input [1:0] en_pause;
input [3:0] dig0,dig1,dig2,dig3,dig4,dig5;
input [3:0] init_value_m0,init_value_m1,init_value_h0,init_value_h1;

reg [3:0] out0,out1,out2,out3;

always@*
if(en_pause==2'b01)
begin
	if(set)
	begin
		out3=init_value_h1;
		out2=init_value_h0;
		out1=init_value_m1;
		out0=init_value_m0;
	end
	else
	begin
		out3=dig5;
		out2=dig4;
		out1=dig3;
		out0=dig2;
	end
end

endmodule
