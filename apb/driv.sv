class driv;
      trans t;
      mailbox m;
      event e;
      virtual inn in;

      function new (mailbox m1,event e1,virtual inn in2);
      m=m1;
      e=e1;
      in=in2;
      endfunction
      
      task run();
      t=new();
      forever begin
      m.get(t);
      t.print("driv");
      in.PRESETn=t.PRESETn;
      in.write=t.write;
      in.enable=t.enable;
      in.sel1=t.sel1;
      in.sel2=t.sel2;
      in.sel3=t.sel3;
      in.sel4=t.sel4;
      in.addr=t.addr;
      in.data=t.data;
      ->e;
      end
      endtask
endclass

