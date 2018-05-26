`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2018 20:18:06
// Design Name: 
// Module Name: permutation_counter
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


module permutation_counter#(
    parameter max=61
)
(
    input clk,
    input next_perm,
    output reg [7:0] address[7:0], //stores address of
    output reg exhausted
    //output reg load_buff  //tells character_set of new permutation
);
    reg [7:0] c7 = 0;
    reg [7:0] c6 = 0;
    reg [7:0] c5 = 0;
    reg [7:0] c4 = 0;
    reg [7:0] c3 = 0;
    reg [7:0] c2 = 0;
    reg [7:0] c1 = 0;
    reg [7:0] c0 = 0;
    
//    reg is_exhausted;
    
    always @(posedge next_perm) begin
        c0 <= c0+1;
        if(c0==max) begin
            c0<=0;
            c1<=c1+1;
            if(c1==max) begin
                c1<=0;
                c2<=c2+1;
                if(c2==max) begin
                    c2<=0;
                    c3<=c3+1;
                    if(c3==max) begin
                        c3<=0;
                        c4<=c4+1;
                        if(c4==max) begin
                            c4<=0;
                            c5<=c5+1;
                            if(c5==max) begin
                                c5<=0;
                                c6<=c6+1;
                                if(c6==max) begin
                                    c6<=0;
                                    c7<=c7+1;
                                    if(c7==max) begin
//                                        is_exhausted <= 1;
                                        exhausted <= 1;
                                    end
                                end
                            end
                        end    
                    end                   
                end
            end
        end 
    // write out address
    address <= {c7,c6,c5,c4,c3,c2,c1,c0};    
    end
    
//assign exhausted = is_exhausted;
    
    
endmodule
