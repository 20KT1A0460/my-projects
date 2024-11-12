     class driver1 extends uvm_driver #(seq_item1); //mux driver 
     `uvm_component_utils(driver1)
                                                     // type parameterized , due to handshake ,type safty ,specific type indication 
     seq_item1 sqt1;
     virtual interf1 in1;
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     endfunction

     function void build_phase(uvm_phase phase);
     sqt1=seq_item1::type_id::create("sqt1");
     uvm_config_db#(virtual interf1)::get(this,"","interface",in1);
     endfunction

     task run_phase(uvm_phase phase);
     forever begin
       seq_item_port.get_next_item(sqt1);  // said to sequencer  "  ready take packets or sequence item"
       in1.a<=sqt1.a;
       in1.b<=sqt1.b;
       in1.c<=sqt1.c;   //driving to interface
       in1.d<=sqt1.d;
       in1.s1<=sqt1.s1;
       in1.s2<=sqt1.s2;
       sqt1.print();
       seq_item_port.item_done(); // said to sequencer  " current sequence item (transaction) is finished "
     end
     endtask
     
    endclass
/*****************************************************************************************************/
    class driver2 extends uvm_driver #(seq_item2);  //decoder driver
     `uvm_component_utils(driver2)

     seq_item2 sqt2;
     virtual interf1 in2;
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     endfunction

     function void build_phase(uvm_phase phase);
     sqt2=seq_item2::type_id::create("sqt2");
     uvm_config_db#(virtual interf1)::get(this,"","interface",in2);
     endfunction

     task run_phase(uvm_phase phase);
     forever begin
       seq_item_port.get_next_item(sqt2);
       in2.f<=sqt2.f;
       in2.g<=sqt2.g; //driving to interface
       sqt2.print();
       seq_item_port.item_done();
     end
     endtask
     
    endclass


