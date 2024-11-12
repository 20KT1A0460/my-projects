    class test extends uvm_test;
     `uvm_component_utils(test)
     v_sequ vsqu; //virtual sequence
     env en;
     
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     endfunction

     function void build_phase(uvm_phase phase);
     vsqu=v_sequ::type_id::create("vsqu",this);
     en=env::type_id::create("en",this);
     endfunction

     task run_phase(uvm_phase phase);
     phase.raise_objection(this);
      vsqu.start(en.vsr); //start method to trigger body method in virtual interface and  also made connection to virtual sequence and 
      #100;                //virtual sequencer
     phase.drop_objection(this);
     endtask
     
    endclass

