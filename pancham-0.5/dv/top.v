/*****************************************************************
 Pancham is an MD5 compliant IP core for cryptographic applicati
 -ons. 
 Copyright (C) 2003  Swapnajit Mittra, Project VeriPage
 (Contact email: verilog_tutorial at hotmail.com
  Website      : http://www.angelfire.com/ca/verilog)

 This library is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2.1 of the License, or (at your option) any later version.
 
 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public
 License along with this library; if not, write to the 
 
 Free Software Foundation, Inc.
 59 Temple Place, Suite 330
 Boston, MA  02111-1307 
 USA
 ******************************************************************/
/* 
 * This is the top level module for verification of pancham 
 *
 */
module top;

reg          clk;
reg          rst;
reg  [0:127] m_in;
//reg  [0:127] m_in1;
reg    [0:7] m_in_w;
reg          m_in_val;

wire [0:127] m_out;
wire         m_out_val;
wire         ready;

wire [0:127] m_out1;
wire         m_out_val1;
wire         ready1;
//------------------------------
//
// Design Under Test 
//
//------------------------------
pancham MD5(
        .clk           (clk      )
      , .reset	       (rst      )
      , .msg_in        (m_in     )
      , .msg_in_width  (m_in_w   )
      , .msg_in_valid  (m_in_val )
                        
      , .msg_output    (m_out    )
      , .msg_out_valid (m_out_val)
      , .ready         (ready    )
      );
      
pancham MD51(
              .clk           (clk      )
            , .reset           (rst      )
            , .msg_in        (m_in     )
            , .msg_in_width  (m_in_w   )
            , .msg_in_valid  (m_in_val )
                              
            , .msg_output    (m_out1    )
            , .msg_out_valid (m_out_val1)
            , .ready         (ready1    )
            );

// Clock
initial 
   clk = 1'b0;

always 
   #5 clk = ~clk;

// Reset
initial begin // {
   rst = 1'b1;
   #12;
   rst = 1'b0;
end // }

// Message input vector
initial begin // {
   m_in_val = 1'b0;

   // Wait till the chip comes out of reset and ready 
   wait (!rst & ready);
   #10 $display ("-------- MD5 TEST 0 --------");
   m_in     = ""; /* Empty string */
   m_in_w   = 8'h0;
   m_in_val = 1'b1;
   #10;
   m_in_val = 1'b0;
   // Wait for the result to come out; then compare
   wait(m_out_val);
   if (m_out == 128'hd41d8cd98f00b204e9800998ecf8427e) 
      $display (" MD5 TEST 0: PASSED");
   else 
      $display (" MD5 TEST 0: FAILED");


   // Wait till the chip becomes ready
   wait (ready);
   #10 $display ("-------- MD5 TEST 1 --------");
   m_in     = "a";
   m_in_w   = 8'h8;
   m_in_val = 1'b1;
   #10;
   m_in_val = 1'b0;
   // Wait for the result to come out; then compare
   wait(m_out_val);
   if (m_out == 128'h0cc175b9c0f1b6a831c399e269772661) 
      $display (" MD5 TEST 1: PASSED");
   else 
      $display (" MD5 TEST 1: FAILED");

   // Wait till the chip becomes ready
   wait (ready);
   #10 $display ("-------- MD5 TEST 2 --------");
   m_in     = "cba";  // "abc" reversed
   m_in_w   = 8'h18;
   m_in_val = 1'b1;
   #10;
   m_in_val = 1'b0;
   // Wait for the result to come out; then compare
   wait(m_out_val);
   if (m_out == 128'h900150983cd24fb0d6963f7d28e17f72) 
      $display (" MD5 TEST 2: PASSED");
   else 
      $display (" MD5 TEST 2: FAILED");

   // Wait till the chip becomes ready
   wait (ready);
   #10 $display ("-------- MD5 TEST 3 --------");
   m_in     = "tsegid egassem"; // "message digest" reversed
   m_in_w   = 8'h70;
   m_in_val = 1'b1;
   #10;
   m_in_val = 1'b0;
   // Wait for the result to come out; then compare
   wait(m_out_val);
   if (m_out == 128'hf96b697d7cb7938d525a2f31aaf161d0) 
      $display (" MD5 TEST 3: PASSED");
   else 
      $display (" MD5 TEST 3: FAILED");

   /* The following original MD5 tests can not be run on this 
      chip as their input message width is greater than 128 bits.

   // Wait till the chip becomes ready
   wait (ready);
   #10 $display ("-------- MD5 TEST 4 --------");
   m_in     = "abcdefghijklmnopqrstuvwxyz";
   m_in_w   = 8'hd0;
   m_in_val = 1'b1;
   #10;
   m_in_val = 1'b0;
   // Wait for the result to come out; then compare
   wait(m_out_val);
   if (m_out == 128'hc3fcd3d76192e4007dfb496cca67e13b) 
      $display (" MD5 TEST 4: PASSED");
   else 
      $display (" MD5 TEST 4: FAILED");

   // Wait till the chip becomes ready
   wait (ready);
   #10 $display ("-------- MD5 TEST 5 --------");
   m_in     = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
   m_in_w   = 8'h1f;
   m_in_val = 1'b1;
   #10;
   m_in_val = 1'b0;
   // Wait for the result to come out; then compare
   wait(m_out_val);
   if (m_out == 128'hd174ab98d277d9f5a5611c2c9f419d9f) 
      $display (" MD5 TEST 5: PASSED");
   else 
      $display (" MD5 TEST 5: FAILED");

   // Wait till the chip becomes ready
   wait (ready);
   #10 $display ("-------- MD5 TEST 6 --------");
   m_in     = "1234567890123456789012345678901234567890 1234567890123456789012345678901234567890";
   m_in_w   = 8'h29;
   m_in_val = 1'b1;
   #10;
   m_in_val = 1'b0;
   // Wait for the result to come out; then compare
   wait(m_out_val);
   if (m_out == 128'hb2eb6f504653aab4f5cef4b7adaee6c1) 
      $display (" MD5 TEST 6: PASSED");
   else 
      $display (" MD5 TEST 6: FAILED");
   */

   // Wait for a while before finishing
   #100;
   $finish;
end //}

// 
initial begin // {
//   $dumpvars;
//   $monitor($time, ": State = %s, Phase = %b", MD5.ascii_state, MD5.phase);
//   $monitor($time, ": abcd = %h_%h_%h_%h, m = %h", MD5.A, MD5.B, MD5.C, MD5.D, MD5.m);
// $monitor($time, 
//          ": m_in = %h, m_in_w = %h, m_in_val = %h, m_out = %h, m_out_val = %h, ready = %b", 
//   m_in, 
//   m_in_w, 
//   m_in_val, 
//   m_out,
//   m_out_val,
//   ready);
end // }
endmodule
