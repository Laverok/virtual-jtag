set_global_assignment -entity "VJTAG0" -library "lib_VJTAG0" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "VJTAG0" -library "lib_VJTAG0" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "VJTAG0" -library "lib_VJTAG0" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_VJTAG0" -name SPD_FILE [file join $::quartus(sip_path) "../VJTAG0.spd"]
set_global_assignment -library "lib_VJTAG0" -name MISC_FILE [file join $::quartus(sip_path) "../../VJTAG0.qsys"]

set_global_assignment -library "lib_VJTAG0" -name MISC_FILE [file join $::quartus(sip_path) "VJTAG0.vhd"]
set_global_assignment -library "lib_VJTAG0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/sld_virtual_jtag.v"]
