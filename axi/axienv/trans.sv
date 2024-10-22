class trans ;
    bit reset;
    bit [8:0] bsize ;
    bit [5:0] blen ;
    bit [1:0] btyp ;
    bit [31:0] wadd;
    bit [31:0] radd;
    bit [31:0] datain;
    bit [31:0] dataout;

    bit [31:0] rdata;
    bit awready, wready, bvalid, aready, rvalid, rlast;
    bit [1:0] bresp;
    bit awvalid, wvalid, wlast, bready, arvalid, rready;
    bit [31:0] wdata, awadd, aradd;
    bit [5:0] rcount;
    

    
    function void print(string msg);
    $display($time,"reset=%b,wadd=%d,radd=%d,awadd=%d,aradd=%d,datain=%d,dataout=%d,bytp=%d,rdata=%d,msg=%s",
    reset,wadd,radd,awadd,aradd,datain,dataout,btyp,rdata,msg);
    endfunction



endclass
