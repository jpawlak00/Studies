// File: vga_draw_background.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_draw_background (
  output reg [10:0] vcount_out,
  output reg vsync_out,
  output reg vblnk_out,
  output reg [10:0] hcount_out,
  output reg hsync_out,
  output reg hblnk_out,
  output reg [11:0] rgb_out,
  
  input wire [10:0] vcount_in,
  input wire vsync_in,
  input wire vblnk_in,
  input wire [10:0] hcount_in,
  input wire hsync_in,
  input wire hblnk_in,
  input wire pclk,
  input wire rst
  );
  
reg [3:0] r;
reg [3:0] g;
reg [3:0] b;
  
  always @*
  begin
    // During blanking, make it it black.
    if (vblnk_in || hblnk_in) {r,g,b} = 12'h0_0_0; 
    else
    begin
      // edit offset -1
      // Active display, top edge, make a yellow line.
      if (vcount_in == 0) {r,g,b} = 12'hf_f_0;
      // Active display, bottom edge, make a red line.
      else if (vcount_in == 599) {r,g,b} = 12'hf_0_0;
      // Active display, left edge, make a green line.
      else if (hcount_in == 0) {r,g,b} = 12'h0_f_0;       
      // Active display, right edge, make a blue line.
      else if (hcount_in == 799) {r,g,b} = 12'h0_0_f;
      // Active display, interior, fill with gray.
      else {r,g,b} = 12'h8_8_8;
    end
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
    rgb_out <= {r,g,b};
end

end

endmodule

      /*J
      else if (hcount_in >= 150 && hcount_in <= 350 && vcount_in >= 100 && vcount_in <= 120) 
        {r,g,b} = 12'hf_f_f; 
      else if (hcount_in >= 330 && hcount_in <= 350 && vcount_in >= 100 && vcount_in <= 500) 
        {r,g,b} = 12'hf_f_f;
      else if (hcount_in >= 150 && hcount_in <= 350 && vcount_in >= 480 && vcount_in <= 500) 
        {r,g,b} = 12'hf_f_f;
      else if (hcount_in >= 150 && hcount_in <= 170 && vcount_in >= 460 && vcount_in <= 500) 
        {r,g,b} = 12'hf_f_f;
        
      //P
      else if (hcount_in >= 450 && hcount_in <= 470 && vcount_in >= 100 && vcount_in <= 500) 
        {r,g,b} = 12'hf_f_f;   
      else if (hcount_in >= 450 && hcount_in <= 650 && vcount_in >= 100 && vcount_in <= 120) 
        {r,g,b} = 12'hf_f_f; 
      else if (hcount_in >= 450 && hcount_in <= 650 && vcount_in >= 300 && vcount_in <= 320) 
        {r,g,b} = 12'hf_f_f; 
      else if (hcount_in >= 630 && hcount_in <= 650 && vcount_in >= 100 && vcount_in <= 320) 
        {r,g,b} = 12'hf_f_f; 
      else {r,g,b} = 12'h8_8_8;    */
