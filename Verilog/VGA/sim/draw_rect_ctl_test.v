`timescale 1ns / 1ps
module draw_rect_ctl_test;

reg rst, clk;

//clk 40MHz
 
always
begin
	clk = 1'b0;
	#12.5;
	clk = 1'b1;
	#12.5;
end

initial begin
	rst <= 0;
	#100 rst <= 1;
	#100 rst <= 0;
end

wire [11:0] mousexpos, mouseypos;
wire mouseleft;

draw_rect_ctl_tb my_draw_rect_ctl_tb(
.rst(rst),
.clk(clk),
.mouse_xpos(mousexpos),
.mouse_ypos(mouseypos),
.mouse_left(mouseleft)
);

wire [11:0] xpos, ypos;

draw_rect_ctl my_draw_rect_ctl(
.rst(rst),
.pclk(clk),
.mouse_xpos(mousexpos),
.mouse_ypos(mouseypos),
.mouse_left(mouseleft),

//out
.xpos(xpos),
.ypos(ypos)
);    
endmodule
