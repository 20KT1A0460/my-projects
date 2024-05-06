module asyupc (input clk,reset,output q1,q2,q3,q4);
wire q1br,q2br,q3br,q4br;
not (q1br,q1);
dffps rt1 (clk,reset,q1br,q1);
not(q2br,q2);
dffps rt2 (q1br,reset,q2br,q2);
not(q3br,q3);
dffps  rt3 (q2br,reset,q3br,q3);
not(q4br,q4);
dffps rt4 (q3br,reset,q4br,q4);
endmodule
