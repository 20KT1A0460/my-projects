program tb #(parameter size=4,parameter len=8,parameter typ=2,parameter [0:31] sadd =32'h65)(inn in);
     env #(.size(size),.len(len),.typ(typ),.sadd(sadd))e;
   initial begin
   e=new(in);
   e.epro();
   e.print();
   end
endprogram
