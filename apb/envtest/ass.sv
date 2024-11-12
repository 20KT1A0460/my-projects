     module ass(interf1 in);

     property p1;     //mux assertions 
     @(in.a,in.b,in.c,in.d,in.s1,in.s2)  ( in.s1&&in.s2)|-> (in.y==in.d); //s1=1 s2=1 y=d;
     endproperty

      property p2;
     @(in.a,in.b,in.c,in.d,in.s1,in.s2)  ( ~in.s1&&in.s2)|-> (in.y==in.c); // s1=0 s2=1 y=c;
     endproperty
                                                                        
      property p3;
     @(in.a,in.b,in.c,in.d,in.s1,in.s2)  ( ~in.s1&&~in.s2)|-> (in.y==in.a); //s1=0 s2=0 y=a
     endproperty  

      property p4;
     @(in.a,in.b,in.c,in.d,in.s1,in.s2)  ( in.s1&&~in.s2)|-> (in.y==in.b); //s1=1  s2=0 y=b
     endproperty  //
    


     property p5;  //decoder assertion
     @(in.f,in.g,in.y1,in.y2,in.y3,in.y4)  ( ~in.f&&~in.g)|-> (in.y1==1 &&in.y2==0&&in.y3==0&&in.y4==0);  //f=0 g=0 only y1=1;
     endproperty

      property p6;
     @(in.f,in.g,in.y1,in.y2,in.y3,in.y4)  ( in.f&&~in.g)|-> (in.y1==0 &&in.y2==1&&in.y3==0&&in.y4==0); //f=1 g=0  only y2=1;
     endproperty
                                                                   
     property p7;
     @(in.f,in.g,in.y1,in.y2,in.y3,in.y4)  ( ~in.f&&in.g)|-> (in.y1==0 &&in.y2==0&&in.y3==1&&in.y4==0); //f=0 g=1  only y3=1;
     endproperty

      property p8;
     @(in.f,in.g,in.y1,in.y2,in.y3,in.y4)  ( in.f&&in.g)|-> (in.y1==0 &&in.y2==0&&in.y3==0&&in.y4==1); // f=1  g=1  only y4=1;
     endproperty //


    as1: assert property(p1);
    as2: assert property(p2);
    as3: assert property(p3); //mux 
    as4: assert property(p4);
     
    as5: assert property(p5);
    as6: assert property(p6); //decoder
    as7: assert property(p7);
    as8: assert property(p8);
     endmodule

