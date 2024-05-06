module jnringc (input clk,clr,output q1,q2,q3,q4,q4br);

dffns rt (clk,clr,q4br,q1);
dffns rt1 (clk,clr,q1,q2);
dffns rt2 (clk,clr,q2,q3);
dffns rt3 (clk,clr,q3,q4);
not (q4br,q4);
endmodule


