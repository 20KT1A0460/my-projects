     class subscriber extends uvm_component;
     `uvm_component_utils(subscriber)
     `uvm_analysis_imp_decl(_1);
     `uvm_analysis_imp_decl(_2);
     uvm_analysis_imp_1#(seq_item1,subscriber) so1;
     uvm_analysis_imp_2#(seq_item2,subscriber) so2;
     seq_item1 sq1;
     seq_item2 sq2;



     covergroup c1;
    pm1: coverpoint  sq1.a {bins a1={[2:7]} with(item%2==0);}
    pm2: coverpoint  sq1.b {bins a2={[2:8]} with (item%2==1);}
    pm3: coverpoint  sq1.c {bins a3= {[0:7]};
                               bins a4={[8:15]};  }  //mux coverages
    pm4:coverpoint   sq1.d {bins a5={[0:5]};}
    pm5:coverpoint sq1.s1  {bins a6={0,1}; }
    pm6:coverpoint sq1.s2 {bins a7={0,1};}
    pm7:coverpoint sq1.y {bins a8={[0:15]};}
     endgroup

     covergroup c2;
    pd1: coverpoint  sq2.f {bins a1={0,1};}
    pd2: coverpoint  sq2.g {bins a2={0,1};}
    pd3: coverpoint  sq2.y1 {bins a3= {0,1}; } //decoder coverages
    pd4:coverpoint   sq2.y2 {bins a5={0,1};}
    pd5:coverpoint sq2.y3  {bins a6={0,1 };}
    pd6:coverpoint sq2.y4 {bins a7={0,1};}
     endgroup
     
     function new(string en="",uvm_component pa);
     super.new(en,pa);
     so1=new("so1",this);
     so2=new("so2",this);
     sq1=new();
     sq2=new();
     c1=new(); 
     c2=new();

     endfunction
     
     function void write_1(seq_item1 t);
     sq1=t;
     c1.sample();
     endfunction

      function void write_2(seq_item2 t1);
      sq2=t1;
      c2.sample();
     endfunction
      

      

     endclass

       


