class scrb;
     trans t,t1;
     mailbox m,m1;
     event e;
     virtual inn in;
     int s,c;
     function new(mailbox m2,m3,event e1,virtual inn in2);
     m=m2;
     m1=m3;
     e=e1;
     in=in2;
     endfunction

     task run();
     t=new();
     t1=new();
     forever begin
     m.get(t);
     m1.get(t1);
     t.print("src1");
     t1.print("src2");
     wait(in.PRESETn);
     wait(!in.write);
     if (t.PRDATA==t1.PRDATA)begin
          $display($time,"<<<<<<<<<<< test pass >>>>>>>>>>>>>>>>> t.PRDTA=%d,t1.PRDATA=%d",t.PRDATA,t1.PRDATA);
          s=s+1;
      end
     else begin
          $display($time,"<<<<<<<<<<< test fail >>>>>>>>>>>>>>>>> t.PRDTA=%d,t1.PRDATA=%d",t.PRDATA,t1.PRDATA);
          c=c+1;
          end
          ->e;
     end
     endtask
endclass
