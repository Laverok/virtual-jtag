set_global_assignment -entity "VJTAG" -library "lib_VJTAG" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "VJTAG" -library "lib_VJTAG" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "VJTAG" -library "lib_VJTAG" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_VJTAG" -name SPD_FILE [file join $::quartus(sip_path) "../VJTAG.spd"]
set_global_assignment -library "lib_VJTAG" -name MISC_FILE [file join $::quartus(sip_path) "../../VJTAG.qsys"]

set_global_assignment -library "lib_VJTAG" -name MISC_FILE [file join $::quartus(sip_path) "VJTAG.vhd"]
set_global_assignment -library "lib_VJTAG" -name MISC_FILE [file join $::quartus(sip_path) "submodules/sld_virtual_jtag.v"]
