
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.05.2018 16:58:26
// Design Name: 
// Module Name: dictionary_attack
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


module dictionary_attack(
    input clk,
    input reset,
//    input strobe,
    input [127:0] known_hash,
    output match,
    output exhausted,
    output reg [127:0] recovered_password
);

`include "wordlist.vh"

/* Buffer code data*/
reg [15:0] index = 0;
reg [15:0] max = 6830;
reg [127:0] plain_password;
reg wordlist_exhausted = 0;
reg load_next_hash = 0;
reg found_match = 0;

/* Hash module data */
reg msg_in_valid = 0;
reg [7:0] msg_width = 64;  // fixed to 64 since we only deal with 8 character words
reg [127:0] hash_val1;
reg hash_ready1;
reg hash_mod_ready;

/* Buffer */
always @(load_next_hash) begin
    if(wordlist_exhausted == 0) begin
        // delay by clock cycle if msg_in_valid line was just brought high
        if(load_next_hash == 1) begin
            plain_password <= wordlist[index];
            index <= index + 1;
        end
    end
end

always @(load_next_hash) begin
    if(load_next_hash == 1)
        msg_in_valid <= 1;
    else
        msg_in_valid <= 0;
end

// MD5 expects reversed characters
wire [127:0] reversed_password = {8'd0, 8'd0, 8'd0, 8'd0,
                                  8'd0, 8'd0, 8'd0, 8'd0,
                                  plain_password[7:0], plain_password[15:8], plain_password[23:16], plain_password[31:24],
                                  plain_password[39:32], plain_password[47:40], plain_password[55:48], plain_password[63:56]};
always @(posedge clk) begin
    if(index == max)
        wordlist_exhausted <= 1;
end

/* Hashing modules defined here */
// NOTE bring reset high for 4 clock cycles and then msg_in_valid high for 1 cycle

pancham hash1(
    .clk(clk),
    .reset(reset),
    .msg_in(reversed_password),
    .msg_in_width(msg_width),
    .msg_in_valid(msg_in_valid),
    
    .msg_output(hash_val1),
    .msg_out_valid(hash_ready1),
    .ready(hash_mod_ready)
);

assign exhausted = wordlist_exhausted;

/* Cracker module defined here */

reg initial_run = 1;

reg [7:0] reset_counter = 0;
always @(posedge clk) begin
    if(reset_counter < 5)
        reset_counter <= reset_counter + 1;
end

always @(posedge clk) begin
    if(reset_counter >= 5) begin
        if(wordlist_exhausted == 0) begin
            // necessary to skip cycle so that this line can be toggled
            if(load_next_hash == 1)
                load_next_hash <= 0;
            if(hash_ready1 == 1) begin
                if(hash_val1 == known_hash) begin
                    found_match <= 1;
                    recovered_password <= plain_password;  //wordlist[index - 1];
                end
                else
                    load_next_hash <= 1;
            end
            if(initial_run == 1) begin
                initial_run <= 0;
                load_next_hash <= 1;
            end
        end
    end
end

assign match = found_match;


endmodule
