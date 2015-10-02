//**************************************************************************
// Filename      : global.v
// Author        : Hsi-Pin Ma
// Function      : global definition or parameters for the project
// Last Modified : Date: 2009-03-10 
// Revision      : Revision: 1
// Copyright (c), Laboratory for Reliable Computing (LaRC), EE, NTHU
// All rights reserved
//**************************************************************************

// Frequency divider
`define FTSD_SCAN_CTL_BIT_WIDTH 2 // number of bits for ftsd scan control
`define FREQ_DIV_BIT 25

// SSD scan
`define FTSD_BIT_WIDTH 15 // FTSD display control bit width
`define FTSD_DIGIT_NUM 4 // number of FTSD digit
`define FTSD_SCAN_CTL_DISP1 4'b0111 // set the value of FTSD 1
`define FTSD_SCAN_CTL_DISP2 4'b1011 // set the value of FTSD 2
`define FTSD_SCAN_CTL_DISP3 4'b1101 // set the value of FTSD 3
`define FTSD_SCAN_CTL_DISP4 4'b1110 // set the value of FTSD 4
`define FTSD_SCAN_CTL_DISPALL 4'b0000 // set the value of FTSD to ALL

// 14-segment display
`define FTSD_BIT_WIDTH 15 // 14-segment display control
`define FTSD_NUM 4 //number of 14-segment display
`define BCD_BIT_WIDTH 4 // BCD bit width
`define FTSD_ZERO  `FTSD_BIT_WIDTH'b0000_0011_1111_111 //0
`define FTSD_ONE   `FTSD_BIT_WIDTH'b1111_1111_1011_011 //1
`define FTSD_TWO   `FTSD_BIT_WIDTH'b0010_0100_1111_111 //2
`define FTSD_THREE `FTSD_BIT_WIDTH'b0000_1100_1111_111 //3
`define FTSD_FOUR  `FTSD_BIT_WIDTH'b1001_1000_1111_111 //4
`define FTSD_FIVE  `FTSD_BIT_WIDTH'b0100_1000_1111_111 //5
`define FTSD_SIX   `FTSD_BIT_WIDTH'b0100_0000_1111_111 //6
`define FTSD_SEVEN `FTSD_BIT_WIDTH'b0001_1111_1111_111 //7
`define FTSD_EIGHT `FTSD_BIT_WIDTH'b0000_0000_1111_111 //8
`define FTSD_NINE  `FTSD_BIT_WIDTH'b0000_1000_1111_111 //9
`define FTSD_A     `FTSD_BIT_WIDTH'b0001_0000_1111_111 //a
`define FTSD_B     `FTSD_BIT_WIDTH'b1110_0001_1111_011 //b
`define FTSD_C     `FTSD_BIT_WIDTH'b0110_0011_1111_111 //c
`define FTSD_D     `FTSD_BIT_WIDTH'b1000_0100_1111_111 //d
`define FTSD_E     `FTSD_BIT_WIDTH'b0110_0000_1111_111 //e
`define FTSD_F     `FTSD_BIT_WIDTH'b0111_0000_1111_111 //f
`define FTSD_DEF   `FTSD_BIT_WIDTH'b1111_1111_1111_111 //default

// BCD counter
`define BCD_BIT_WIDTH 4 // BCD bit width 
`define ENABLED 1 // ENABLE indicator
`define DISABLED 0 // EIDABLE indicator
`define INCREMENT 1'b1 // increase by 1
`define BCD_ZERO 4'd0 // 1 for BCD
`define BCD_ONE 4'd1 // 1 for BCD
`define BCD_TWO 4'd2 // 2 for BCD
`define BCD_THREE 4'd3 // 2 for BCD
`define BCD_FOUR 4'd4 // 2 for BCD
`define BCD_FIVE 4'd5 // 5 for BCD
`define BCD_SIX 4'd6 // 2 for BCD
`define BCD_SEVEN 4'd7 // 2 for BCD
`define BCD_EIGHT 4'd8 // 2 for BCD
`define BCD_NINE 4'd9 // 9 for BCD
`define BCD_DEF 4'd15 // all 1

// FSM
`define STAT_DEF 1'b0 
`define STAT_COUNT 1'b1
`define STAT_PAUSE 1'b0
