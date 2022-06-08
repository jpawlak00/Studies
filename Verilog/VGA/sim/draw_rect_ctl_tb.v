`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
/*TESTBENCH FOR DRAW_RECT_CTL*/
//////////////////////////////////////////////////////////////////////////////////


module draw_rect_ctl_tb(
    output reg mouse_left,
    output reg [11:0] mouse_xpos,
    output reg [11:0] mouse_ypos,
    
    input wire clk,        //????
    input wire rst
    );
    
    reg [11:0] mouse_xpos_nxt, mouse_ypos_nxt;
    
  /********************
  GENERACJA MYSZKI I CLICKA
  
  
  PAMIETAC O MOUSECTL -> REG 40MGHZ-> RESZTA
  
  ********************/
  
  initial begin
  mouse_xpos_nxt <= 0;
  mouse_ypos_nxt <= 0;
  mouse_left <= 0;
  #1000
  mouse_xpos_nxt <= 10;
  mouse_ypos_nxt <= 10;
  #1000
  mouse_left <= 1;
  #100
  mouse_left <= 0;
  
  end
  
  
	
    always@(posedge clk)
    begin
        if(rst)
        begin
           mouse_xpos <= 0;
           mouse_ypos <= 0;
        end
        else
        begin
            mouse_xpos <= mouse_xpos_nxt;
            mouse_ypos <= mouse_ypos_nxt;
        end
    
    end
    
    
    
    
    
    
    
endmodule
