module ringc (input clk,pr,clr,output q1,q2,q3, q4);

dffnpr rt (clk,pr,q4,q1);
dffns rt1 (clk,clr,q1,q2);
dffns rt2 (clk,clr,q2,q3);
dffns rt3 (clk,clr,q3,q4);
endmodule

