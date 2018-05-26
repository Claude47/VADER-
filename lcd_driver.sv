`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.05.2018 16:11:59
// Design Name: 
// Module Name: LCD
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

module lcd_driver(
    //Inputs
    input clk,
    input reg [7:0] characters [0:7],   //characters from buffer
    
    //Outputs 
    output reg lcd_rs,            //data or command control
    output reg lcd_rw,            //read & write control
    output reg lcd_e,             //enable control
    output reg [7:0] data         //data line
        
);

    //reg [7:0] characters [0:7] = {8'h62,8'h62,8'h62,8'h62,8'h69,8'h74,8'h63,8'h68};    
    reg [23:0] count = 0;  //time counter
    reg [7:0] commands[0:12] = {8'h38,8'h0c,8'h06,8'h01,8'hC0,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20};
    reg [7:0] cmd_concat_msg [0:20] = {commands,characters}; //hold concatenated command and message
    reg [4:0] msg_index = 0; //index
    
    always @(posedge clk) begin
        lcd_rw <= 0;
        // Concatenate the message to commands                 
        if(count<=1000000) begin
            count<=count+1;
            lcd_e <= 1; //high
            data <= cmd_concat_msg[msg_index];
        end       
        else if (count>1000000 && count<2000000) begin
            count<=count+1;
            lcd_e <= 0; //low
        end            
        else if (count==2000000) begin
            msg_index<=msg_index+1;
            count<=0; 
        end  
               
        // Control Command and Data
        if(msg_index<=4) begin //command signals
            lcd_rs<=0;
        end
        else if (msg_index>4) begin //data signals
            lcd_rs<=1;
        end        
        //
        if(msg_index==21) begin //refresh data
            msg_index<=4; //set to start of data  
        end         
    end        
   
endmodule

    
