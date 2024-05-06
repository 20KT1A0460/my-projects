module melaylop (input clk,reset,x,output reg  y);
parameter s1=2'b00,s2=2'b01,s3=2'b10,s4=2'b11;
reg [1:0]  cs,ns;
always @(posedge clk) begin
if(reset)
   cs=s1;
else 
   cs=ns;
end
always@(cs,x) begin
case (cs)
       s1: begin
             if (x)
                 ns=s2;
              else 
                 ns=s1;
                 
                  
           end
        s2: begin
             if (x)
                 ns=s2;
              else 
                 ns=s3;
                 
           
           end
        s3: begin
		if (x) 
                 ns=s4;
	         
              else 
                 ns=s1; 
                 
           end
	 s4: begin
		if (x) 
                 ns=s2;
	         
              else 
                 ns=s3; 
                 
           end


   endcase
   y=(cs==s4)?1:0;
end
endmodule
 


module melayloptb();
reg clk,reset,x;
wire y;
melaylop rt (clk,reset,x,y);
always #5 clk=~clk;
initial begin
clk=0;
x=0;
reset=1;
#15 reset=0;x=1;
#10; x=0;
#10; x=1;
#10; x=0;
#10; x=1;
#10; x=0;
#10; x=1;
end
endmodule


      
