 module aximaster (aclk,reset, awvalid, wadd, radd, awadd, aradd, awready, wvalid,datain, wdata, wlast, wready, bvalid, bresp, bready, rdata,dataout, arvalid, aready, rvalid, rready, rlast);
input [31:0]  wadd, radd,datain, rdata;
input aclk,reset, awready, wready, bvalid, aready, rvalid, rlast;
input[1:0]  bresp;
output reg  awvalid, wvalid, wlast, bready, arvalid, rready;
output reg [31:0]  wdata, awadd, aradd,dataout;

reg [2:0] bsize=2;
reg [3:0] blen=7;
reg [1:0] btyp=1;
always @( posedge aclk) begin
if(!reset) begin
  awvalid<=0;
  wvalid<=0;
  wlast<=0;
  bready<=0;
  arvalid<=0;
  rready<=0;
  wdata<=0;
  awadd<=0;
  aradd<=0;
 dataout<=0;
end
else begin
    awvalid<=1;
    awadd<=wadd;
end	
if(awready)begin
	  if(awadd<=wadd+(blen)&&awadd>=wadd)begin
	    awadd<=awadd+1;
	    wvalid<=1;
	    wdata<=datain;
	      if(awadd==wadd+(blen))
		      wlast<=1;
            end
	    else
        	awadd<=0;
      if(wready)begin
        bready<=1;
	    if(bvalid)begin
         	arvalid<=1;
        	aradd<=radd;
	        if(aready)begin
	        	rready<=1;
	        	if(rvalid)begin
				if(aradd<=radd+(blen)&&aradd>=radd)begin
				   aradd<=aradd+1;
				end
                                 else
	                          aradd<=0;				
	 end	
end
end
end
end
dataout<=rdata;
end
endmodule

module axislave(aclk,reset,awvalid,awadd,awready,wvalid,wdata,wlast,wready,bvalid,bresp,bready,arvalid,aradd,aready,rvalid,rdata,rready,rlast);
input [31:0] awadd,aradd,wdata;
output reg[1:0] bresp;
output reg [31:0] rdata;
input aclk,reset,awvalid,wvalid,wlast,bready,arvalid,rready;
output reg awready,wready,bvalid,aready,rvalid,rlast;
integer i;


reg [31:0]mem[31:0];
reg [2:0] bsize=2;
reg [3:0] blen=7;
reg [1:0] btyp=1;
always @(posedge aclk ) begin
	if(!reset) begin
	       rdata=0;
               awready=0;
	       wready=0;
	       bvalid=0;
	       aready=0;
	       rvalid=0;
	       for(i=0;i<=32;i=i+1) begin
		    mem[i]=0;
	       end
	end
        else begin
		if(awvalid)begin
			awready<=1;	
	           if(wvalid)begin
	               wready<=1;
                       mem[awadd]<=wdata; 
                 	if(bready)begin
				if(wlast==1)begin
	                          bvalid<=1;
	                          bresp<=2'b00;	        							
                                  if(arvalid)begin
		                   aready<=1;
		                   rvalid<=1;
		                   if(rready)begin
		                        rdata<=mem[aradd];
					if(aradd==radd+(blen))
		                         rlast<=1;				       
				 end
			 end
		 end
	 end
 end
 end
 end
 end 
endmodule


module axitop (aclk,reset,wadd,radd,datain,dataout);
input aclk,reset;
input[31:0] wadd,radd,datain;
output[31:0] dataout;

wire [31:0] rdata;
wire  awready, wready, bvalid, aready, rvalid, rlast;
wire[1:0]  bresp;
wire   awvalid, wvalid, wlast, bready, arvalid, rready;
wire [31:0]  wdata, awadd, aradd;

aximaster axm1 (.aclk(aclk),.reset(reset),. awvalid(awvalid),. wadd(wadd),. radd(radd),. awadd(awadd),. aradd(aradd),. awready(awready),. wvalid(wvalid),.datain(datain),. wdata(wdata),. wlast(wlast),. wready(wready),. bvalid(bvalid),. bresp(bresp),. bready(bready),. rdata(rdata),.dataout(dataout),. arvalid(arvalid),. aready(aready),. rvalid(rvalid),. rready(rready),. rlast(rlast));
axislave axs1 (.aclk(aclk),.reset(reset),.awvalid( awvalid),.awadd( awadd),.awready(awready),.wvalid( wvalid),.wdata( wdata),.wlast( wlast),.wready( wready),.bvalid( bvalid),.bresp( bresp),.bready( bready),.arvalid( arvalid),.aradd( aradd),.aready( aready),.rvalid( rvalid),.rdata( rdata),.rready( rready),.rlast( rlast));
endmodule


module axitoptb();
reg aclk,reset;
reg[31:0] wadd,radd,datain;
wire [31:0]dataout;
integer i;

axitop dut(aclk,reset,wadd,radd,datain,dataout);
always #5 aclk=~aclk;
initial begin
aclk=0;
reset=0;
wadd=0;
radd=0;
datain=0;
#10;
reset=1;
#15;
wadd=32'h5;
#10;
for(i=0;i<=7;i=i+1)begin
datain=10+i;
#10;
end
end
initial begin
#75;
read();
end
task read;
radd=32'h5;
endtask
initial 
#2000 $finish;
endmodule

























