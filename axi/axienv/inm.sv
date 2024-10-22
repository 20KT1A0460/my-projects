class inm #(parameter size=4,parameter len=8,parameter typ=2,parameter [0:31] sadd =32'h65) ;
    trans t;
    mailbox m;
    event e;
    virtual inn in;
    bit [(size*8)-1:0] mem[(sadd/(len*size))*(len*size):(sadd/size)*size+(len-1)*size+10];
    typedef enum bit[2:0] { idle,
                        waddch,
                        wdatach,
                         wdrsch,
                          raddch ,
                           rdatach
                              } en;
                              en cs,nx;
                             
    function new(mailbox m1,event e2,virtual inn in2);
      m=m1;
      e=e2;
      in=in2;
    endfunction


    task run();
    t=new();
    forever begin
    @(in.datain,in.wadd,in.radd,in.awadd,in.aradd,in.wdata,in.rdata,posedge in.aclk);
      t.datain=in.datain;
      t.wadd=in.wadd;
      t.radd=in.radd;
      t.btyp=in.btyp;
      t.blen=in.blen;
      t.bsize=in.bsize;
      t.reset=in.reset;
      t.awadd=in.awadd;
      t.aradd=in.aradd;
      m.put(t);
      if(!t.reset) begin
          cs<=idle;
          end
      else begin
          cs<=nx;
          end
     bfm();
     m.put(t);
     t.print("inm");
    ->e;
    end
    endtask


    task bfm();
         case(cs)
          idle:begin
                if(in.awvalid)
                    nx<=waddch;
                 else
                     nx<=idle;
               end
          waddch:begin
                 t.awready<=1;
                 if(in.wvalid)begin
                      nx<=wdatach;
                  end
                 else begin
                      nx<=waddch;
                     end
                 end

          wdatach:begin
                   t.wready<=1;
                   mem[in.awadd] <= in.wdata;
                    if (in.bready&&in.wlast) 
                        nx<=wdrsch;
                    else
                        nx<=wdatach;
                  end

           wdrsch:begin
                    t.bvalid <= 1;
                    t.bresp <= 2'b00;
                    if(in.arvalid)
                        nx<=raddch;
                    else
                        nx<=wdrsch;
                  end


          raddch:begin
                  t.aready <= 1;
                  if(in.rready)
                      nx<=rdatach;
                   else
                      nx<=raddch;
                 end


           rdatach:begin
                    t.rvalid<=1;
                    t.rdata<= mem[in.aradd];
                    t.dataout<=t.rdata;
                    m.put(t);
                    case(t.btyp)
                    0:begin
                      if(t.rcount==1)
                          t.rlast=1;
                       else
                          t. rlast=0;
                      end
                    default:begin
                            if(in.rcount==in.blen)
                                t.rlast=1;
                             else
                                 t.rlast=0;
                            end
                    endcase
                    end
          endcase

    endtask
endclass


