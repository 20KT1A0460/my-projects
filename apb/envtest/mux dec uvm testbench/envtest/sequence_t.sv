     class sequence_t1 extends uvm_sequence#(seq_item1); //mux sequence
     `uvm_object_utils(sequence_t1)                      // type parameterized , due to handshake ,type safty ,specific type indication 
     seq_item1 sq1;
     
     function new(string en="");
     super.new(en);
     endfunction

     task body();
     sq1=seq_item1::type_id::create("sq1");
     repeat(10)begin
     start_item(sq1);  // said to sequencer "" starting stimulus generation""
     sq1.randomize();   //randomization
     finish_item(sq1); // said to sequencer "" stimulus generation completed"
     #10;
     end
     endtask
    
     
    endclass

/********************************************************************************/
     class sequence_t2 extends uvm_sequence#(seq_item2); //decoder sequence
     `uvm_object_utils(sequence_t2)
     seq_item2 sq2;
     
     function new(string en="");
     super.new(en);
     endfunction

     task body();
     sq2=seq_item2::type_id::create("sq2");
     repeat(10)begin
     start_item(sq2);  //randomization
     sq2.randomize();
     finish_item(sq2);
     #10;
     end
     endtask
    
     
    endclass


