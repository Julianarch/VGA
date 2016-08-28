`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:49:49 08/21/2016
// Design Name:   VGA_top
// Module Name:   C:/Users/VMWIN7/Desktop/Proy1_me/Proy1_me/VGA_top_tb.v
// Project Name:  Proy1_me
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: VGA_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module VGA_top_tb;

	// Inputs
	reg clk;
	reg reset;
	reg swt1;
	reg swt2;
	reg swt3;

	// Outputs
	wire [2:0] rgb_text;
	wire hsync;
	wire vsync;
	wire video_on_wave;
	wire [9:0] pixel_x_wave;
	wire [9:0] pixel_y_wave;
	wire pixel_tick_wave;
	wire font_bit_wave;
	wire [7:0] font_word_wave;
	wire [3:0] row_add_wave;
	wire [2:0] bit_add_wave;
	wire [6:0] char_add_wave;

	// Instantiate the Unit Under Test (UUT)
	VGA_top uut (
		.clk(clk), 
		.reset(reset), 
		.swt1(swt1), 
		.swt2(swt2), 
		.swt3(swt3), 
		.rgb_text(rgb_text), 
		.hsync(hsync), 
		.vsync(vsync), 
		.video_on_wave(video_on_wave), 
		.pixel_x_wave(pixel_x_wave), 
		.pixel_y_wave(pixel_y_wave), 
		.pixel_tick_wave(pixel_tick_wave), 
		.font_bit_wave(font_bit_wave), 
		.font_word_wave(font_word_wave), 
		.row_add_wave(row_add_wave), 
		.bit_add_wave(bit_add_wave), 
		.char_add_wave(char_add_wave)
	);
	
	always
		begin
			#10 clk = ~clk;
		end

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		swt1 = 0;
		swt2 = 0;
		swt3 = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
		reset = 0;
        
		// Add stimulus here
		#10;
	
		swt1 = 0;
		swt2 = 0;
		swt3 = 0;

		#10;		
	
	   swt1 = 0;
		swt2 = 0;
		swt3 = 1;
	
		#10;

		swt1 = 0;
		swt2 = 1;
		swt3 = 0;	

		#10;
	
		swt1 = 0;
		swt2 = 1;
		swt3 = 1;

		#10;		
	
	   swt1 = 1;
		swt2 = 0;
		swt3 = 0;
	
		#10;

		swt1 = 1;
		swt2 = 0;
		swt3 = 1;
		
		#10;

		swt1 = 1;
		swt2 = 1;
		swt3 = 1;
		
		#10;

		swt1 = 0;
		swt2 = 0;
		swt3 = 1;
		
		
		#17000000; 
		
		$stop;

	end
      
endmodule

