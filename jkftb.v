module jkftb();
reg j,k,ck;
wire q;
jkf dut(j,k,ck,q);
always #5 ck=~ck;
initial begin
	ck=0;
	#10;
	j=0;k=0;#10;
	j=0;k=1;#10;
	j=1;k=0;#10;
	j=1;k=1;
end
initial
	#300 $finish;
endmodule


