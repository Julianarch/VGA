`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:56:44 08/21/2016 
// Design Name: 
// Module Name:    VGAtext 
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
module VGAtext(
	input wire clk,
	input wire swt1, swt2, swt3, video_on,
	input wire [9:0] pixel_y, pixel_x,
	//output wire [9:0] pixel_x, pixel_y,
	//output wire [2:0] text_on,//letras o palabras
	//output wire font_bit,
	output reg [2:0] rgb_text,
	///
	output wire [7:0] font_word_wave,
	output wire font_bit_wave,
	output wire [3:0] row_add_wave,
	output wire [2:0] bit_add_wave,
	output wire [6:0] char_add_wave,
	output wire pixel_xlast,
	output wire pixel_ylast
    );
	 

//signal declaration

wire [10:0] rom_add;

reg [6:0] char_add;//carga la letra en hexa
//reg [6:0] char_add_J, char_add_D, char_add_M;

wire [3:0] row_add;
//wire [3:0] row_add_J, row_add_D, row_add_M;

wire [2:0] bit_add;
//wire [2:0] bit_add_J, bit_add_D, bit_add_M;

wire [7:0] font_word;
wire j_on, d_on, m_on, comodin;

font_rom font_unit
(.clk(clk), .addr(rom_add), .data(font_word));

assign row_add = pixel_y [4:1];
assign bit_add = pixel_x [3:1];
assign pixel_xlast = pixel_x[0];
assign pixel_ylast = pixel_y[0];
// Para poner comodin
assign comodin = (pixel_y [9:5] == 2) && (pixel_x [9:4] == 35 );
//Para poner J

assign j_on = (pixel_y [9:5] == 6) && (pixel_x [9:4] == 18 );
//assign j_on = (pixel_y [9:6] == 2) && (2 == pixel_x [9:5] );// && (pixel_x [9:5] <= 4));
//assign row_add_J = pixel_y [2:1]; 
//assign bit_add_J = pixel_x [2:1];

/*always @ *
	case (pixel_x[7:4])

		default: char_add_J = 7'h67;
		
	endcase*/

//Para poner D

assign d_on = (pixel_y [9:5] == 7) && (pixel_x [9:4] == 20);
//assign d_on = (pixel_y [9:6] == 3) && (5== pixel_x [9:5]); //&& (pixel_x [9:5]<=7);
//assign row_add_D = pixel_y[3:1];
//assign bit_add_D = pixel_x [5:1];

/*always @*
	case (pixel_x[7:4])
	
		default: char_add_D = 7'h82;
	endcase*/
	
	
//Para poner m

assign m_on = (pixel_y [9:5] == 8) && (pixel_x [9:4] == 22);
//assign m_on = (pixel_y [9:6] == 4) && (9== pixel_x [9:5]);// && (pixel_x [9:5]<=11);
//assign row_add_M = pixel_y[4:1];
//assign bit_add_M = pixel_x[9:1];
/*always @*
begin
	case (pixel_x[7:4])

		default: char_add_M = 7'h77;
	endcase
end*/

always @*
	begin
		if(j_on)
			char_add = 7'h4a;
		else if (d_on)
			char_add = 7'h44;
		else if (m_on)
			char_add = 7'h4d;
		else if (comodin)
			char_add = 7'h7a;
		else 
			char_add = 7'h00;
	end
		
assign rom_add = {char_add, row_add};
assign font_bit = font_word [~bit_add];

always @*
	begin
		if (video_on)
			begin
				if ((font_bit) && (~comodin))
					begin
						rgb_text[2] = swt1;
						rgb_text[1] = swt2;
						rgb_text[0] = swt3;
					end
				else
					rgb_text = 3'b111;
			end
		else
			rgb_text = 3'b000;
	end

//rgb multiplexing circuit
/*always @*
begin
	rgb_text = 3'b000;
	if (j_on)
	begin
		char_add = char_add_J;
		row_add = row_add_J;
		bit_add = bit_add_J;	
		if	(font_bit)
			rgb_text[2] = swt1;
			rgb_text[1] = swt2;
			rgb_text[0] = swt3;

	end
	
	
	else if (d_on)
	begin
		char_add = char_add_D;
		row_add = row_add_D;
		bit_add = bit_add_D;	
		if	(font_bit)
			rgb_text[2] = swt1;
			rgb_text[1] = swt2;
			rgb_text[0] = swt3;
	end
	
	else if (m_on)
	begin
		char_add = char_add_M;
		row_add = row_add_M;
		bit_add = bit_add_M;	
		if	(font_bit)
			rgb_text[2] = swt1;
			rgb_text[1] = swt2;
			rgb_text[0] = swt3;
	end
	else
		rgb_text = 3'b000;
	
end*/	

//assign text_on = {j_on, d_on, m_on};
//assign rom_add = {char_add, row_add};
//assign font_bit = font_word[~bit_add];	 

assign font_word_wave = font_word;
assign font_bit_wave = font_bit;
assign row_add_wave = row_add;
assign bit_add_wave = bit_add;
assign char_add_wave = char_add;

endmodule
