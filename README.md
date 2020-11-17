# JTAG Test

## Hardware
Płytka Maximator  
USB Blaster

## Software
Quartus Prime 20.1

## Uruchomienie podstawowego skryptu na płytce
1. Pobierz i skompiluj projekt JTAG_Test
2. Pobierz tcl_test.tcl z folderu Skrypty
3. Zaprogramuj płytkę przez USB-Blastera za pomocą narzędzia Programmer
4. Przejdź do folderu z Quartusem: /intelFPGA_lite/20.1/quartus/bin64
5. Uruchom wiersz polecenia
6. Wywołaj komendę quartus_stp_tcl -t "ścieżka do pliku tcl_test.tcl"
7. Powinien zaświecić się pierwszy i trzeci LED
