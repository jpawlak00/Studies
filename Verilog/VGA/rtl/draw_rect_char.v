`timescale 1ns / 1ps
module draw_rect_char (
  output reg [11:0] vcount_out,
  output reg vsync_out,
  output reg vblnk_out,
  output reg [11:0] hcount_out,
  output reg hsync_out,
  output reg hblnk_out,
  output reg [11:0] rgb_out,
  output reg [3:0] char_line,
  output reg [7:0] char_xy,
  
  input wire [7:0] char_pixel,
  input wire [11:0] vcount_in,
  input wire vsync_in,
  input wire vblnk_in,
  input wire [11:0] hcount_in,
  input wire hsync_in,
  input wire hblnk_in,
  input wire [11:0] rgb_in,
  input wire pclk,
  input wire rst
  );
  
localparam RECT_LENGTH = 128, RECT_HEIGHT = 256;   //16*8 X 16*16
localparam FONT_COLOUR = 12'hf_f_f;                //white
//internal
reg [11:0] rgb_nxt;
reg [15:0] xpos, ypos;
 
  always @*
  begin
    xpos = hcount_in % 8;
    ypos = vcount_in % 16;
    char_line = vcount_in[3:0];
    char_xy = {hcount_in[7:4], vcount_in[7:4]};
    if(hcount_in >= 0 && hcount_in <= RECT_LENGTH && vcount_in >= 0 && vcount_in <= RECT_HEIGHT && char_pixel[8 - hcount_in[2:0]])
    begin
        rgb_nxt = FONT_COLOUR;
   end
    else rgb_nxt = rgb_in;

  end
  

always @(posedge pclk) begin

if(rst)begin
    vcount_out <= 0;
    vsync_out <= 0;
    vblnk_out <= 0;
    hcount_out <= 0;
    hsync_out <= 0;
    hblnk_out <= 0;
    rgb_out <= 0;
end

else begin

    vcount_out <= vcount_in;
    vsync_out <= vsync_in;
    vblnk_out <= vblnk_in;
    hcount_out <= hcount_in;
    hsync_out <= hsync_in;
    hblnk_out <= hblnk_in;
    rgb_out <= rgb_nxt;

end
end
endmodule
