`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.05.2018 13:00:18
// Design Name: 
// Module Name: alphabet
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

module character_set(
    input clk, //clock
    input next_perm, //load buffer signal
    input reg [7:0] address [7:0],  //input address number
    
    output reg [127:0] out_chars   //send character bit stream to hash
    );
    
    //Counter
    reg [23:0] count = 0;  //time counter
    reg [63:0] padding = 0;
   
    //SYNTAX: reg [8*number_of_characters:1] string_variable;
    reg [7:0] characters[0:61] = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","1","2","3","4","5","6","7","8","9","0"};
    
    always@(posedge next_perm) begin
        out_chars <= {padding,characters[address[7]],characters[address[6]],characters[address[5]],characters[address[4]],characters[address[3]],characters[address[2]],characters[address[1]],characters[address[0]]};
    end
    
    
    

endmodule
