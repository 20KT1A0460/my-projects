       class v_sequ extends uvm_sequence; 
        `uvm_object_utils(v_sequ)    //wrapper class of mux sequence , decoder sequence and virtual sequencer
         function new(string en="");
          super.new(en);
         endfunction

         sequence_t1 su1; //mux sequence
         sequence_t2 su2; //decoder sequence

          v_seqr vr; //virtual sequencer

         `uvm_declare_p_sequencer(v_seqr)  // handle creation of virtual sequencer using p_sequencer macro

         task body();
         su1=sequence_t1::type_id::create("su1");
         su2=sequence_t2::type_id::create("su2");

         fork
         su1.start(p_sequencer.sr1); 
         su2.start(p_sequencer.sr2);
         join
         endtask
     endclass         
                    
