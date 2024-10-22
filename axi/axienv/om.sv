class om;

  trans t;
  mailbox m;
  event e;
  virtual inn in;


   covergroup cv1 ;
     addr_cov:coverpoint t.awadd {bins b1 ={32'h0,32'hffffffff};
                                 bins b2 ={[32'h0:32'hffffffff]};}
     endgroup

     covergroup cv2 ;
     data_cov:coverpoint t.datain {bins b1 ={32'h0,32'hffffffff};
                                 bins b2 ={[32'h0:32'hffffffff]};}
     endgroup
    
     covergroup cv3 ;
     blen_cov:coverpoint t.blen {bins b1 ={[1:16]};}
     endgroup

      covergroup cv4 ;
      bsize_cov:coverpoint t.bsize {bins b1 ={[4:128]};}
     endgroup
      
    covergroup cv5 ;
     btyp_cov:coverpoint t.btyp {bins b1 ={0,1,2,3};}
    endgroup

    covergroup cv6 ;
      brsep_cov:coverpoint t.bresp {bins b1 ={0,1,2,3};}
     endgroup
     
     /*covergroup cv7 ;
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
     endgroup*/
      


  function new(mailbox m1,event e1,virtual inn in1);
    m=m1;
    e=e1;
    in=in1;
     cv1=new();cv2=new();cv3=new();cv4=new();cv5=new();cv6=new();//cv7=new();cv8=new();cv9=new();
  endfunction

  task run();
  t=new();
  forever begin
  @(in.dataout,in.rdata,in.aradd,in.rcount,posedge in.aclk );
     t.datain=in.datain;
      t.wadd=in.wadd;
      t.radd=in.radd;
      t.btyp=in.btyp;
      t.blen=in.blen;
      t.bsize=in.bsize;
      t.reset=in.reset;
      t.awadd=in.awadd;
      t.aradd=in.aradd;
      t.dataout=in.dataout;
      t.rdata=in.rdata;
      t.aradd=in.aradd; 
      t.bresp=in.bresp;
      cv1.sample(); cv2.sample(); cv3.sample(); cv4.sample(); cv5.sample(); cv6.sample(); //cv7.sample(); cv8.sample(); cv9.sample();
    m.put(t);
    t.print("om");
  ->e;
  end
  endtask
endclass

