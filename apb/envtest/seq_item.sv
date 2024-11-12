     class seq_item1 extends uvm_sequence_item; //mux seq_item
       rand bit[3:0]a,b,c,d; //mux packet port veriables
       rand  bit s1,s2;
       bit [3:0] y;

          

     `uvm_object_utils_begin(seq_item1)  //object factory registration
     `uvm_field_int(a,UVM_ALL_ON|UVM_DEC) //field registration
      `uvm_field_int(b,UVM_ALL_ON|UVM_DEC)
     `uvm_field_int(c,UVM_ALL_ON|UVM_DEC)
     `uvm_field_int(d,UVM_ALL_ON|UVM_DEC)
     `uvm_field_int(s1,UVM_ALL_ON|UVM_DEC)
     `uvm_field_int(s2,UVM_ALL_ON|UVM_DEC) 
     `uvm_field_int(y,UVM_ALL_ON|UVM_DEC)
     `uvm_object_utils_end

     function new(string en="");
     super.new(en);
     endfunction
     
     endclass

/**************************************************************************/
      class seq_item2 extends uvm_sequence_item; //decoder seq_item
       rand bit f,g;
       bit y1,y2,y3,y4;

     `uvm_object_utils_begin(seq_item2)
     `uvm_field_int(f,UVM_ALL_ON|UVM_DEC)
     `uvm_field_int(g,UVM_ALL_ON|UVM_DEC)
     `uvm_field_int(y1,UVM_ALL_ON|UVM_DEC)
     `uvm_field_int(y2,UVM_ALL_ON|UVM_DEC)
     `uvm_field_int(y3,UVM_ALL_ON|UVM_DEC)
     `uvm_field_int(y4,UVM_ALL_ON|UVM_DEC) 
     `uvm_object_utils_end

     function new(string en="");
     super.new(en);
     endfunction
     
     endclass


