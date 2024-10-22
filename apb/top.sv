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
module top ;
 bit PCLK;

 always #5 PCLK=~PCLK;
 initial PCLK=0;

 inn i(.PCLK(PCLK));
 apb_bridge bg (  .PCLK(i.PCLK),
                   .PRESETn(i.PRESETn),
                   . data(i.data),
                   .addr(i.addr),
                   .write(i.write), 
                   .enable(i.enable), 
                   .sel1(i.sel1),
                   .sel2(i.sel2), 
                   .sel3(i.sel3), 
                   .sel4(i.sel4),
                   .PRDATA(i.PRDATA),
                   .PREADY(i.PREADY),
                   .PSLVERR(i.PSLVERR));
 tb t(i);
 ass s(i);

endmodule

