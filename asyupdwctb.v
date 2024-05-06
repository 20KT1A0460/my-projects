module asyupdwctb ();
reg clk,reset,u;
wire q1,q2,q3,q4;
asyupdwc dut (clk,reset,u,q1,q2,q3,q4);
always #5 clk=~clk;
initial begin
clk=0;
reset=0;
#5;
reset=1;
u=1;
#180;
u=0;
end
initial 
#400  $finish;
endmodule

