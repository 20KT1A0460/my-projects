class magent2 extends uvm_agent; //mux agent2
     `uvm_component_utils(magent2)
     omonitor1 om1;  //mux output monnitor
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     endfunction

     function void build_phase(uvm_phase phase);
     om1=omonitor1::type_id::create("om1",this);
     endfunction


     
    endclass

/************************************************************************************/

    class dagent2 extends uvm_agent; //decoder agent2
     `uvm_component_utils(dagent2)
     omonitor2 om2;  //decoder output monitor
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     endfunction

     function void build_phase(uvm_phase phase);
     om2=omonitor2::type_id::create("om2",this);
     endfunction


     
    endclass





