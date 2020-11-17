# List all available programming hardwares, and select the USBBlaster.
# (Note: this example assumes only one USBBlaster connected.)
puts "Programming Hardwares:"
foreach hardware_name [get_hardware_names] {
	puts $hardware_name
	if { [string match "USB-Blaster*" $hardware_name] } {
		set usbblaster_name $hardware_name
	}
}
puts "\nSelect JTAG chain connected to $usbblaster_name.\n";

# List all devices on the chain, and select the first device on the chain.
puts "\nDevices on the JTAG chain:"
foreach device_name [get_device_names -hardware_name $usbblaster_name] {
	puts $device_name
	if { [string match "@1*" $device_name] } {
		set test_device $device_name
	}
}
puts "\nSelect device: $test_device.\n";

# Open device 
open_device -hardware_name $usbblaster_name -device_name $test_device

device_lock -timeout 10000
device_virtual_ir_shift -instance_index 0 -ir_value 1 -no_captured_ir_value -show_equivalent_device_ir_dr_shift
device_virtual_dr_shift -instance_index 0 -length 4 -dr_value 1010 -no_captured_dr_value -show_equivalent_device_ir_dr_shift
puts "\nDONE\n"
device_unlock

# Close device
close_device