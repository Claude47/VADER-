`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.05.2018 23:30:35
// Design Name: 
// Module Name: vader
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


module vader(
    input Clk_100M,
    input [127:0] known_hash,
    input ready,
    
    
    output match_found   
//    output
);


reg [63:0] characters_bitstream;

wire start_gen = ready & ~match_found;

character_generator brute_force_gen(
    Clk_100M,
    characters_bitstream
//    .Clk_100M(Clk_100M),
//    .start_gen(ready),
//    .characters_bitstream(characters_bitstream),
);


endmodule
