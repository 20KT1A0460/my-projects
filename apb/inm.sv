class inm;
      trans t;
      mailbox m;
      event e;
      virtual inn in;
      bit [31:0] mem1 [0:255];
      bit [31:0] mem2 [0:255]; 
      bit [31:0] mem3 [0:255]; 
      bit [31:0] mem4 [0:255]; 
      function new (mailbox m1,event e1,virtual inn in2);
      m=m1;
      e=e1;
      in=in2;
      endfunction
      
      task run();
      t=new();
      forever begin
      @(in.PRESETn,in.write,in.enable,in.addr,in.data,in.sel1,in.sel2,in.sel3,in.sel4);
      t.PRESETn=in.PRESETn;
      t.write=in.write;
      t.enable=in.enable;
      t.sel1=in.sel1;
      t.sel2=in.sel2;
      t.sel3=in.sel3;
      t.sel4=in.sel4;
      t.addr=in.addr;
      t.data=in.data;
      /////////////BFM//////////////////////
      case({t.sel1,t.sel2,t.sel3,t.sel4})
      4'b1000:begin ////////////////////////////////////////////////
               if (!t.PRESETn) begin
                t.PREADY <= 1'b0;
                t.PSLVERR <= 1'b0;
                t. PRDATA <= 32'd0;
               end else if (t.sel1 && t.enable) begin
               t.PREADY <= 1'b1;
               t.PSLVERR <= 1'b0; // Set error signal as required
            
                if (t.write) begin
                mem1[t.addr] <= t.data; // Write operation
                end else begin
                t.PRDATA <= mem1[t.addr]; // Read operation
                 end
               end else begin
               t.PREADY <= 1'b0;
                end
              end/////////////////////////////////////////////

      4'b0100:begin /////////////////////////////////////////////
               if (!t.PRESETn) begin
                t.PREADY <= 1'b0;
                t.PSLVERR <= 1'b0;
                t. PRDATA <= 32'd0;
               end else if (t.sel2 && t.enable) begin
               t.PREADY <= 1'b1;
               t.PSLVERR <= 1'b0; // Set error signal as required
            
                if (t.write) begin
                mem2[t.addr] <= t.data; // Write operation
                end else begin
                t.PRDATA <= mem2[t.addr]; // Read operation
                 end
               end else begin
               t.PREADY <= 1'b0;
                end

              end//////////////////////////////////////////////////
      4'b0010:begin/////////////////////////////////////////////////
                  if (!t.PRESETn) begin
                t.PREADY <= 1'b0;
                t.PSLVERR <= 1'b0;
                t. PRDATA <= 32'd0;
               end else if (t.sel3 && t.enable) begin
              t.PREADY <= 1'b1;
              t.PSLVERR <= 1'b0; // Set error signal as required
            
                if (t.write) begin
                mem3[t.addr] <= t.data; // Write operation
                end else begin
                t.PRDATA <= mem3[t.addr]; // Read operation
                 end
               end else begin
               t.PREADY <= 1'b0;
                end

              end///////////////////////////////////
      4'b0001:begin/////////////////////////////////
               if (!t.PRESETn) begin
                t.PREADY <= 1'b0;
                t.PSLVERR <= 1'b0;
                t. PRDATA <= 32'd0;
               end else if (t.sel4 && t.enable) begin
               t.PREADY <= 1'b1;
               t.PSLVERR <= 1'b0; // Set error signal as required
            
                if (t.write) begin
                mem4[t.addr] <= t.data; // Write operation
                end else begin
                t.PRDATA <= mem4[t.addr]; // Read operation
                 end
               end else begin
               t.PREADY <= 1'b0;
                end

              end/////////////////////////////////

      default:begin
               if(t.write)
               $fatal("error input for slave selction");
               else
                   $display("idle state");

              end
      endcase
      //////////////////////////////////////////////////////end BFM////////////////////////
      m.put(t);
      t.print("inm");
      ->e;
      end
      endtask
endclass

