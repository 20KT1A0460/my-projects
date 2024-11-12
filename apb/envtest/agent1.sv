    class magent1 extends uvm_agent; //mux agent1
     `uvm_component_utils(magent1)
     sequencer1 sr1;
     driver1 dr1;  //mux driver ,sequencer ,input monitor
     imonitor1 inm1;
     
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     endfunction

     function void build_phase(uvm_phase phase);
     sr1=sequencer1::type_id::create("sr1",this);
     dr1=driver1::type_id::create("dr1",this);
     inm1=imonitor1::type_id::create("inm1",this);
     endfunction

     function void connect_phase(uvm_phase phase);
     dr1.seq_item_port.connect(sr1.seq_item_export); //connection driver and sequencer
     endfunction
     
    endclass
/******************************************************************************************/
     class dagent1 extends uvm_agent; //decoder agent1
     `uvm_component_utils(dagent1)
     sequencer2 sr2;
     driver2 dr2;  //decoder sequencer ,driver ,input monitor
     imonitor2 inm2;
     
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     endfunction

     function void build_phase(uvm_phase phase);
     sr2=sequencer2::type_id::create("sr2",this);
     dr2=driver2::type_id::create("dr2",this);
     inm2=imonitor2::type_id::create("inm2",this);
     endfunction

     function void connect_phase(uvm_phase phase);
     dr2.seq_item_port.connect(sr2.seq_item_export);  //connection  driver and sequecer
     endfunction 
     
    endclass


