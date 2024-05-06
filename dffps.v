module dffps (input clk,reset,d,output reg q ,output qbr);
initial 
q=0;
always@ (posedge clk)begin
if(reset)
q<=d;
else
q<=0;
end
assign qbr=~q;
endmodule



