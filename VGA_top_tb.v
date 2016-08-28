`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:07:05 08/20/2016
// Design Name:   VGA_top
// Module Name:   C:/Users/rebi2_000/Desktop/VGA_top/VGA_top_tb.v
// Project Name:  VGA_top
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
	wire video_on;
	wire [2:0] text_on;
	wire [9:0] pixel_x;
	wire [9:0] pixel_y;

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
		.video_on(video_on), 
		.text_on(text_on), 
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y)
	);
	
	
	always
	begin
		#0.5clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		swt1 = 0;
		swt2 = 0;
		swt3 = 0;

		// Wait 100 ns for global reset to finish
		#1;
		
		reset = 0;
        
		// Add stimulus here
		
		#1;
	
		swt1 = 1;


		#1;		
	
	   swt2 = 1;
	
		#1;

		swt3 = 1;		
		 
		#1; 

		
		$stop;
		
	end
      
endmodule

