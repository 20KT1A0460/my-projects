     class sequencer1 extends uvm_sequencer#(seq_item1); //mux sequencer 
     `uvm_component_utils(sequencer1)               // type parameterized , due to handshake ,type safty ,specific type indication 

     
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     endfunction
     
    endclass
/**********************************************************************/
     class sequencer2 extends uvm_sequencer#(seq_item2); //decoder sequencer
     `uvm_component_utils(sequencer2)
     
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     endfunction
     
    endclass
