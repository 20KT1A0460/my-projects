module ass(inn in);

property p1;
@(posedge in.aclk) disable iff(!in.reset) in.awvalid |-> ##3 in.awready ;
endproperty

property p2;
@(posedge in.aclk) disable iff(!in.reset) in.wvalid |-> ##3 in.wready;
endproperty

property p3;
@(posedge in.aclk) disable iff(!in.reset) ##31 (in.bvalid==1);
endproperty
property p4;
@(posedge in.aclk) disable iff(!in.reset) in.arvalid |-> ##3 in.aready ;
endproperty

property p5;
@(posedge in.aclk) disable iff(!in.reset) in.rvalid   |-> in.rready ;
endproperty

property p6;
@(posedge in.aclk) disable iff(!in.reset) (in.dataout inside {[32'h0:32'hffffffff]}) ;
endproperty

property p7;
@(posedge in.aclk) disable iff(!in.reset) (in.wadd==(in.wadd/in.bsize)*in.bsize) ;
endproperty

property p8;
@(posedge in.aclk) disable iff(!in.reset){!in.wvalid,!in.wready} |-> !in.datain;
endproperty

property p9;
@(posedge in.aclk) disable iff(!in.reset) (in.bsize inside {[4:16]}) ;
endproperty

property p10;
@(posedge in.aclk)  disable iff(!in.reset) (in.bresp inside {0,1,2,3});
endproperty

ass1: assert property(p1);
ass2: assert property(p2);
ass3: assert property(p3);
ass4: assert property(p4);
ass5: assert property(p5);
ass6: assert property(p6);
ass7: assert property(p7);
ass8: assert property(p8);
ass9: assert property(p9);
ass10: assert property(p10);


endmodule
