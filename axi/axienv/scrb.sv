class scrb;
    trans t,t1;
    mailbox m,m1;
    event e;
    virtual inn in;
    int s,c;
    function new(mailbox m2,m3,event e1,virtual inn in1);
    m=m2;
    m1=m3;
    e=e1;
    in=in1;
    endfunction

    task run ();
    t=new();
    t1=new();
    forever begin
    m.get(t);
    m1.get(t1);
     t.print("src1");
     t1.print("src2");
     wait(in.reset);
     wait(in.rvalid);
     if (t.dataout==t1.dataout)begin
          $display($time,"<<<<<<<<<<< test pass >>>>>>>>>>>>>>>>> t.dataout=%d,t1.dataout=%d",t.dataout,t1.dataout);
          s=s+1;
      end
     else begin
          $display($time,"<<<<<<<<<<< test fail >>>>>>>>>>>>>>>>> t.dataout=%d,t1.dataout=%d",t.dataout,t1.dataout);
          c=c+1;
          end
    ->e;
    end
    endtask
endclass

