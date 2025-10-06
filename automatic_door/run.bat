@echo off
echo ========================================
echo Compilando os arquivos VHDL com GHDL...
echo ========================================
ghdl -a automatic_door.vhd
ghdl -a tb_automatic_door.vhd

echo ========================================
echo Elaborando o testbench...
echo ========================================
ghdl -e tb_automatic_door

echo ========================================
echo Executando simulação...
echo ========================================
ghdl -r tb_automatic_door --vcd=automatic_door.vcd

echo ========================================
echo Abrindo GTKWave...
echo ========================================
gtkwave automatic_door.vcd


del *.cf
pause