// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_example (

  inout wire ps2_clk,
  inout wire ps2_data,
   
  input wire clk,
  output wire vs,
  output wire hs,
  output wire [3:0] r,
  output wire [3:0] g,
  output wire[3:0] b,
  output wire pclk_mirror,
  input wire rst   
  );

  // Converts 100 MHz clk into 40 MHz pclk.
  // This uses a vendor specific primitive
  // called MMCME2, for frequency synthesis.

  wire clk_in;
  wire locked;
  wire clk_fb;
  wire clk_ss;
  wire clk_out;
  wire pclk;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg [7:0] safe_start = 0;
  
  /*
  
  IBUF clk_ibuf (.I(clk),.O(clk_in));
  
  MMCME2_BASE #(
    .CLKIN1_PERIOD(10.000),
    .CLKFBOUT_MULT_F(10.000),
    .CLKOUT0_DIVIDE_F(25.000))
  clk_in_mmcme2 (
    .CLKIN1(clk_in),
    .CLKOUT0(clk_out),
    .CLKOUT0B(),
    .CLKOUT1(),
    .CLKOUT1B(),
    .CLKOUT2(),
    .CLKOUT2B(),
    .CLKOUT3(),
    .CLKOUT3B(),
    .CLKOUT4(),
    .CLKOUT5(),
    .CLKOUT6(),
    .CLKFBOUT(clkfb),
    .CLKFBOUTB(),
    .CLKFBIN(clkfb),
    .LOCKED(locked),
    .PWRDWN(1'b0),
    .RST(1'b0)
  );

  BUFH clk_out_bufh (.I(clk_out),.O(clk_ss));
  always @(posedge clk_ss) safe_start<= {safe_start[6:0],locked};

  BUFGCE clk_out_bufgce (.I(clk_out),.CE(safe_start[7]),.O(pclk));
  
  */

  // Mirrors pclk on a pin for use by the testbench;
  // not functionally required for this design to work.
    
    wire clk100MHz;
    
  clk_wiz_0 my_clk_wiz_0(
    .clk100MHz(clk100MHz),
    .clk40MHz(pclk),
    // Status and control signals               
    .reset(rst), 
    .locked(locked),
   // Clock in ports
    .clk(clk)
  
  );  
  
  ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(pclk),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
  );
  
  //rst_delay
  wire rst_d;
  
  rst_delay my_rst_delay(
  .locked(locked),
  .rst_out(rst_d),
  .clk(pclk)
  );
  
  //mouse
  
  wire [11:0] mouse_ctl_xpos, mouse_ctl_ypos;
  wire mouse_left;
  
  MouseCtl MyMouseCtl(
  .clk(clk100MHz),
  .rst(rst_d),
  .ps2_clk(ps2_clk),
  .ps2_data(ps2_data),
  .xpos(mouse_ctl_xpos),
  .ypos(mouse_ctl_ypos),
  .left(mouse_left)
  );
  
  wire [11:0] draw_rect_ctl_xpos, draw_rect_ctl_ypos;
  
  draw_rect_ctl my_draw_rect_ctl(
  //inputs
  .mouse_left(mouse_left),
  .mouse_xpos(mouse_ctl_xpos),
  .mouse_ypos(mouse_ctl_ypos),
  .pclk(pclk),
  .rst(rst_d),
  //outputs
  .xpos(draw_rect_ctl_xpos),
  .ypos(draw_rect_ctl_ypos)
  );
  
  // Instantiate the vga_timing module, which is
  // the module you are designing for this lab.

  wire [10:0] vcount, hcount;
  wire vsync, hsync;
  wire vblnk, hblnk;

  vga_timing my_timing (
    .vcount(vcount),
    .vsync(vsync),
    .vblnk(vblnk),
    .hcount(hcount),
    .hsync(hsync),
    .hblnk(hblnk),
    .pclk(pclk),
    .rst(rst_d)     //change
  );
  
  wire [10:0] vcount_out_bg, hcount_out_bg;
  wire vsync_out_bg, vblnk_out_bg, hsync_out_bg, hblnk_out_bg;
  wire [11:0] rgb_out_bg;
  
  vga_draw_background my_draw_background(
  .vcount_out(vcount_out_bg),
  .vsync_out(vsync_out_bg),
  .vblnk_out(vblnk_out_bg),
  .hcount_out(hcount_out_bg),
  .hsync_out(hsync_out_bg),
  .hblnk_out(hblnk_out_bg),
  .rgb_out(rgb_out_bg),
  
  .vcount_in(vcount),
  .vsync_in(vsync),
  .vblnk_in(vblnk),
  .hcount_in(hcount),
  .hsync_in(hsync),
  .hblnk_in(hblnk),
  .pclk(pclk),
  .rst(rst_d)
  );
  
  wire [11:0] vcount_out_rect, hcount_out_rect;
  wire vsync_out_rect, vblnk_out_rect, hsync_out_rect, hblnk_out_rect;
  wire [11:0] rgb_out_rect;
  wire hs_out_rect, vs_out_rect;
  wire [11:0] pixel_addr, rgb_pixel;
  
   vga_draw_rect my_draw_rect(
  .vcount_out(vcount_out_rect),
  .vsync_out(vs_out_rect),
  .vblnk_out(vblnk_out_rect),
  .hcount_out(hcount_out_rect),
  .hsync_out(hs_out_rect),
  .hblnk_out(hblnk_out_rect),
  .rgb_out(rgb_out_rect),
  .pixel_addr(pixel_addr),
  
  .rgb_pixel(rgb_pixel),
  .mouse_x_pos(draw_rect_ctl_xpos),       //mouse
  .mouse_y_pos(draw_rect_ctl_ypos),
  .vcount_in(vcount_out_bg),
  .vsync_in(vsync_out_bg),
  .vblnk_in(vblnk_out_bg),
  .hcount_in(hcount_out_bg),
  .hsync_in(hsync_out_bg),
  .hblnk_in(hblnk_out_bg),
  .rgb_in(rgb_out_bg),
  .pclk(pclk),
  .rst(rst_d)
  );
   
    image_rom my_image_rom(
  .rgb(rgb_pixel),
  
  .address(pixel_addr),
  .clk(pclk)
  );
  //out
  wire [11:0] vcount_out_rect_char, hcount_out_rect_char;
  wire vsync_out_rect_char, vblnk_out_rect_char, hsync_out_rect_char, hblnk_out_rect_char;
  wire [11:0] rgb_out_rect_char;
  wire hs_out_rect_char, vs_out_rect_char;
  wire [3:0] char_line;
  wire [7:0] char_xy;
  //in
  wire [7:0] char_pixel;
  
  draw_rect_char my_draw_rect_char (
  .vcount_out(vcount_out_rect_char),
  .vsync_out(vs_out_rect_char),
  .vblnk_out(vblnk_out_rect_char),
  .hcount_out(hcount_out_rect_char),
  .hsync_out(hs_out_rect_char),
  .hblnk_out(hblnk_out_rect_char),
  .rgb_out(rgb_out_rect_char),
  .char_line(char_line),
  .char_xy(char_xy),
  
  .char_pixel(char_pixel),
  .vcount_in(vcount_out_rect),
  .vsync_in(vs_out_rect),
  .vblnk_in(vblnk_out_rect),
  .hcount_in(hcount_out_rect),
  .hsync_in(hs_out_rect),
  .hblnk_in(hblnk_out_rect),
  .rgb_in(rgb_out_rect),
  .pclk(pclk),
  .rst(rst_d)
  );
  
  wire [6:0] char_code;
  
  font_rom my_font_rom (
  //in
  .addr({char_code, char_line}),
  .clk(pclk),
  //out
  .char_line_pixels(char_pixel)
  );
  
  char_rom_16x16 my_char_rom_16x16 (
  //in
  .char_xy(char_xy),
  //out
  .char_code(char_code)
  );
  
   mouse_display_sync my_mouse_display_sync(
   .clk(pclk),
   .xpos_in(mouse_ctl_xpos),
   .ypos_in(mouse_ctl_ypos),
   .hcount_in(hcount_out_rect_char),
   .vcount_in(vcount_out_rect_char),
   .hblnk_in(hblnk_out_rect_char),
   .vblnk_in(vblnk_out_rect_char),
   .rgb_in(rgb_out_rect_char),
   .hs_in(hs_out_rect_char),
   .vs_in(vs_out_rect_char),
   .hs(hs),
   .vs(vs),
  
   .rst(rst_d), 
  
   .r_out(r),
   .g_out(g),
   .b_out(b)   
   );
endmodule
