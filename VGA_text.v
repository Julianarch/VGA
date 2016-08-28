`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:29:09 08/19/2016 
// Design Name: 
// Module Name:    VGA_text 
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
module VGA_text(
	input wire clk,
	input wire swt1, swt2, swt3,
	output wire [9:0] pixel_x, pixel_y,
	output wire [2:0] text_on,//letras o palabras
	output wire [2:0] rgb_text//, rgb_text_m, rgb_text_d, rgb_text_j

    );
	 

//signal declaration


wire [10:0] rom_add;

reg [6:0] char_add;//carga la letra en hexa
reg [6:0] char_add_J, char_add_D, char_add_M;

reg [3:0] row_add;
wire [3:0] row_add_J, row_add_D, row_add_M;

reg [2:0] bit_add;
wire [2:0] bit_add_J, bit_add_D, bit_add_M;

wire [7:0] font_word;
wire j_on, d_on, m_on, font_bit;

font_rom font_unit
(.clk(clk), .addr(rom_add), .data(font_word));

//Para poner J

assign j_on = (pixel_y [9:6] == 2) && ( pixel_x [9:5] == 2 );// && (pixel_x [9:5] <= 4));
assign row_add_J = pixel_y [2:1]; 
assign bit_add_J = pixel_x [2:1];

always @ *
	case (pixel_x[7:4])

		default: char_add_J = 7'h4a;
		
	endcase

//Para poner D

assign d_on = (pixel_y [9:6] == 3) && ( pixel_x [9:5] == 5); //&& (pixel_x [9:5]<=7);
assign row_add_D = pixel_y[3:1];
assign bit_add_D = pixel_x [5:1];

always @*
	case (pixel_x[7:4])
	
		default: char_add_D = 7'h44;
	endcase
	
	
//Para poner m

assign m_on = (pixel_y [9:6] == 4) && (pixel_x [9:5]== 9);// && (pixel_x [9:5]<=11);
assign row_add_M = pixel_y[4:1];
assign bit_add_M = pixel_x[9:1];
always @*
begin
	case (pixel_x[7:4])

		default: char_add_M = 7'h4d;
	endcase
end

	
//rgb multiplexing circuit
always @*
begin
	rgb_text = 3'b000;


	
	if (j_on)
	begin
		char_add = char_add_J;
		row_add = row_add_J;
		bit_add = bit_add_J;	
		if	(font_bit)
			rgb_text [2] = swt1;
			rgb_text [1] = swt2;
			rgb_text [0] = swt3;

	end
	
	
	else if (d_on)
	begin
		char_add = char_add_D;
		row_add = row_add_D;
		bit_add = bit_add_D;	
		if	(font_bit)
			rgb_text[2] = swt1;
			rgb_text [1] = swt2;
			rgb_text [0] = swt3;
	end
	
	else if (m_on)
	begin
		char_add = char_add_M;
		row_add = row_add_M;
		bit_add = bit_add_M;	
		if	(font_bit)
			rgb_text [2] = swt1;
			rgb_text [1] = swt2;
			rgb_text [0] = swt3;
	end
	else
	rgb_text = 3'b0;
	
end	

assign text_on = {j_on, d_on, m_on};
assign rom_add = {char_add, row_add};
assign font_bit = font_word[~bit_add];	 
//assign rgb_text = {rgb_text_m, rgb_text_d, rgb_text_j};

endmodule
