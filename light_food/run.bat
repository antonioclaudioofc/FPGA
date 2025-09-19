@echo off
echo ========================================
echo Compilando os arquivos VHDL com GHDL...
echo ========================================
ghdl -a light_food.vhd
ghdl -a tb_light_food.vhd

echo ========================================
echo Elaborando o testbench...
echo ========================================
ghdl -e tb_light_food

echo ========================================
echo Executando simulação...
echo ========================================
ghdl -r tb_light_food --vcd=light_food.vcd

echo ========================================
echo Abrindo GTKWave...
echo ========================================
gtkwave light_food.vcd


del *.cf
pause