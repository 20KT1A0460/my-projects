module mux4x1 (input [3:0]a,b,c,d,input s1,s2,output [3:0]y); //mux dut
assign y=s2?(s1?d:c):(s1?b:a);
endmodule

/********************************************************************************/
module dec24(input f,g,output y1,y2,y3,y4); //decoder dut
assign y1=~f&~g;
assign y2=f&~g;
assign y3=~f&g;
assign y4=f&g;
endmodule
