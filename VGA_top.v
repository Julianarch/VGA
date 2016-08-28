`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:01 08/21/2016 
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
	output wire [2:0] rgb_text,
	output wire hsync, vsync,
	/////
	output wire video_on_wave,
	output wire [9:0] pixel_x_wave, pixel_y_wave,
	output wire pixel_tick_wave,
	
	output wire font_bit_wave,
	output wire [7:0] font_word_wave,
	output wire [3:0] row_add_wave,
	output wire [2:0] bit_add_wave,
	output wire [6:0] char_add_wave,
	output wire pixel_xlast,
	output wire pixel_ylast
    );
	 
	wire [9:0] pixel_x, pixel_y;
	wire video_on, pixel_tick;
	reg [2:0] rgb_reg;
	wire [2:0] rgb_next;
	
	 VGAtext vtext_unit (.clk(clk), .swt1(swt1), .swt2(swt2), .swt3(swt3), .video_on(video_on), .pixel_x(pixel_x), .pixel_y(pixel_y), .rgb_text(rgb_next), .font_word_wave(font_word_wave), .font_bit_wave(font_bit_wave), .row_add_wave(row_add_wave), .bit_add_wave(bit_add_wave), .char_add_wave(char_add_wave), .pixel_xlast(pixel_xlast), .pixel_ylast(pixel_ylast));
	 VGA_sync vsync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync), .video_on(video_on), .p_tick(pixel_tick), .pixel_x(pixel_x), .pixel_y(pixel_y));	
	 
	 always @(posedge clk)
		if (pixel_tick)
			rgb_reg <= rgb_next;

	assign rgb_text = rgb_reg;


assign video_on_wave = video_on;
assign pixel_x_wave = pixel_x;
assign pixel_y_wave = pixel_y;
assign pixel_tick_wave = pixel_tick;

endmodule