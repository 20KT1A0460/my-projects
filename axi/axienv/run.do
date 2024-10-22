vlog top.sv +acc
vsim -assertdebug top
add wave -r *
add wave /top/s/ass9 /top/s/ass2 /top/s/ass8 /top/s/ass10 /top/s/ass5 /top/s/ass3 /top/s/ass4 /top/s/ass7 /top/s/ass6 /top/s/ass1
run -all
