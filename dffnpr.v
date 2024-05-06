module dffnpr  (input clk,pr,d,output reg q);
always @( negedge clk) begin
if (pr)
 q=d;
else
 q=1;
end
endmodule
