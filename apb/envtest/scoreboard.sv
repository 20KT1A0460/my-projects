     class scoreboard extends uvm_scoreboard;
     `uvm_component_utils(scoreboard)
     `uvm_analysis_imp_decl(_1)
      `uvm_analysis_imp_decl(_2)
      `uvm_analysis_imp_decl(_3)
      `uvm_analysis_imp_decl(_4)

      //analysis imp //

      uvm_analysis_imp_1 #(seq_item1,scoreboard) s1;      
      uvm_analysis_imp_2 #(seq_item1,scoreboard) s2;       
      uvm_analysis_imp_3 #(seq_item2,scoreboard) s3;       
      uvm_analysis_imp_4 #(seq_item2,scoreboard) s4; 
     int p,q,m,n;

     seq_item1 s[$],r[$];
     seq_item2 t[$],j[$]; 
     seq_item1 sq1,sq2;
     seq_item2 sqt1,sqt2;

     function new(string en="",uvm_component pa);
     super.new(en,pa);
     s1=new("s1",this);
     s2=new("s2",this);
     s3=new("s3",this);
     s4=new("s4",this);

     endfunction

     function void build_phase(uvm_phase phase);
     sq1=seq_item1::type_id::create("sq1");
     sq2=seq_item1::type_id::create("sq2");
     sqt1=seq_item2::type_id::create("sqt1");
     sqt2=seq_item2::type_id::create("sqt2");
     endfunction
     

     task write_1(seq_item1 s1);
     s.push_back(s1); //from mux input monitor
     endtask

      task write_2(seq_item1 s2);
      r.push_back(s2); //from mux ouput monitor
     endtask

     task write_3(seq_item2 s3);
     t.push_back(s3); //from decoder input monitor
     endtask

     task write_4(seq_item2 s4);
     j.push_back(s4); //from decoder output monitor
     endtask



     task run_phase(uvm_phase phase);
     forever begin
     wait(s.size>0&&r.size>0&&t.size>0&&j.size>0);
     if(s.size>0&&r.size>0&&t.size>0&&j.size>0)begin
         sq1=s.pop_front();
         sq2=r.pop_front();
         sqt1=t.pop_front();
         sqt2=j.pop_front();

         //mux_compare//
         
         if(sq1.compare(sq2))begin  //comparing full packet
              uvm_report_info("scoreboard","test_pass_max");
               sq1.print();
               sq2.print(); 
               p=p+1;
             end
         else begin
              uvm_report_info("scoreboard","test_fail_max");
               sq1.print();
               sq2.print(); 
               q=q+1;

         end

          //decoder_compare//

          if(sqt1.compare(sqt2))begin //comparing full packet
              uvm_report_info("scoreboard","test_pass_decoder");
               sqt1.print(); 
               sqt2.print();
               m=m+1;
             end
         else begin
              uvm_report_info("scoreboard","test_fail_decoder");
               sqt1.print(); 
               sqt2.print();
               n=n+1;

         end





     end
     end
     endtask
     
     function void extract_phase(uvm_phase phase);
     $display("test_pass_max=%d",p);
     $display("test_fail_max=%d",q);
     $display("test_pass_decoder=%d",m);
     $display("test_fail_decoder=%d",n);
     endfunction


    endclass


