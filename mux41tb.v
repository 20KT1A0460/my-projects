module mux41tb;
reg a,b,c,d,s1,s2;
wire y1;
mux41 rt( a,b,c,d,s1,s2,y1);
initial begin
s1=0;s2=0;a=1;b=1;c=0;d=1;#10;
s1=0;s2=1;a=1;b=1;c=0;d=1;#10;
s1=1;s2=0;a=1;b=1;c=0;d=1;#10;
s1=1;s2=1;a=1;b=1;c=0;d=1;
end
initial
	$monitor(a,b,c,d,s1,s2,y1);
endmodule
