class gen;
      trans t;
      int c;
      event e;
      mailbox m;

      function new(mailbox m1,event e1,int k);
        m=m1;
        e=e1;
        c=k;
      endfunction

      task ran();
      if(t.write==1)begin
          t.addr.rand_mode(1);
          t.data.rand_mode(1);
          end
      else begin
          t.addr.rand_mode(1);
          t.data.rand_mode(0);
          end
      endtask

      task run(string typetest="reset");
      case(typetest)
      "rand":begin
               t=new();
               t.PRESETn=0;
                m.put(t);
                t.print("gen");
                #10;
                t.PRESETn=1;
                m.put(t);
                t.print("gen");
                #10;
                t.write=1;
                t.enable=0;
                {t.sel1,t.sel2,t.sel3,t.sel4}=4'b0001;
                 m.put(t);
                 t.print("gen");
                 #20;
                 t.enable=1;
                 m.put(t);
                 t.print("gen");
                repeat(c) begin
                ran();
                t.randomize();
                m.put(t);
                t.print("gen");
                #10;
                 end
                 #10
                 t.write=0;
                 repeat(c) begin
                 ran();
                 t.randomize();
                 m.put(t);
                 t.print("gen");
                  #10;
                  end
             end
    "spcaddr":begin/////////////////////////////////////
              t=new();
              t.PRESETn=0;
              m.put(t);
              t.print("gen");
              #10;
              t.PRESETn=1;
              m.put(t);
              t.print("gen");
              #10;
              t.write=1;
              t.enable=0;
              {t.sel1,t.sel2,t.sel3,t.sel4}=4'b0001;
              m.put(t);
              t.print("gen");
              #20;
              t.enable=1;
              t.addr=23;
              t.data=345;
              m.put(t);
              t.print("gen");
              #30;
              t.write=0;
              t.addr=23;
              m.put(t);
              t.print("gen");
              end///////////////////////////////////////
    "evenaddr":begin/////////////////////////////////
                t=new();
                t.PRESETn=0;
                m.put(t);
                t.print("gen");
                 #10;
              t.PRESETn=1;
              m.put(t);
              t.print("gen");
              #10;
              t.write=1;
              t.enable=0;
              {t.sel1,t.sel2,t.sel3,t.sel4}=4'b0001;
              m.put(t);
              t.print("gen");
              #20;
              t.enable=1;
              for(int i=10;i<=30;i=i+2)begin
              t.addr=i;
              t.data=i+230;
              m.put(t);
              t.print("gen");
              #10;
              end
              #30;
              t.write=0;
              for(int i=10;i<=30;i=i+2)begin
              t.addr=i;
              m.put(t);
              t.print("gen");
              #10;
              end

              end//////////////////////////////////
    "oddaddr":begin////////////////////////////////////
                  t=new();
                t.PRESETn=0;
                m.put(t);
                t.print("gen");
                 #10;
              t.PRESETn=1;
              m.put(t);
              t.print("gen");
              #10;
              t.write=1;
              t.enable=0;
              {t.sel1,t.sel2,t.sel3,t.sel4}=4'b0001;
              m.put(t);
              t.print("gen");
              #20;
              t.enable=1;
              for(int i=11;i<30;i=i+2)begin
              t.addr=i;
              t.data=i+230;
              m.put(t);
              t.print("gen");
              #10;
              end
              #30;
              t.write=0;
              for(int i=11;i<30;i=i+2)begin
              t.addr=i;
              m.put(t);
              t.print("gen");
              #10;
              end


              end////////////////////////////////////////
    "incaddr":begin/////////////////////////////////////
               t=new();
                t.PRESETn=0;
                m.put(t);
                t.print("gen");
                 #10;
              t.PRESETn=1;
              m.put(t);
              t.print("gen");
              #10;
              t.write=1;
              t.enable=0;
              {t.sel1,t.sel2,t.sel3,t.sel4}=4'b0001;
              m.put(t);
              t.print("gen");
              #20;
              t.enable=1;
              for(int i=11;i<=20;i=i+1)begin
              t.addr=i;
              t.data=i+230;
              m.put(t);
              t.print("gen");
              #10;
              end
              #30;
              t.write=0;
              for(int i=11;i<=20;i=i+1)begin
              t.addr=i;
              m.put(t);
              t.print("gen");
              #10;
              end


              end/////////////////////////////////////
    "decaddr":begin////////////////////////////////////
               t=new();
                t.PRESETn=0;
                m.put(t);
                t.print("gen");
                 #10;
              t.PRESETn=1;
              m.put(t);
              t.print("gen");
              #10;
              t.write=1;
              t.enable=0;
              {t.sel1,t.sel2,t.sel3,t.sel4}=4'b0001;
              m.put(t);
              t.print("gen");
              #20;
              t.enable=1;
              for(int i=20;i>=11;i=i-1)begin
              t.addr=i;
              t.data=i+230;
              m.put(t);
              t.print("gen");
              #10;
              end
              #30;
              t.write=0;
              for(int i=20;i>=11;i=i-1)begin
              t.addr=i;
              m.put(t);
              t.print("gen");
              #10;
              end


              end////////////////////////////////////
    "reset":begin/////////////////////////////////////
            t=new();
            t.PRESETn=0;
                m.put(t);
                t.print("gen");
                 #10;
              t.PRESETn=0;
              m.put(t);
              t.print("gen");
              #10;
              t.write=1;
              t.enable=0;
              {t.sel1,t.sel2,t.sel3,t.sel4}=4'b0001;
              m.put(t);
              t.print("gen");
              #20;
              t.enable=1;
              for(int i=20;i>=11;i=i-1)begin
              t.addr=i;
              t.data=i+230;
              m.put(t);
              t.print("gen");
              #10;
              end
              #30;
              t.write=0;
              for(int i=20;i>=11;i=i-1)begin
              t.addr=i;
              m.put(t);
              t.print("gen");
              #10;
              end
               
            end//////////////////////////////////////
    "slvin" :begin
                 t=new();
            t.PRESETn=0;
                m.put(t);
                t.print("gen");
                 #10;
              t.PRESETn=0;
              m.put(t);
              t.print("gen");
              #10;
              t.write=1;
              t.enable=0;
              {t.sel1,t.sel2,t.sel3,t.sel4}=4'b0011;
              m.put(t);
              t.print("gen");
              #20;
              t.enable=1;
             end
    endcase
     #100;
     ->e;
      endtask
endclass
