module apbmaster(
    input PCLK,PRESETn,PENABLE,PWRITE,
    input cs,PSEL1,PSEL2,
    input   [63:0] PADDR,PWDATA,
    output   [63:0] PRDATA,
    output   PREADY,slverr);

     apbprotocol rt ( PCLK,PRESETn,PENABLE,PWRITE, cs,PSEL1,PSEL2, PADDR,PWDATA, PRDATA, PREADY,slverr);
endmodule


