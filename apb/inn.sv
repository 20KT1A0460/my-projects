interface inn (input PCLK );
    logic PRESETn;
    logic [31:0] data;
    logic [31:0] addr;
    logic write, enable, sel1, sel2, sel3, sel4;
    logic [31:0] PRDATA;
    logic PREADY;
    logic PSLVERR;

endinterface 

