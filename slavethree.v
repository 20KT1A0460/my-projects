module slavethree(PCLK,PRESETn,cs,PSEL1,PSEL2,PENABLE,PWRITE,PADDR,PWDATA, PRDATA,PREADY,slverr );
         input PCLK,PRESETn;
         input cs,PSEL1,PSEL2;
          input PENABLE,PWRITE;
         input  [63:0]PADDR,PWDATA;
        output reg [63:0]PRDATA;
        output reg PREADY,slverr ;
    
reg [63:0]slave3[0:63];
always @ (posedge PCLK) begin
if (PRESETn) begin
    PRDATA=64'h0;
    PREADY=0;
    slverr=0;
    end
else begin

if(!cs&&!PENABLE)begin
    
PRDATA=64'h0;
    PREADY=0;
    slverr=0;
    end  
else if (cs&&!PENABLE&& PWRITE) begin
PRDATA=64'h0;
    PREADY=0;
    slverr=0;
    end   
else if(cs&&PENABLE) begin
    if(PSEL1&&!PSEL2) begin
        if(PWRITE)begin
           slave3[PADDR]=PWDATA;
           PREADY=1;
           slverr=0;
          end
           else begin
           PRDATA=slave3[PADDR];
           PREADY=1;
           slverr=0;
           end
           end
       end    
    end
    end       
    endmodule       
     
            
