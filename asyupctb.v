module asyupctb ();
reg clk,reset;
wire q1,q2,q3,q4;
asyupc rt (clk,reset,q1,q2,q3,q4);
always #5 clk=~clk;
initial begin
clk=0;
reset=0;
#10;
reset=1;
end
initial 
#300 $finish;
endmodule
