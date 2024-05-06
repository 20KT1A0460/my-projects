module en42 (input a,b,c,d,output reg o1,o2);
always@(*) begin
if (a) begin 	 
o1=0;
o2=0;
end
else if (b)begin
o1=0;
o2=1;
end
else if(c)begin
o1=1;
o2=0;
end
else if(d)begin
o1=1;
o2=1;
end
else begin
o1=0;
o2=0;
end
end
endmodule


