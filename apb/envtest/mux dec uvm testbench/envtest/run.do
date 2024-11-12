    vlog top.sv +acc
    vsim  -assertdebug top 
    add wave /top/dut1/*
    add wave /top/dut2/*
    add wave /top/in/*
    add wave /top/as/as1
    add wave /top/as/as2
    add wave /top/as/as3
    add wave /top/as/as4
    add wave /top/as/as5
    add wave /top/as/as6
    add wave /top/as/as7
    add wave /top/as/as8

    run -all
                
                
