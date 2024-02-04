`timescale 1ns / 1ps

module fsm(
    input wire       clk,
    input wire       rst,
    input wire       coin_in,
    input wire       cancel,
    // selection: 2'b00: no selection, 2'b01: water, 2'b10: coke, 2'b11: coffee;
    input wire [1:0] selection,
    // drink_out: 2'b00: none, 2'b01: dispense water, 2'b10: dispense coke, 2'b11: dispense coffee;
    output reg [1:0] drink_out,
    output reg [1:0] refund,
    output reg [1:0] cur_state
    );
    initial begin
    cur_state <= 2'b00;
    {drink_out, refund} <= 4'b0000;
    end
    
    always @(posedge clk) begin
        if (rst) begin
        {drink_out, refund} <= 4'b0000;
        cur_state <= 2'b00;
        end
        case(cur_state)
            2'b00: begin
            if (coin_in) begin
            cur_state <= 2'b01;
            end else begin
            cur_state <= 2'b00;
            {drink_out, refund} <= 4'b0000;
            
            
            end
            end
         
       
            
            2'b01: begin
            case({coin_in, selection, cancel})
                4'b0001: begin
                refund <= 2'b01;
                drink_out <= 2'b00;
                cur_state <= 2'b00;
                end
                4'b0010: begin
                cur_state <= 2'b00;
                drink_out <= 2'b01;
                refund <= 2'b00;
                end
                4'b1000: begin
                cur_state <= 2'b10;
                {drink_out, refund} <= 4'b0000;
                end
                default: begin
                {drink_out, refund} <= 4'b0000;
                cur_state <= 2'b01;
                end
                endcase
                end
            2'b10: begin
            case({coin_in, selection, cancel})
         
            4'b0010: begin
            {drink_out,refund} <= 4'b0101;
            cur_state <= 2'b00;
            end
            4'b0100: begin
            {drink_out,refund} <= 4'b1000;
            cur_state <= 2'b00;
            end
            4'b0001: begin
            {drink_out,refund} <= 4'b0010;
            cur_state <= 2'b00;
            end
            
            4'b1000: begin
            cur_state <= 2'b11;
            end
            default: begin
                {drink_out, refund} <= 4'b0000;
                cur_state <= 2'b10;
                end
            
            endcase
            end
            
            
            2'b11: begin
            case({coin_in, selection, cancel})
            4'b0110: begin
            {drink_out,refund} <= 4'b1100;
            cur_state <= 2'b00;
            end
            
            4'b0100: begin
            {drink_out,refund} <= 4'b1001;
            cur_state <= 2'b00;
            end
            4'b0010: begin
            {drink_out,refund} <= 4'b0110;
            cur_state <= 2'b00;
            end
            4'b0001: begin
            cur_state <= 2'b00;
            {drink_out,refund} <= 4'b0011;
            end
            
            default: begin
                {drink_out, refund} <= 4'b0000;
                cur_state <= 2'b11;
                end
            
            
            
            endcase
            end
    
    
    
    
    
    endcase
   
    
    end

endmodule
