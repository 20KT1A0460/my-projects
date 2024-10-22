class env;
 trans t;
 gen g;
 driv d;
 inm i;
 om o;
 scrb s;
 virtual inn in;
 mailbox m,m1,m2;
 event e1,e2,e3,e4,e5;
 int n=10;
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

task epro(string typetest="reset");
fork
g.run(typetest);
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
