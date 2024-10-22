class om;
    trans t;
    mailbox m;
    event e;
    virtual inn in;
    /////////////////////////////////////////////////////////
     covergroup cv1 ;
     addr_cov:coverpoint t.addr {bins b1 ={32'h0,32'hffffffff};
                                 bins b2 ={[32'h0:32'hffffffff]};}
     endgroup

     covergroup cv2 ;
     data_cov:coverpoint t.data {bins b1 ={32'h0,32'hffffffff};
                                 bins b2 ={[32'h0:32'hffffffff]};}
     endgroup
    
     covergroup cv3 ;
     write_cov:coverpoint t.write {bins b1 ={0};
                                   bins b2 ={1};}
     endgroup

      covergroup cv4 ;
      enable_cov:coverpoint t.enable {bins b1 ={0};
                                 bins b2 ={1};}
     endgroup
      
    covergroup cv5 ;
     sel_cov:coverpoint {t.sel1,t.sel2,t.sel3,t.sel4} {bins b1 ={1,2,4,8};}
    endgroup

    covergroup cv6 ;
      ready_cov:coverpoint t.PREADY {bins b1 ={0};
                                     bins b2 ={1};}
     endgroup
     
     covergroup cv7 ;
      slverr_cov:coverpoint t.PSLVERR {bins b1 ={0};
                                       bins b2 ={1};}
     endgroup
      

     covergroup cv8 ;
      reset_cov:coverpoint t.PRESETn {bins b1 ={0};
                                 bins b2 ={1};}
     endgroup
      
     covergroup cv9 ;
      cross1_cov:cross t.write,t.enable;
      cross2_cov:cross t.enable,t.PREADY ;
     endgroup
      




    ///////////////////////////////////////////////////////////

    function new(mailbox m1,event e1,virtual inn in2);
    m=m1;
    e=e1;
    in=in2;
    cv1=new();cv2=new();cv3=new();cv4=new();cv5=new();cv6=new();cv7=new();cv8=new();cv9=new();
    endfunction

    task run();
    t=new();
    forever begin
    @(in.PRDATA,in.PREADY,in.PSLVERR);
     t.PRESETn=in.PRESETn;
     t.addr=in.addr;
     t.data=in.data;
     t.write=in.write;
     t.enable=in.enable;
     {t.sel1,t.sel2,t.sel3,t.sel4}= {in.sel1,in.sel2,in.sel3,in.sel4};
     t.PREADY=in.PREADY;
     t.PRDATA=in.PRDATA;
     t.PSLVERR=in.PSLVERR;
     cv1.sample(); cv2.sample(); cv3.sample(); cv4.sample(); cv5.sample(); cv6.sample(); cv7.sample(); cv8.sample(); cv9.sample();
     m.put(t);
     t.print("om");
     ->e;
     end
    endtask
endclass
