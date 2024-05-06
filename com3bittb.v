module com3bittb();
reg [3:0] a,b;
wire [3:0] e,g,l;
com3bit ty (.a(a),.b(b),.e(e),.g(g),.l(l));
initial begin
a=4'b1000;b=4'b1100;#10;
a=4'b1001;b=4'b1001;#10;
a=4'b0011;b=4'b0001;
end
initial
$monitor(e,g,l);
endmodule

