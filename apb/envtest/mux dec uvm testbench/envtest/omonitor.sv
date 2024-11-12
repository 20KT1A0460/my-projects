    class omonitor1 extends uvm_monitor; //mux output monitor
     `uvm_component_utils(omonitor1)
     uvm_analysis_port#(seq_item1) m1;
     seq_item1 sqt1;
     virtual interf1 in1;
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     m1=new("m1",this);
     endfunction

     function void build_phase(uvm_phase phase);
     sqt1=seq_item1::type_id::create("sqt1");
     uvm_config_db#(virtual interf1)::get(this,"","interface",in1);
     endfunction

     task run_phase(uvm_phase phase);
      forever begin
     @(in1.y);
     sqt1.a<=in1.a;
     sqt1.b<=in1.b;
     sqt1.c<=in1.c;  //capturing outputs from interface
     sqt1.d<=in1.d;
     sqt1.s1<=in1.s1;
     sqt1.s2<=in1.s2;
     sqt1.y<=in1.y;
     m1.write(sqt1);
     end
     endtask
     
    endclass
/*****************************************************************************************/
     class omonitor2 extends uvm_monitor; //decoder output monitor
     `uvm_component_utils(omonitor2)
     uvm_analysis_port#(seq_item2) m2;
     seq_item2 sqt2;
     virtual interf1 in2;
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     m2=new("m2",this);
     endfunction

     function void build_phase(uvm_phase phase);
     sqt2=seq_item2::type_id::create("sqt1");
     uvm_config_db#(virtual interf1)::get(this,"","interface",in2);
     endfunction

     task run_phase(uvm_phase phase);
      forever begin
      @(in2.y1,in2.y2,in2.y3,in2.y4);
     sqt2.f<=in2.f;
     sqt2.g<=in2.g;
     sqt2.y1=in2.y1; //capturing outputs from interface
     sqt2.y2=in2.y2;
     sqt2.y3=in2.y3;
     sqt2.y4=in2.y4;
     m2.write(sqt2);
         end
     endtask
     
    endclass
