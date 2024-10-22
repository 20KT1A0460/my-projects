module aximaster #(parameter size=4,parameter len=8,parameter typ=2,parameter [0:31] sadd =32'h65) (
    input  aclk,
    input  reset,
    input [8:0] bsize ,
    input [5:0] blen ,
    input [1:0] btyp ,
    output reg awvalid,
    input  awready,
    input  [(size*8)-1:0] wadd,
    output reg [(size*8)-1:0] awadd,
    output reg wvalid,
    input  wready,
    input  [(size*8)-1:0] datain,
    output reg [(size*8)-1:0] wdata,
    output reg wlast,
    output reg bready,
    input  bvalid,
    input  [1:0] bresp,
    output reg arvalid,
    input  aready,
    input  [(size*8)-1:0] radd,
    output reg [(size*8)-1:0] aradd,
    output reg rready,
    input  [(size*8)-1:0] rdata,
    input  rvalid,
    input  rlast,
    output reg [(size*8)-1:0] dataout,
    output reg [5:0] rcount=0
);
     reg [5:0] wcount=0;
     reg[31:0]wrapb=0;
     reg[31:0]addrn=0;
     reg[(size*8)-1:0]aligend;
     integer n=1,k=1;
     reg[7:0] wtemp=0,rtemp=0;
     parameter idle =3'b00;
     parameter waddch=3'b001;
     parameter wdatach =3'b010;
     parameter wdrsch=3'b011;
     parameter raddch =3'b100;
     parameter rdatach=3'b101;
     reg [2:0] cs,nx;
     always @(posedge aclk) begin
      if (!reset) begin
           cs<=idle;
        awvalid <= 0;
        wvalid <= 0;
        wlast <= 0;
        bready <= 0;
        arvalid <= 0;
        rready <= 0;
        wdata <= 0;
        awadd <= 0;
        aradd <= 0;
        dataout <= 0;
                         end 
      else begin
        cs<=nx;
     end
   end
always @(posedge aclk) begin
            case (cs)
      idle:begin
           if(reset)
               nx<=waddch;
           else
               nx<=idle;
           end
      waddch:begin
              awvalid <= 1;
              awadd <= (wadd/bsize)*bsize;
              if(awready)
                  nx<=wdatach;
              else
                  nx<=waddch;
             end
      wdatach:begin
               wvalid<=1;
               bready<=1;
               if(wready)begin
                   case(btyp)
                   2'b00:begin//////////////////FIXIED
                         awadd<=(wadd/bsize)*bsize;
                         wdata<=datain;
                         wlast=1;
                         if(wlast==1)
                             nx<=wdrsch;
                         else
                             nx<=wdatach;
                         end
                   2'b01:begin///////////////////////INCREMENTED
                           if(n<=blen)  begin
                              aligend=(wadd/bsize)*bsize;
                              awadd = aligend+(n-1)* bsize;
                              wdata = datain;
                              n=n+1;
                            if (n>=blen)begin
                              wlast <= 1;
                              nx<=wdrsch;
                           end
                            else begin
                              wlast<=0;
                              nx<=wdatach;
                             end
                          end 

                        

                      end
                   2'b10:begin////////////////////////////WRAPPING
                          wrapb=((wadd/(blen*bsize))*(blen*bsize));
                          addrn=wrapb+(blen*bsize);
                          if(wcount<blen)begin
                              awadd=awadd+wtemp;
                              wtemp=bsize;
                              wdata<=datain;
                              wcount=wcount+1;
                              if(awadd>=addrn)begin
                                  awadd=wrapb;
                                  end
                               else begin
                                  awadd=awadd;
                                 end
                               if(wcount>=blen)begin
                                   wlast=1;
                                   nx<=wdrsch;
                               end
                                else begin
                                    wlast=0;
                                    nx<=wdatach;
                                end
                           end 
                         end
                       endcase
                                end
              end
      wdrsch:begin
              if(bvalid)
                  nx<=raddch;
              else 
                  nx<=wdrsch;
             end
      raddch:begin
              arvalid <= 1;
              aradd <= (radd/bsize)*bsize;
              if(aready)
                  nx<=rdatach;
              else
                  nx<=raddch;
             end
       rdatach:begin
               rready<=1;
                if (rvalid) begin
                  case(btyp)
                   2'b00:begin/////////////////////FIXIED
                         aradd<=(radd/bsize)*bsize;
                         rcount=rcount+1;
                         end
                   2'b01:begin//////////////////////////INCREMENT
                            if(k<=blen)  begin
                                aligend=(radd/bsize)*bsize;
                                aradd = aligend +(k-1)* bsize;
                                k=k+1;
                                rcount=rcount+1;
                              end
                      end
                   2'b10:begin//////////////////////////WRAPPINg
                          wrapb=((radd/(blen*bsize))*(blen*bsize));
                          addrn=wrapb+(blen*bsize);
                          if(rcount<blen) begin
                              aradd=aradd+rtemp;
                              rtemp=bsize;
                              rcount=rcount+1;
                              if(aradd>=addrn)
                                  aradd=wrapb;
                               else
                                  aradd=aradd;
                           end 
                           end
                       endcase

                end
                else
                    nx<=rdatach;
               end
       endcase
 dataout=rdata;
end
endmodule



module axislave #(parameter size=4,parameter len=8,parameter typ=2,parameter [0:31] sadd=32'h65) (
    input  aclk,
    input  reset,
    input [8:0] bsize ,
    input [5:0] blen ,
    input [1:0] btyp ,

    input  awvalid,
    input  [(size*8)-1:0] awadd,
    output reg awready,
    input  wvalid,
    input  [(size*8)-1:0] wdata,
    input  wlast,
    output reg wready,
    output reg bvalid,
    output reg [1:0] bresp,
    input  bready,
    input  arvalid,
    input  [(size*8)-1:0] aradd,
    output reg aready,
    output reg rvalid,
    output reg [(size*8)-1:0] rdata,
    input  rready,
    output reg rlast,
    input [5:0] rcount
);

