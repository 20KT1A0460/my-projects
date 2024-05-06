module siso (input clk,reset,d,output   out);
wire q1,q2,q3;
dffps  rt (clk,reset,d,q1);
dffps ry (clk,reset,q1,q2);
dffps ey(clk,reset,q2,q3);
dffps et (clk,reset,q3,out);
endmodule
