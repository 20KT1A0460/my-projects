module mux41 (input a,b,c,d,s1,s2,output  y1);
wire w1,w2;
mux21 ry (a,b,s1,w1);
mux21 eu (c,d,s1,w2);
mux21 er(w1,w2,s2,y1);
endmodule
