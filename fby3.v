module fby3 (input clk,reset,output q1,q2,q3,out);
wire d1;
and (d1,q1br,q2br);
dffps rt (clk,reset,d1,q1);
not(q1br,q1);
dffps rt1 (clk,reset,q1,q2);
not(q2br,q2);
dffns fg (clk,reset,q2,q3);
or(out,q2,q3);
endmodule
