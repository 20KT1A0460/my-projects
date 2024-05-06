module biod (input clk,reset,r,in1,in2,output out1,out2);
wire q1,q2,q3,q4,d1,d2,d3,d4,l;
not (l,r);
inc rt (in1,r,q2,l,d1);
dffps ty (clk,reset,d1,q1);
inc yu (q1,r,q3,l,d2);
dffps ui (clk,reset,d2,q2);
inc df (q2,r,q4,l,d3);
dffps gh (clk,reset,d3,q3);
inc jk (q3,r,l,in2,d4);
dffps cv (clk,reset,d4,q4);

and (out1,r,q4);
and(out2,l,q1);

endmodule

