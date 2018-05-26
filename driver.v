`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.05.2018 23:01:10
// Design Name: 
// Module Name: driver
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


module driver(
    input Clk_100M,
    input reset,
//    input reg[127:0] known_hash,
//    input [0:127]   password,
//    input [0:7]     password_len,
//    input           hash_start,
    
//    output wire [0:127]    hash,
//    output wire            hash_out_val,
//    output wire            ready

    
//    output reg [127:0] password,
//    output match,
//    output exhausted
    output match
);

reg [127:0] known_hash = 128'h0571749e2ac330a7455809c6b0e7af90;
reg [127:0] recovered_password;
//reg match;
wire exhausted;

dictionary_attack dict (
    Clk_100M,
    reset,
    known_hash,
    match,
    exhausted,
    recovered_password
);

bruteforcer brute1 (
    .clk(Clk_100M),
    .reset(reset),
    .known_hash(known_hash),
    
    .match(match),
    .exhausted(exhausted),
    .recovered_password(recovered_password)
);
    
    
//    pancham MD5_1(
//         .clk(Clk_100M),
//         .reset(reset),
//         .msg_in(password),
//         .msg_in_width(password_len),
//         .msg_in_valid(hash_start),
//         .msg_output(hash),
//         .msg_out_valid(hash_out_val),
//         .ready(ready)
//    );

endmodule
