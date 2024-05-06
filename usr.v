module usr (input clk,reset,p1,p2,p3,p4,s0,s1,output q1,q2,q3,q4);
wire d1,d2,d3,d4;
mux41 ty (q1,q4,q2,p1,s0,s1,d1);
dffps ey (clk,reset,d1,q1);
mux41  fg (q2,q1,q3,p2,s0,s1,d2);
dffps gh (clk,reset,d2,q2);
mux41  hj (q3,q2,q4,p3,s0,s1,d3);
dffps nm (clk,reset,d3,q3);
mux41 vb (q4,q3,q1,p4,s0,s1,d4);
dffps  cv (clk,reset,d4,q4);
endmodule
