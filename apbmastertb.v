module apbmastertb();
    reg PCLK,PRESETn,PENABLE,PWRITE;
    reg cs,PSEL1,PSEL2;
    reg   [63:0] PADDR,PWDATA;
    wire   [63:0] PRDATA;
    wire  PREADY,slverr;
     apbmaster dut (
     PCLK,PRESETn,PENABLE,PWRITE,
     cs,PSEL1,PSEL2,
        PADDR,PWDATA,
       PRDATA,
      PREADY,slverr);
always #5 PCLK=~PCLK;
initial begin
PCLK=0;
PRESETn=1;
PADDR=0;
#10;
PRESETn=0;
cs=0;PENABLE=0;
#10;
cs=1;PENABLE=0;PWRITE=1;
#10;
cs=1;PENABLE=1;
PSEL1=0;PSEL2=0;
PADDR=64'h34;
PWDATA=64'h45;
#40;
PWRITE=0;
PADDR=64'h34;
end
initial
#2000$finish;
endmodule






