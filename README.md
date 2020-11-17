# JTAG Test

## Hardware
Płytka Maximator  
USB Blaster

## Software
Quartus Prime 20.1

## Uruchomienie podstawowego skryptu na płytce
1. Skompiluj projekt
2. Zaprogramuj płytkę przez USB-Blastera za pomocą narzędzia Programmer
3. Przejdź do folderu z Quartusem: /intelFPGA_lite/20.1/quartus/bin64
4. Uruchom wiersz polecenia
5. Wywołaj komendę quartus_stp_tcl -t "ścieżka do pliku tcl_test.tcl"
6. Powinien zaświecić się pierwszy i trzeci LED
