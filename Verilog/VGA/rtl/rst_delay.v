`timescale 1ns / 1ps

module rst_delay(
    output reg rst_out,
    input wire locked,
    input wire clk
    );
    
    reg [3:0] shift_reg;
    reg rst;
    
   // assign rst = !locked;
        
    always@*
    begin
        if(!locked) begin
            rst = 1;
        end
        else begin
            rst = 0;
        end
    end
    
    always@(posedge clk) rst_out <= shift_reg[3];
    
    always@(posedge clk or negedge locked) begin
    if (!locked) begin
        //rst_out <= 1;
        shift_reg[3] <= 1;
        shift_reg[2] <= 1;
        shift_reg[1] <= 1;
        shift_reg[0] <= 1;
    end
    else begin  
        shift_reg[3] <= shift_reg[2];
        shift_reg[2] <= shift_reg[1];
        shift_reg[1] <= shift_reg[0];
        shift_reg[0] <= 0;
        end
    end
    
        
endmodule
