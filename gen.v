module gen (input [3:0] a,b, input cin, output [3:0] so, output co);
genvar i;
wire [3:0] c1;
assign c1[0]=cin;
generate
	for(i=0;i<4;i=i+1) begin
		
        fulladd dut (.a(a[i]),.b(b[i]),.c(c1[i]),.sum(so[i]),.cout(c1[i+1]));
        end
	assign  co=c1[3];
endgenerate
endmodule

