@ECHO OFF
"C:\Program Files (x86)\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "D:\Assembly\NIE Assembly\my projects\measuringDevice\src\labels.tmp" -fI -W+ie -C V2 -o "D:\Assembly\NIE Assembly\my projects\measuringDevice\src\measuringDevice.hex" -d "D:\Assembly\NIE Assembly\my projects\measuringDevice\src\measuringDevice.obj" -e "D:\Assembly\NIE Assembly\my projects\measuringDevice\src\measuringDevice.eep" -m "D:\Assembly\NIE Assembly\my projects\measuringDevice\src\measuringDevice.map" "D:\Assembly\NIE Assembly\my projects\measuringDevice\src\measuringDevice.asm"
