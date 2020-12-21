set_global_assignment -entity "VJTAG1" -library "lib_VJTAG1" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "VJTAG1" -library "lib_VJTAG1" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "VJTAG1" -library "lib_VJTAG1" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_VJTAG1" -name SPD_FILE [file join $::quartus(sip_path) "../VJTAG1.spd"]
set_global_assignment -library "lib_VJTAG1" -name MISC_FILE [file join $::quartus(sip_path) "../../VJTAG1.qsys"]

set_global_assignment -library "lib_VJTAG1" -name MISC_FILE [file join $::quartus(sip_path) "VJTAG1.vhd"]
set_global_assignment -library "lib_VJTAG1" -name MISC_FILE [file join $::quartus(sip_path) "submodules/sld_virtual_jtag.v"]
