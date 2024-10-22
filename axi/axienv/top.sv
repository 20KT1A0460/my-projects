`include "trans.sv"
`include "gen.sv"
`include "driv.sv"
`include "inm.sv"
`include "om.sv"
`include "scrb.sv"
`include "env.sv"
`include "inn.sv"
`include "rtl.v"
`include "tb.sv"
`include "ass.sv"

module top;
parameter size=4;
parameter len=16;
parameter typ=2;
parameter [0:31]sadd=32'h70;

bit aclk;

always #5 aclk=~aclk;
initial aclk=0;


inn i (.aclk(aclk));
axitop #(.size(size),.len(len),.typ(typ),.sadd(sadd))dut (
    .aclk(i.aclk), 
    .reset(i.reset),
    .bsize(i.bsize),
    .blen(i.blen),
    .btyp(i.btyp), 
    .wadd(i.wadd), 
    .radd(i.radd),
    .datain(i.datain), 
    .dataout(i.dataout) ,
    . trdata(i.rdata),
    .tawready(i.awready),
    .twready(i.wready), 
    .tbvalid(i.bvalid), 
    .taready(i.aready), 
    .trvalid(i.rvalid), 
    .trlast(i.rlast),
    .tbresp(i.bresp),
     .tawvalid(i.awvalid),
     . twvalid(i.wvalid), 
     .twlast(i.wlast), 
     .tbready(i.bready),
     .tarvalid(i.arvalid),
     .trready(i.rready),
   . twdata(i.wdata),
   .tawadd(i.awadd), 
   .taradd(i.aradd),
   .trcount(i.rcount));

     tb #(.size(size),.len(len),.typ(typ),.sadd(sadd)) t(i);
     ass s(i);
endmodule



