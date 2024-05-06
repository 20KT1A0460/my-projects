module jkf(input j,k,ck,output reg q);
initial  q=0;
always@(posedge ck)
begin
	case({j,k})
		2'b00:q=q;
		2'b01:q=0;
		2'b10:q=1;
		2'b11:q=~q;
		default:q=1'bx;
	endcase

end
endmodule
