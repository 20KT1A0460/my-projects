    class v_seqr extends uvm_sequencer; 
        `uvm_component_utils(v_seqr) //wrapper class of mux sequencder and decoder sequencer
         sequencer1 sr1; //mux sequencer
         sequencer2 sr2; //decoder sequencer
         function new(string en="",uvm_component pa);
            super.new(en,pa);
        endfunction
   endclass
                  
