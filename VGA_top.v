`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:34:09 08/19/2016 
// Design Name: 
// Module Name:    VGA_top 
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
module VGA_top(
	input clk, reset,
	input swt1, swt2, swt3,
	output reg [2:0] rgb_text_j, rgb_text_d, rgb_text_m, rgb_text,
	output wire hsync, vsync,
	output wire video_on,
	output wire [2:0] text_on,
	output wire [9:0] pixel_x, pixel_y

    );

	 wire /*video_on,*/ p_tick;
	// wire [9:0] pixel_x, pixel_y;
	// wire [2:0] text_on;
	 
	 VGA_text vtext_unit (.clk(clk), .swt1(swt1), .swt2(swt2), .swt3(swt3), .pixel_x(pixel_x), .pixel_y(pixel_y), .text_on(text_on), .rgb_text(rgb_text)/*, .rgb_text_j(rgb_text_j), .rgb_text_d(rgb_text_d), .rgb_text_m(rgb_text_m)*/);
	 VGA_sync vsync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync), .video_on(video_on), .p_tick(p_tick), .pixel_x(pixel_x), .pixel_y(pixel_y));	
	 

endmodule
