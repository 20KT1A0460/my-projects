module asyupdwc (input clk,reset,u,output  q1,q2,q3,q4);
wire q1br,q2br,q3br,q4br,w1,w2,w3;
not(d,u);
dffps rt1 (clk,reset,q1br,q1);
not(q1br,q1);
inc du1 (d,q1,u,q1br,w1);
dffps rt2 (w1,reset,q2br,q2);
not(q2br,q2);
inc du2 (d,q2,u,q2br,w2);
dffps rt3 (w2,reset,q3br,q3);
not(q3br,q3);
inc du3 (d,q3,u,q3br,w3);
dffps rt4 (w3,reset,q4br,q4);
not(q4br,q4);
endmodule
 

