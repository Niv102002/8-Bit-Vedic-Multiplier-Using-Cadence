if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name fast\
   -timing\
    [list ${::IMEX::libVar}/mmmc/fast.lib]
create_library_set -name slow\
   -timing\
    [list ${::IMEX::libVar}/mmmc/slow.lib]
create_rc_corner -name rc\
   -cap_table ${::IMEX::libVar}/mmmc/gpdk090.lef.extended.CapTbl\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -qx_tech_file ${::IMEX::libVar}/mmmc/rc/gpdk090_9l.tch
create_delay_corner -name mindc\
   -library_set fast\
   -rc_corner rc
create_delay_corner -name maxdc\
   -library_set slow\
   -rc_corner rc
create_constraint_mode -name cons\
   -sdc_files\
    [list /dev/null]
create_analysis_view -name wc -constraint_mode cons -delay_corner maxdc
create_analysis_view -name bc -constraint_mode cons -delay_corner mindc
set_analysis_view -setup [list bc] -hold [list wc]
