class  driv;
   trans t;
   event e;
   mailbox m;
   
   virtual inn in;

   function new(mailbox m1,event e1,virtual inn in2);
   m=m1;
   e=e1;
   in=in2;
   endfunction

   task run();
   t=new();
   forever begin
   m.get(t);
   t.print("driv");
   in.reset=t.reset;
   in.blen=t.blen;
   in.bsize=t.bsize;
   in.btyp=t.btyp;
   in.wadd=t.wadd;
   in.radd=t.radd;
   in.datain=t.datain;
   ->e;
   end
   endtask
    

endclass
