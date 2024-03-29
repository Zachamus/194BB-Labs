`timescale 1ns / 1ps

module fsm_tb();

    reg clk;
    reg rst;
    reg coin_in;
    reg cancel;
    reg [1:0] selection;
    wire [1:0] drink_out;
    wire [1:0] refund;
    wire [1:0] cur_state;
    
    // Instantiation of fsm module;
    fsm fsm_0 (
        .clk(clk),
        .rst(rst),
        .coin_in(coin_in),
        .cancel(cancel),
        .selection(selection),
        .drink_out(drink_out),
        .refund(refund),
        .cur_state(cur_state)
    );
    
    // Clock generation;
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Generate a clock with a period of 20ns;
    end

    initial begin
    
        // Test case 1: insert one coin and select 2'b01 (water);
        // Initialize inputs
        rst = 0;
        coin_in = 0;
        cancel = 0;
        selection = 2'b00;
        #200;
        
        // Reset the fsm;
        #5 rst = 1;
        #20 rst = 0; 

        // Test sequence;
        #20 coin_in = 1; // Simulate inserting a coin
        #20 coin_in = 0; 
        #30 selection = 2'b01; // Make a selection
        #20 selection = 2'b00; 
        
        // Wait for test case 1 to complete;
        #50;
        
        // Test case 2: insert one coin and select 2'b10 (coke), then cancel;
        // Test sequence;
        #30 coin_in = 1; // Simulate inserting a coin;
        #20 coin_in = 0;
        #30 selection = 2'b10; // Make a selection;
        #20 selection = 2'b00;
        #30 cancel = 1; // Cancel purchase;
        #20 cancel = 0;
        
        // Wait for test case 2 to complete;
        #50;
        
        // Test case 3: insert three coins once and select 2'b10 (coke);
        // Test sequence
        #30 coin_in = 1; // Simulate inserting a coin
        #20 coin_in = 0;
        #30 coin_in = 1; // Simulate inserting a coin
        #20 coin_in = 0;
        #30 coin_in = 1; // Simulate inserting a coin
        #20 coin_in = 0;
        #30 selection = 2'b10; // Make a selection
        #20 selection = 2'b00;
        
        #300;
        $finish;
    end

    
endmodule
