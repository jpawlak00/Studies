// File: vga_draw_rect.v

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_draw_rect (
  output reg [11:0] vcount_out,
  output reg vsync_out,
  output reg vblnk_out,
  output reg [11:0] hcount_out,
  output reg hsync_out,
  output reg hblnk_out,
  output reg [11:0] rgb_out,
  output reg [11:0] pixel_addr,
  
  input wire [11:0] rgb_pixel,
  input wire [11:0] mouse_x_pos,
  input wire [11:0] mouse_y_pos,
  input wire [10:0] vcount_in,
  input wire vsync_in,
  input wire vblnk_in,
  input wire [10:0] hcount_in,
  input wire hsync_in,
  input wire hblnk_in,
  input wire [11:0] rgb_in,
  input wire pclk,
  input wire rst
  );
  
localparam RECT_LENGTH = 48, RECT_WIDTH = 64;
//localparam RECT_COLOUR = 12'hf_f_f;                 //white
//internal
reg [3:0] r;
reg [3:0] g;
reg [3:0] b;

reg [5:0] addrx, addry;

reg [11:0] rgb_d1, rgb_d2;
reg [12:0] hcount_d1, vcount_d1, hcount_d2, vcount_d2;
  
  // horizontal: 0 - 799 vertical: 0 - 599 // r/g/b/y lines on egdes!

  always @*
  begin
    // During blanking pass background
    if (vblnk_in || hblnk_in)
    {r,g,b} = 12'h000;
    else
    begin
      if(vcount_d2 >= mouse_y_pos && hcount_d2 >= mouse_x_pos && vcount_d2 < (mouse_y_pos + RECT_WIDTH) && hcount_d2 < (mouse_x_pos + RECT_LENGTH))
      begin
      //{r,g,b} = RECT_COLOUR;
        {r,g,b} = rgb_pixel;
        addrx = hcount_in - mouse_x_pos;
        addry = vcount_in - mouse_y_pos;
      end
      else begin
          addrx = hcount_in - mouse_x_pos;
          addry = vcount_in - mouse_y_pos;
          {r,g,b} = rgb_d2; 
      end   
    end
  end
  
always @(posedge pclk) begin
    hcount_d1 <= hcount_in;
    vcount_d1 <= vcount_in;
    rgb_d1 <= rgb_in;
end

always @(posedge pclk) begin
    hcount_d2 <= hcount_d1;
    vcount_d2 <= vcount_d1;
    rgb_d2 <= rgb_d1;
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
    // fs_shift5_model_o <=  fs_model_o;
    //vcount_out <= count_in;
    vcount_out <= vcount_d2;
    vsync_out <= vsync_in;
    vblnk_out <= vblnk_in;
    hcount_out <= hcount_d2;
    hsync_out <= hsync_in;
    hblnk_out <= hblnk_in;
    rgb_out <= {r,g,b};
    //rgb_out <= rgb_d1;
    pixel_addr <= {addry, addrx};
end

end

endmodule

