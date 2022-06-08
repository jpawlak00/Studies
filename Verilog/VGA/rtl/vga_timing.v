// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_timing (
  output reg [10:0] vcount,
  output reg vsync,
  output reg vblnk,
  output reg [10:0] hcount,
  output reg hsync,
  output reg hblnk,
  input wire pclk,
  input wire rst    //change
  );
  
localparam HOR_TOT_PIX = 1056; 
localparam VER_TOT_PIX = 628;

localparam HOR_BLANK_START = 800, HOR_BLANK_TIME = 256;
localparam HOR_SYNC_START = 840, HOR_SYNC_TIME = 128;
localparam VER_BLANK_START = 600, VER_BLANK_TIME = 28;
localparam VER_SYNC_START = 601, VER_SYNC_TIME = 4;

reg [10:0] hcount_nxt, vcount_nxt;
reg hsync_nxt, vsync_nxt, vblnk_nxt, hblnk_nxt;

/*initial begin
vcount = 0;
hcount = 0;
vsync = 0;
hsync = 0;
end*/

always @* begin

	if (hcount < HOR_TOT_PIX - 1) begin
		hcount_nxt = hcount + 1;
		vcount_nxt = vcount;
		end
	else begin
		hcount_nxt = 0;
		if (vcount < VER_TOT_PIX - 1)
			vcount_nxt = vcount + 1;
		else	
			vcount_nxt = 0;
		end

	if (hcount >= (HOR_SYNC_START - 1) && hcount < (HOR_SYNC_START - 1 + HOR_SYNC_TIME -1)) 
		hsync_nxt = 1;
	else 
		hsync_nxt = 0;
		
	if (hcount >= (HOR_BLANK_START - 1) && hcount < HOR_TOT_PIX - 1)  
		hblnk_nxt = 1;
	else 
		hblnk_nxt = 0;
	
	if (vcount >= (VER_SYNC_START - 1) && vcount < (VER_SYNC_START - 1 + VER_SYNC_TIME) && hcount == HOR_TOT_PIX - 1) 
		vsync_nxt = 1;
	else if (vcount == ((VER_SYNC_START - 1) + VER_SYNC_TIME) && hcount == HOR_TOT_PIX - 1 )
    vsync_nxt = 0;
  else 
    vsync_nxt = vsync;
		
	if (vcount >= (VER_BLANK_START - 1) && vcount < (VER_TOT_PIX - 1) && hcount == HOR_TOT_PIX - 1) 
		vblnk_nxt = 1;
	else if (vcount == (VER_BLANK_START - 1 + VER_BLANK_TIME) && hcount == HOR_TOT_PIX - 1 )
	   vblnk_nxt = 0;
	else 
		vblnk_nxt = vblnk;
	
end

always @(posedge pclk) begin

	if(rst) begin      //change
		hcount <= 0;
		vcount <= 0;
		hsync <= 0;
		vsync <= 0;
		hblnk <= 0;
		vblnk <= 0;
	end 

	else begin
		hcount <= hcount_nxt;
		vcount <= vcount_nxt;
		hsync <= hsync_nxt;
		vsync <= vsync_nxt;
		hblnk <= hblnk_nxt;
		vblnk <= vblnk_nxt;
	end

end

  // Describe the actual circuit for the assignment.
  // Video timing controller set for 800x600@60fps
  // using a 40 MHz pixel clock per VESA spec.

endmodule
