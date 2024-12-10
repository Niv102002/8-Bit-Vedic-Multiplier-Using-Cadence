# RTL Script to run Basic Synthesis Flow
set_db init_lib_search_path /home/install/FOUNDRY/digital/90nm/dig/lib   
set_db hdl_search_path /home/student/Desktop/G26_BD
set_db library slow.lib
read_hdl BDcode.v
elaborate 
read_sdc /home/student/Desktop/G26_BD/constraints_sdc.sdc

set_db syn_generic_effort medium
syn_generic
set_db syn_map_effort medium
syn_map
set_db syn_opt_effort medium
syn_opt


write_hdl > BDcode_netlist.v
write_sdc > BDcode_block.sdc
report_area > BDcode_area.rep
report_gates > BDcode_gate.rep
report_power > BDcode_power.rep
report_timing > BDcode_timing.rep
gui_show