reg [(size*8)-1:0] mem[(sadd/(len*size))*(len*size):(sadd/size)*size+(len-1)*size+10];
integer i;
     parameter idle =3'b00;
     parameter waddch=3'b001;
     parameter wdatach =3'b010;
     parameter wdrsch=3'b011;
     parameter raddch =3'b100;
     parameter rdatach=3'b101;
     reg [2:0] cs,nx;
     
always @(posedge aclk) begin
    if (!reset) begin
         cs<=idle;
        rdata <= 0;
        awready <= 0;
        wready <= 0;
        bvalid <= 0;
        aready <= 0;
        rvalid <= 0;
        bresp<=0;
        rlast<=0;
        for (i = (sadd/(len*size))*(len*size); i <=(sadd/size)*size+(len-1)*size+10; i = i +1) begin
            mem[i] <= 0;
        end
           end 
    else begin
        cs<=nx;
     end
   end
    always @(posedge aclk) begin
          case(cs)
          idle:begin
                if(awvalid)
                    nx<=waddch;
                 else
                     nx<=idle;
               end
          waddch:begin
                 awready<=1;
                 if(wvalid)begin
                      nx<=wdatach;
                  end
                 else begin
                      nx<=waddch;
                     end
                 end

          wdatach:begin
                   wready<=1;
                   mem[awadd] <= wdata;
                    if (bready&&wlast) 
                        nx<=wdrsch;
                    else
                        nx<=wdatach;
                  end

           wdrsch:begin
                    bvalid <= 1;
                    bresp <= 2'b00;
                    if(arvalid)
                        nx<=raddch;
                    else
                        nx<=wdrsch;
                  end


          raddch:begin
                  aready <= 1;
                  if(rready)
                      nx<=rdatach;
                   else
                      nx<=raddch;
                 end


           rdatach:begin
                    rvalid<=1;
                    rdata <= mem[aradd];
                    case(btyp)
                    0:begin
                      if(rcount==1)
                          rlast=1;
                       else
                           rlast=0;
                      end
                    default:begin
                            if(rcount==blen)
                                rlast=1;
                             else
                                 rlast=0;
                            end
                    endcase
                    end
          endcase
       end
endmodule


module axitop #(parameter size=4,parameter len=8,parameter typ=2,parameter [0:31] sadd=32'h65) (
    input wire aclk,
    input wire reset,
     input [8:0] bsize ,
    input [5:0] blen ,
    input [1:0] btyp ,
    input wire [(size*8)-1:0] wadd,
    input wire [(size*8)-1:0] radd,
    input wire [(size*8)-1:0] datain,
    output wire [(size*8)-1:0] dataout,

    output [(size*8)-1:0] trdata,
    output tawready, twready, tbvalid, taready, trvalid, trlast,
    output [1:0] tbresp,
    output tawvalid, twvalid, twlast, tbready, tarvalid, trready,
    output [(size*8)-1:0] twdata, tawadd, taradd,
    output [5:0] trcount);
    
     wire [(size*8)-1:0] rdata;
    wire awready, wready, bvalid, aready, rvalid, rlast;
    wire [1:0] bresp;
    wire awvalid, wvalid, wlast, bready, arvalid, rready;
    wire [(size*8)-1:0] wdata, awadd, aradd;
    wire [5:0] rcount;

    

aximaster #(.size(size),.len(len),.typ(typ),.sadd(sadd)) axm1 (
              .aclk(aclk), .reset(reset),.bsize(bsize),.blen(blen),.btyp(btyp), .awvalid(awvalid), .wadd(wadd), .radd(radd),
              .awadd(awadd), .aradd(aradd), .awready(awready), .wvalid(wvalid),
              .datain(datain), .wdata(wdata), .wlast(wlast), .wready(wready),
              .bvalid(bvalid), .bresp(bresp), .bready(bready), .rdata(rdata),
              .dataout(dataout), .arvalid(arvalid), .aready(aready),
              .rvalid(rvalid), .rready(rready), .rlast(rlast),.rcount(rcount)
                                         );

axislave #(.size(size),.len(len),.typ(typ),.sadd(sadd)) axs1 (
             .aclk(aclk), .reset(reset),.bsize(bsize),.blen(blen),.btyp(btyp), .awvalid(awvalid),.awadd(awadd), .awready(awready),
             .wvalid(wvalid), .wdata(wdata), .wlast(wlast), .wready(wready),
             .bvalid(bvalid), .bresp(bresp), .bready(bready), .arvalid(arvalid),
             .aradd(aradd), .aready(aready), .rvalid(rvalid), .rdata(rdata),
             .rready(rready), .rlast(rlast),.rcount(rcount)
                                           );


 assign trdata=rdata;
 assign tawready=awready; 
  assign twready=wready; 
  assign tbvalid=bvalid; 
  assign taready=aready; 
   assign trvalid=rvalid; 
    assign trlast= rlast;
    assign tbresp= bresp;
   assign tawvalid =awvalid; 
   assign twvalid=wvalid; 
   assign twlast= wlast; 
  assign tbready= bready;
   assign tarvalid=arvalid; 
   assign trready=rready;
   assign twdata= wdata; 
   assign tawadd= awadd; 
    assign taradd=aradd;
    assign trcount=rcount;


endmodule



