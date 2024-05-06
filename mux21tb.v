module mux21tb;
reg a,b,s;
wire y;
mux21 rt(a,b,s,y);
initial begin
s=1;a=1;b=0;#10;
s=0;a=1;b=0;
end
initial
	$monitor(a,b,s,y);
endmodule
