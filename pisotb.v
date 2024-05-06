module pisotb ();
reg clk,reset,d1,d2,d3,d4,s;
wire q;
piso fg (clk,reset,d1,d2,d3,d4,s,q);
always #5 clk=~clk;
initial begin
clk=0;
reset=0;
#10;
reset=1;
#10;
s=0;
d1=1;
d2=0;
d3=1;
d4=0;
#10;
s=1;
end
endmodule
