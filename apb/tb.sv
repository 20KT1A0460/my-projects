program tb(inn in);
     env e;
   initial begin
   e=new(in);
   e.epro("rand");///reset,spcaddr,evenadde,oddaddr,incaddr,decaddr,rand,slvin//////// tset modes
   e.print();
   end
endprogram
