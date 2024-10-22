class trans;
    bit PCLK;
    bit PRESETn;
    randc bit [31:0] data;
    randc bit [31:0] addr;
    bit  write, enable, sel1, sel2, sel3, sel4;
    bit [31:0] PRDATA;
    bit PREADY;
    bit PSLVERR;

    constraint con_addr { addr inside {[11:20]};}
    constraint con_data {data inside {[10:300]};}

    function void print( string msg);
    $display($time,"PRESETn=%b,write=%b,enable=%b,sel1=%b,sel2=%b,sel3=%b,sel4=%b,addr=%d,data=%d,RDATA=%d,PREADY=%b,PSLVERR=%b,msg=%s",
    PRESETn,write,enable,sel1,sel2,sel3,sel4,addr,data,PRDATA,PREADY,PSLVERR,msg);
    endfunction
endclass
