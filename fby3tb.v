module fby3tb ();
reg clk,reset;
wire q1,q2,q3,out;
 fby3 ty (clk,reset,q1,q2,q3,out);
always #5 clk=~clk;
initial begin
clk=0;reset=0;
#10;
reset=1;
end
initial
#300 $finish;
endmodule
