class env #(parameter size=4,parameter len=8,parameter typ=2,parameter [0:31] sadd =32'h65) ;
 trans  t;
 gen #(.size(size),.len(len),.typ(typ),.sadd(sadd)) g;
 driv d;
 inm #(.size(size),.len(len),.typ(typ),.sadd(sadd))i;
 om o;
 scrb s;
 virtual inn in;
 mailbox m,m1,m2;
 event e1,e2,e3,e4,e5;
 int n=12;
 function new(virtual inn in2);
 t=new();
 in=in2;
 m=new;
 m1=new;
 m2=new;
 g=new(m,e1,n);
 d=new(m,e2,in);
 i=new(m1,e3,in);
 o=new(m2,e4,in);
 s=new(m1,m2,e5,in);
 endfunction

task epro();
fork
g.run();
wait(e1.triggered);
d.run();
wait(e2.triggered);
i.run();
wait(e3.triggered);
o.run();
wait(e4.triggered);
s.run();
wait(e5.triggered);
join_any
wait(e1.triggered);
endtask


task print();
$display("no of randomize=%d",n);
$display("no of test pass=%d",s.s);
$display("no oof test fail=%d",s.c);
endtask

endclass
