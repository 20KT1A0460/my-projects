    class env extends uvm_env; 
     `uvm_component_utils(env)
      v_seqr vsr;   //virtual sequencer
      magent1 mag1; //mux agent1
      dagent1 dag1; //decoder agent2
      magent2 mag2; //mux agent2
      dagent2 dag2; //decoder agent2
      subscriber sub; 
      scoreboard sur;
     
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     endfunction

     function void build_phase(uvm_phase phase);
     vsr=v_seqr::type_id::create("vsr",this);
      mag1=magent1::type_id::create("mag1",this);
      dag1=dagent1::type_id::create("dag1",this);
      mag2=magent2::type_id::create("mag2",this);
      dag2=dagent2::type_id::create("dag2",this);
     sub=subscriber::type_id::create("sub",this);
     sur=scoreboard::type_id::create("sur",this);
     endfunction

     function void connect_phase(uvm_phase phase);
     vsr.sr1=mag1.sr1;  //class assignment for shared memory
     vsr.sr2=dag1.sr2;
     
     mag1.inm1.a1.connect(sur.s1);
     mag2.om1.m1.connect(sur.s2); //connection of mux input monitor to scoreboard and output monitor to scroboard
     mag2.om1.m1.connect(sub.so1); //connection of mux output monitor to subscriber
     
    dag1.inm2.a2.connect(sur.s3);
    dag2.om2.m2.connect(sur.s4); //connection of decoder input monitor to scoreboard and output monitor to scroboard
    dag2.om2.m2.connect(sub.so2); //connection of decoder output monitor to subscriber
     endfunction
     
    endclass

