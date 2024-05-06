module mux21 (input a,b,s,output reg y);
always @(*) begin
if(s)
y=b;
else
y=a;
end
endmodule
