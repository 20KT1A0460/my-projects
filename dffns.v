module dffns (input clk,reset,d,output reg q);
initial
q=0;
always@ (negedge clk)begin
if(reset)
 q=d;
else
q=0;
end
endmodule


