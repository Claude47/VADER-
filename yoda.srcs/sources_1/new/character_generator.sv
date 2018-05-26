`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2018 21:06:11
// Design Name: 
// Module Name: character_generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module character_generator(
    input clk, //clock
    input start_gen, //generation
    
    output reg [127:0] characters_bitstream, //buffers character bitstream to be sent
    output reg exhausted
);


    reg [7:0] perm_address [7:0];

    permutation_counter permutation_counter1(
        //input
        .clk (clk),
        .next_perm (start_gen),      //feedback from character_set that characters written
        
        //output
        .address (perm_address),   //outputs address of characters in character_set
        .exhausted(exhausted)
    );

    character_set character_set1(
        //input
        .clk (clk),
        .next_perm (start_gen),         // input from counter that new permutation ready
        .address (perm_address),            // inputs address of characters in characterset
        
        //output
        .out_chars(characters_bitstream)
    );
    
endmodule
