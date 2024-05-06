module gentb ();
reg [3:0] a,b;
reg cin;
wire [3:0] so;
wire co;
gen ty (a,b,cin,so,co);
initial begin
     #10 
     a=4'b0011;  b=4'b1101; cin=0;
     #10;
     a=4'b1010;b=4'b1111; cin=0;

end
initial  begin
	$monitor(a,b,cin,so,co);
	#200 $finish;
        end
endmodule
