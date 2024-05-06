module biodtb ();
reg clk,reset,r,in1,in2;
wire out1,out2;
biod dut (clk,reset,r,in1,in2,out1,out2);
 always #5 clk=~clk;
initial begin
clk=0;
reset=0;
#10;
reset=1;
r=1;
in1=1;#10;
in1=0;#10;
in1=1;#10;
in1=0;
#50;
reset=0;
#40;
reset=1;
r=0;
in2=1;#10;
in2=1;#10;
in2=1;#10;
in2=0;
end
initial
#300 $finish;
endmodule




 
  
