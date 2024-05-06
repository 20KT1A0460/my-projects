module fifo #(parameter depth=8)(input clk,reset,wr,rd,[depth-1:0] datain ,output emp,full,reg [depth-1:0] dataout);
reg [7:0] wrp,rdp;
integer count;
reg [depth-1:0]fifomem[depth-1:0];
assign full=(count==8);
assign emp=(count==0);
always @(posedge clk) begin
    if (reset) begin
         dataout=0;
         count=0;
         wrp=0;
         rdp=0;
      end
     else begin
       if (wr&&!rd) begin
	       if(wrp<8) begin
                       fifomem[wrp]=datain;
		       wrp=wrp+1;
                       count=count+1;
	        end
                 
       end
      else if (!wr&&rd) begin
	      if(rdp<8) begin
                        dataout=fifomem[rdp];
			rdp=rdp+1;
                        count=count-1;  
		end	
       end
      else if (wr&&rd) begin
                 fifomem[0]=datain;
                 dataout=fifomem[0];
       end
     end
end
endmodule


module fifotb();
parameter depth =8;
reg clk,reset,wr,rd;
reg [depth-1:0] datain ;
wire emp,full;
wire [depth-1:0] dataout;
integer i;
fifo dut ( clk,reset,wr,rd,datain,emp,full,dataout);
always #5 clk=~clk;
initial begin
clk=0;
reset=1;
#10;
reset=0;
end
initial begin
#10;
write();
#100;
read();
#100;
writeread();
end
task write;
	begin
   wr=1;rd=0; 
   for(i=0;i<depth;i=i+1) begin
          datain=$urandom_range(10,18);
	  #10;
  end
         end
endtask
task read;
 begin
wr=0;rd=1;
#10;
 end
endtask
task writeread;
	begin
wr=1;rd=1;
for(i=0;i<depth;i=i+1) begin
     datain=$urandom_range(20,28);
     #10;
     end
        end
endtask
initial begin
#2000 $finish;
end
endmodule





       
            
               
        

            

