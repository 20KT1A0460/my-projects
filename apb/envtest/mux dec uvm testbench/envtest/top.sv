    `include "uvm_macros.svh"
    import uvm_pkg::*;

    `include "seq_item.sv"
    `include "sequence_t.sv"
     `include "sequencer.sv"
     `include "v_seqr.sv"
     `include "v_sequ.sv"
     `include "driver.sv"
     `include "imonitor.sv"
     `include "agent1.sv"
     `include "omonitor.sv"
     `include "agent2.sv"
     `include "scoreboard.sv"
     `include "subscriber.sv"
     `include "env.sv"
     `include "test.sv"
     `include "interf.sv"
     `include "rtl.v"
     `include "ass.sv"

     module top;

      interf1 in();
      mux4x1 dut1(.a(in.a),.b(in.b),.c(in.c),.d(in.d),.s1(in.s1),.s2(in.s2),.y(in.y));
      dec24 dut2(.f(in.f),.g(in.g),.y1(in.y1),.y2(in.y2),.y3(in.y3),.y4(in.y4));
      ass as(in); //assertion instance

      initial run_test("test");

      initial uvm_config_db#(virtual interf1)::set(uvm_root::get(),"*","interface",in);
      
     endmodule
