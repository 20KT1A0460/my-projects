module sisotb ();
reg clk,reset,d;
wire out;
siso dut (clk,reset,d,out);
always #5 clk=~clk ;
initial begin
clk=0;
reset=0;
#10;
reset=1;
 d=1;#10;
 d=0;#10;
 d=1;#10;
 d=0;
end
endmodule

