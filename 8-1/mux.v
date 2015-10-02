`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:36:32 09/13/2015 
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
`include "global.v"
module mux(sec0,sec1,min0,min1,hour0,hour1,
dig0,dig1,dig2,dig3,sec,hour,pause
    );

input  [`BCD_BIT_WIDTH-1:0] sec0,sec1,min0,min1,hour0,hour1;
input sec,hour;
input [1:0] pause;
output [`BCD_BIT_WIDTH-1:0] dig0,dig1,dig2,dig3;



reg [`BCD_BIT_WIDTH-1:0] dig0,dig1,dig2,dig3,out0,out1,out2,out3;

always@*
if(pause==2'b01)
begin
	if(sec==`ENABLED && hour==`DISABLED)
	begin
		dig3=min1;
		dig2=min0;
		dig1=sec1;
		dig0=sec0;
	end
	else if(sec==`DISABLED && hour==`ENABLED)
	begin
		if((hour1==`BCD_ZERO)&&(hour0<=`BCD_NINE))
		begin
			dig3=4'd10;
			dig2=4'd15;
			dig1=hour1;
			dig0=hour0;
		end
		else if((hour1==`BCD_ONE)&&(hour0<=`BCD_ONE))
		begin
			dig3=4'd10;
			dig2=4'd15;
			dig1=hour1;
			dig0=hour0;
		end
		else if((hour1==`BCD_ONE)&&(hour0==`BCD_TWO))
		begin
			dig3=4'd11;
			dig2=4'd15;
			dig1=hour1;
			dig0=hour0;
		end
		else if((hour1==4'd2)&&(hour0<=4'd1))
		begin
			dig3=4'd11;
			dig2=4'd15;
			dig1=hour1-4'd2;
			dig0=hour0+4'd8;
		end
		else
		begin
			dig3=4'd11;
			dig2=4'd15;
			dig1=hour1-4'd1;
			dig0=hour0-4'd2;
		end
	end
	else
	begin
		dig3=hour1;
		dig2=hour0;
		dig1=min1;
		dig0=min0;
	end
end

endmodule
