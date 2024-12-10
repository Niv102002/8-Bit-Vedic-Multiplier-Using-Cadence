`timescale 1ns / 1ps

module vedic8x8(a, b, clk, result);
    input  [7:0] a, b;
    input clk;
    output [15:0] result;
  reg [15:0] op = 16'b0;
  
  
    wire [7:0] t1, t2, t3, t6, t7;
    wire [9:0] t4, t5;

    vedic4x4 M1(a[3:0], b[3:0], clk, t1);
    vedic4x4 M2(a[7:4], b[3:0], clk, t2);
    vedic4x4 M3(a[3:0], b[7:4], clk, t3);

    adder10 A1({2'b00, t2}, {2'b00, t3}, clk, t4);
    adder10 A2(t4, {6'b000000, t1[7:4]}, clk, t5);

    vedic4x4 M4(a[7:4], b[7:4], clk, t6);
    adder8 A3(t6, {2'b00, t5[9:4]}, clk, t7);

  always @(posedge clk) begin
    op[3:0] <= t1[3:0];
    op[7:4] <= t5[3:0];
    op[15:8] <= t7;
    end
  assign result [15:0] = op [15:0];
endmodule

module vedic4x4(a, b, clk, result);
    input  [3:0] a, b;
    input clk;
    output [7:0] result;
  
  reg [7:0] op = 8'b0;
  
    wire [3:0] t1, t2, t3, t6, t7;
    wire [5:0] t4, t5;
  	

    vedic_2x2 V1(a[1:0], b[1:0], clk, t1);
    vedic_2x2 V2(a[3:2], b[1:0], clk, t2);
    vedic_2x2 V3(a[1:0], b[3:2], clk, t3);

  adder6 A1({2'b00, t3}, {2'b00, t2}, clk, t4);
  adder6 A2(t4, {4'b0000, t1[3:2]}, clk, t5);

    vedic_2x2 V4(a[3:2], b[3:2], clk, t6);
    adder4 A3(t6, t5[5:2], clk, t7);

  	always @(posedge clk) begin
      		op [1:0] <= t1[1:0];
        	op [3:2] <= t5[1:0];
        	op [7:4] <= t7;
    end
  assign result [7:0] = op [7:0];
endmodule

module vedic_2x2(a, b, clk, result);
    input [1:0] a, b;
    input clk;
    output [3:0] result;

  reg res;
  wire [3:0] w;
  //wire [3:0] resul;
  
  
	always @(posedge clk) begin
        res <= a[0] & b[0];
    end

	assign result[0] = res;
  	assign w[0] = a[1] & b[0];
   assign w[1] = a[0] & b[1];
  	assign w[2] = a[1] & b[1];
  halfAdder H0(w[0], w[1], clk, result[1], w[3]);
  halfAdder H1(w[2], w[3], clk, result[2], result[3]);
endmodule

module halfAdder(a, b, clk, sum, carry);
    input a, b, clk;
  	output reg sum;
  	output reg carry;

  
	always @(posedge clk) begin
        	sum <= a ^ b;
    		carry <= a & b;
    end
endmodule

module adder4(a, b, clk, sum);
    input [3:0] a, b;
    input clk;
    output reg [3:0] sum;
  
  	always @(posedge clk) begin
        	sum <= a + b;
    end
endmodule

module adder6(a, b, clk, sum);
    input [5:0] a, b;
    input clk;
    output reg [5:0] sum;

  	always @(posedge clk) begin
        	sum <= a + b;
    end
endmodule

module adder8(a, b, clk, sum);
    input [7:0] a, b;
    input clk;
    output reg [7:0] sum;
  
  	always @(posedge clk) begin
        	sum <= a + b;
    end
endmodule

module adder10(a, b, clk, sum);
    input [9:0] a, b;
    input clk;
    output reg [9:0] sum;
  
  always @(posedge clk) begin
        	sum <= a + b;
  end
endmodule
