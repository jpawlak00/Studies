`timescale 1ns / 1ps
module draw_rect_ctl(
    output reg [11:0] xpos,
    output reg [11:0] ypos,
    
    input wire mouse_left,
    input wire [11:0] mouse_xpos,
    input wire [11:0] mouse_ypos,
    input wire pclk,
    input wire rst
    );
    
   localparam RECT_HEIGHT = 64, SCREEN_HEIGHT = 600;
   
   reg [11:0] xpos_nxt, ypos_nxt;
   reg mouse_left_flag, mouse_left_flag_nxt;
   reg [11:0] xpos_fall, ypos_fall, xpos_fall_nxt, ypos_fall_nxt;
   reg [19:0] acc_counter, acc_counter_ref, acc_counter_nxt, acc_counter_ref_nxt;
   
   always@*
   begin
        if(mouse_left) 
        begin
            mouse_left_flag_nxt = 1;
            xpos_nxt = mouse_xpos;
            ypos_nxt = mouse_ypos;
            xpos_fall_nxt =  mouse_xpos; 
            ypos_fall_nxt = mouse_ypos;
            acc_counter_nxt = 0;
            acc_counter_ref_nxt = 500000; 
        end
        
        else if(mouse_left_flag && !mouse_left)
        begin
            mouse_left_flag_nxt = 1;
            
            if((acc_counter_ref - acc_counter) != 0)
            begin
                acc_counter_nxt = acc_counter + 1;
                acc_counter_ref_nxt = acc_counter_ref;
                ypos_fall_nxt = ypos_fall;
            end
            else
            begin
                ypos_fall_nxt = ypos_fall + 1;
                acc_counter_ref_nxt = acc_counter_ref - 810; 
                acc_counter_nxt = 0; 
            end

            if(ypos_fall >= SCREEN_HEIGHT - RECT_HEIGHT) ypos_nxt = SCREEN_HEIGHT - RECT_HEIGHT;
            else ypos_nxt = ypos_fall;
            
            xpos_fall_nxt = xpos_fall;
            xpos_nxt = xpos_fall;                 
        end
        
        else
        begin
            mouse_left_flag_nxt = 0;
            xpos_nxt = mouse_xpos;
            ypos_nxt = mouse_ypos;
            ypos_fall_nxt = mouse_ypos;
            xpos_fall_nxt = mouse_xpos;
            acc_counter_ref_nxt = 500000;
            acc_counter_nxt = 0;
        end
   end
   
   always@(posedge pclk)
   begin
        if(rst)
        begin
            xpos <= 0;
            ypos <= 0;
            ypos_fall <= 0;
            acc_counter <= 0;
            acc_counter_ref <= 500000;
            mouse_left_flag <= 0;
        end
      
        else
        begin
            xpos <= xpos_nxt;
            ypos <= ypos_nxt;
            ypos_fall <= ypos_fall_nxt;
            xpos_fall <= xpos_fall_nxt;
            acc_counter <= acc_counter_nxt;
            acc_counter_ref <= acc_counter_ref_nxt;
            mouse_left_flag <= mouse_left_flag_nxt;
        end
   end   
endmodule
