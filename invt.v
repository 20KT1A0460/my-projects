module invt(input[2:0] in1,in2,output out);
supply0 a;
supply1 b;
wire out1;
pmos(out1,b,in1);
pmos(out,out1,in2);
nmos(out,a,in2);
nmos(out,a,in1);
endmodule




module  invttb();
reg[2:0] in1,in2;
wire out;
invt dut (in1,in2,out);
initial begin
in1=3'b000;
in2=3'b001;
#10;
in1=3'b011;
in2=3'b110;
#10;
in1=3'b000;
in2=3'b110;
#10;
in1=3'b111;
in2=3'b011;
end
endmodule

