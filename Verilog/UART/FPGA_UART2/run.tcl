set project UART
set top_module UART_top
set target xc7a35tcpg236-1
set bitstream_file build/${project}.runs/impl_1/${top_module}.bit

proc usage {} {
    puts "usage: vivado -mode tcl -source [info script] -tclargs \[simulation/bitstream/program\]"
    exit 1
}

if {($argc != 1) || ([lindex $argv 0] ni {"simulation" "bitstream" "program"})} {
    usage
}



if {[lindex $argv 0] == "program"} {
    open_hw
    connect_hw_server
    current_hw_target [get_hw_targets *]
    open_hw_target
    current_hw_device [lindex [get_hw_devices] 0]
    refresh_hw_device -update_hw_probes false [lindex [get_hw_devices] 0]

    set_property PROBES.FILE {} [lindex [get_hw_devices] 0]
    set_property FULL_PROBES.FILE {} [lindex [get_hw_devices] 0]
    set_property PROGRAM.FILE ${bitstream_file} [lindex [get_hw_devices] 0]

    program_hw_devices [lindex [get_hw_devices] 0]
    refresh_hw_device [lindex [get_hw_devices] 0]
    
    exit
} else {
    file mkdir build
    create_project ${project} build -part ${target} -force
}

read_xdc {
    constraints/Basys3.xdc
}

read_verilog {
    rtl/debounce.v
    rtl/disp_hex_mux.v
    rtl/fifo.v
    rtl/fifo_test.v
    rtl/hex_mux_test.v
    rtl/uart.v
    rtl/uart_rx.v
    rtl/uart_tx.v
    rtl/mod_m_counter.v
    rtl/UART_top.v
    rtl/data_in.v
}


#add_files -fileset sim_1 {
#}

set_property top ${top_module} [current_fileset]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

if {[lindex $argv 0] == "simulation"} {
	start_gui
launch_simulation
	run all
} else {
    launch_runs synth_1 -jobs 8
    wait_on_run synth_1

    launch_runs impl_1 -to_step write_bitstream -jobs 8
    wait_on_run impl_1
    exit
}
