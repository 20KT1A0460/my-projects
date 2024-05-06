module piso (input clk,reset,d1,d2,d3,d4,s,output q);
wire w1,w2,w3,w4,w5,w6,l;
not(l,s);
dffps rt (clk,reset,d1,w1);
inc er (l,d2,s,w1,w2);
dffps ey (clk,reset,w2,w3);
inc yu (l,d3,s,w3,w4);
dffps ty (clk,reset,w4,w5);
inc gh (l,d4,s,w5,w6);
dffps  go (clk,reset,w6,q);
endmodule
