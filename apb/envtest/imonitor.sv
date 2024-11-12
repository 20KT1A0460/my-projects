     class imonitor1 extends uvm_monitor;  //mux input monitor
     `uvm_component_utils(imonitor1)
     seq_item1 sqt1;
     uvm_analysis_port#(seq_item1) a1;
     virtual interf1 in1;
     
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     a1=new("a1",this);
     endfunction

     function void build_phase(uvm_phase phase);
     uvm_report_info("imonitor1"," build_phase");
        if(!( uvm_config_db#(virtual interf1)::get(this,"","interface",in1)))
               uvm_report_info("imonitor1","config_fail");
     endfunction

     task run_phase(uvm_phase phase);
     sqt1=seq_item1::type_id::create("sqt1");
     forever begin
     @(in1.a,in1.b,in1.c,in1.d,in1.s1,in1.s2);
     sqt1.a<=in1.a;
     sqt1.b<=in1.b;
     sqt1.c<=in1.c;
     sqt1.d<=in1.d;  //capturing inputs from interace
     sqt1.s1<=in1.s1;
     sqt1.s2<=in1.s2;
     //bfm//
     sqt1.y<=in1.s2?(in1.s1?in1.d:in1.c):(in1.s1?in1.b:in1.a);
     a1.write(sqt1);
     end
     endtask
     
    endclass


/***********************************************************************************/
     class imonitor2 extends uvm_monitor; //decoder  input monitor
     `uvm_component_utils(imonitor2)
     seq_item2 sqt2;
     uvm_analysis_port#(seq_item2) a2;
     virtual interf1 in2;
     
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     a2=new("a2",this);
     endfunction

     function void build_phase(uvm_phase phase);
     sqt2=seq_item2::type_id::create("sqt2");
     uvm_config_db#(virtual interf1)::get(this,"","interface",in2);
     endfunction

     task run_phase(uvm_phase phase);
     forever begin
     @(in2.f,in2.g);
     sqt2.f<=in2.f;
     sqt2.g<=in2.g;
     //bfm//
     sqt2.y1=~in2.f&~in2.g;
     sqt2.y2=in2.f&~in2.g;  //capturing inputs from interface
     sqt2.y3=~in2.f&in2.g;
     sqt2.y4=in2.f&in2.g;
     a2.write(sqt2);
     end
     endtask
     
    endclass
