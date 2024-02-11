#!/bin/bash
echo "Compilando..."

# Compile the code
cargo build

# Run the code
echo "Lembre-se de adptar o caminho do arquivo de entrada no arquivo run.sh"

sleep 1

echo "Executando..."
avrdude -v -patmega328p -carduino -P/dev/ttyUSB0 -b115200 -D -Uflash:w:target/avr-atmega328p/debug/rust-on-arduino.elf:e