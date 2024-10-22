class gen #(parameter size=4,parameter len=8,parameter typ=2,parameter [0:31] sadd =32'h65);
    trans t;
    mailbox m;
     event e;
     int c;
     int i;
    function new(mailbox m1,event e2,int k);
      m=m1;
     e=e2;
     c=k;
     endfunction


     task run();
     t=new();
     t.reset=0;
     t.print("gen");
     m.put(t);
     #20;
     t.reset=1;
     t.bsize =size;
     t.blen = len;
     t.btyp =typ;
     m.put(t);
     t.wadd=sadd;
     t.radd=sadd;
     m.put(t);
     t.print("gen");
      #115;
      case(t.btyp)
      0: begin
      t.datain=345;
      m.put(t);
      t.print("gen");
      end
      default:begin 
      repeat(t.blen) begin
      t.datain=234+i;
      i=i+1;
      m.put(t);
      t.print("gen");
        #10;
      end
      end
     endcase
     #340;
     ->e;
     endtask
 


endclass
