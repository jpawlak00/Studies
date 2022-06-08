`timescale 1ns / 1ps

module mouse_display_sync(
       input wire [11:0] xpos_in,
       input wire [11:0] ypos_in,
       input wire [11:0] hcount_in,
       input wire [11:0] vcount_in,
       input wire hblnk_in,
       input wire vblnk_in,
       input wire [11:0] rgb_in,
       
       //!!
       input wire hs_in,
       input wire vs_in,
       
       output reg hs,
       output reg vs,
       
       input wire clk,
       input wire rst,
       //!!
       
       output wire [3:0] r_out,
       output wire [3:0] g_out,
       output wire [3:0] b_out
    );
    
    
    MouseDisplay MyMouseDisplay(
       .pixel_clk(clk),
       .xpos(xpos_in),
       .ypos(ypos_in),
       .hcount(hcount_in),
       .vcount(vcount_in),
       .blank(hblnk_in || vblnk_in),
       .red_in(rgb_in [11:8]),
       .green_in(rgb_in [7:4]),
       .blue_in(rgb_in [3:0]),
       .red_out(r_out),
       .green_out(g_out),
       .blue_out(b_out)
       );
       
       always@(posedge clk)
       if(rst)begin
        hs <= 0; 
        vs <= 0;
       end
       else begin
        hs <= hs_in;
        vs <= vs_in;
       end
       
endmodule
