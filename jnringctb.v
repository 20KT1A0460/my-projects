module jnringctb ();
reg clk,clr;
wire q1,q2,q3,q4,q4br;
jnringc ty (clk,clr,q1,q2,q3,q4,q4br);
always #5 clk=~clk;
initial begin
clk=0;
clr=0;
#10;
clr=1;
end
initial 
#300 $finish;
endmodule

