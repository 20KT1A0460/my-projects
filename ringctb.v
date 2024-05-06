module ringctb ();
reg clk,pr,clr;
wire q1,q2,q3,q4;
ringc ty (clk,pr,clr,q1,q2,q3,q4);
always #5 clk=~clk;
initial begin
clk=0;
pr=0;
clr=0;
#10;
pr=1;
clr=1;
end
initial 
#300 $finish;
endmodule
