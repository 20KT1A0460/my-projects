interface inn ( input aclk);
    logic reset;
    logic [8:0] bsize ;
    logic [5:0] blen ;
    logic [1:0] btyp ;
    logic [31:0] wadd;
    logic [31:0] radd;
    logic [31:0] datain;
    logic [31:0] dataout;

    logic [31:0] rdata;
    logic awready, wready, bvalid, aready, rvalid, rlast;
    logic [1:0] bresp;
    logic awvalid, wvalid, wlast, bready, arvalid, rready;
    logic [31:0] wdata, awadd, aradd;
    logic [5:0] rcount;
endinterface
