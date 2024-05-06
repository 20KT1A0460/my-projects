    module asyfifo (wclk,rclk,wreset,rreset,we,re,datain,dataout,full,empty);
    parameter data=8;
    parameter adress=8;
    input wclk,rclk,wreset,rreset,we,re;
    input [data-1:0] datain;
    output reg  full,empty;
    output reg [data-1:0] dataout;
    reg [data-1:0]mem[adress-1:0];
    reg [adress-1:0] wpr,rpr,rs=0,ws=0,wb=0,rb=0,rg=0,wg=0;
    reg[3:0]count=0;
   integer i;

   task bingray;
      input [adress-1:0] bin;
      output reg [adress-1:0] gray;
     begin
      gray[adress-1]=bin[adress-1];
      for(i=adress-2;i>=0;i=i-1) begin
      gray[i]=gray[i+1]^bin[i];
      end
      end
   endtask


    task graybin;
      input [adress-1:0] gray;
      output reg [adress-1:0] bin;
     begin
      bin[adress-1]=gray[adress-1];
      for(i=adress-2;i>=0;i=i-1) begin
      bin[i]=gray[i+1]^gray[i];
      end
      end
   endtask


   task ff;
     input clk,reset;
     input [data-1:0] datain;
     output reg [data-1:0] dataout;
     reg [data-1:0] out;//internal ff
   begin
    if(reset) begin
	out<=0;
	dataout<=0;
    end
       else begin
       out=datain;
       dataout=out;
      end
       end
    endtask
initial
dataout<=0;
initial begin
rpr<=0;
wpr<=0;
full<=0;
empty<=1;
end
always@(posedge wclk) begin
	if (wreset) begin
		dataout<=0;
	        wpr<=0;
	end
        else begin
		if(we&&!re&&!full) begin
			if(wpr<=adress-1) begin
	        mem[wpr]<=datain;
		wpr<=wpr+1;
                 count=count+1;
	         end
	 end
            end

end
always@(posedge rclk) begin
if (rreset) begin
 rpr<=0;
       end
  else begin
       if(re&&!we&&!empty) begin
	      if(rpr<=adress-1) begin
	         dataout<=mem[rpr];
		 rpr<=rpr+1;
		count=count-1;
	         end
	 end

        end
end
always@(posedge rclk) begin
bingray(wpr,wg);
ff(rclk,rreset,wg,ws);
graybin(ws,wb);
if(!wreset)
empty=(wb==rpr);
end
always@(posedge wclk)begin
bingray(rpr,rg);
ff(rclk,wreset,rg,rs);
graybin(rs,rb);
if(!rreset) begin
    if (rb==0&& wpr==adress)
            full=1;
    else
	    full=0;
end
end
endmodule




module asyfifotb();
 parameter data=8;
 parameter adress=8;
reg wclk,rclk,wreset,rreset,we,re;
reg [data-1:0] datain;
wire full,empty;
wire [data-1:0] dataout;
asyfifo dut (wclk,rclk,wreset,rreset,we,re,datain,dataout,full,empty);
integer i=0;
always #5 wclk=~wclk;
always #10 rclk=~rclk;
initial begin
wclk=0;
rclk=0;
wreset=1;
rreset=1;
we=0;
re=0;
datain=0;
#10
wreset=0;
rreset=0;
@(posedge wclk);
for(i=0;i<=adress-1;i=i+1) begin
	we=1;
	re=0;
	datain=(10+i);
       @(posedge wclk);
       end
#200;    
@(posedge rclk);
for(i=0;i<=adress-1;i=i+1) begin
re=1;we=0;
@(posedge rclk);
end
end
initial 
#2000 $finish;
endmodule



     

      
