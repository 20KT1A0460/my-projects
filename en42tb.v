module en42tb ();
reg a,b,c,d;
wire o1,o2;
en42 rt (a,b,c,d,o1,o2);
initial begin
a=1;b=0;c=0;d=0;#10;
a=0;b=1;c=0;d=0;#10;
a=0;b=0;c=1;d=0;#10;
a=0;b=0;c=0;d=1;
end
initial
$monitor(o1,o2);
endmodule
