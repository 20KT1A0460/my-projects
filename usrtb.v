module usrtb ();
reg clk,reset,p1,p2,p3,p4,s0,s1;
wire q1,q2,q3,q4;
usr dut ( clk,reset,p1,p2,p3,p4,s0,s1, q1,q2,q3,q4);
always #5 clk=~clk;
initial begin
clk=0;
reset=0;
#10;
reset=1;
p1=1;
p2=1;
p3=1;
p4=0;
s0=1;
s1=1;
#10;
s0=0;
s1=0;
#40;
s0=0;
s1=1;
#50;
s0=1;
s1=0;

end
initial 
	#300 $finish;
endmodule


