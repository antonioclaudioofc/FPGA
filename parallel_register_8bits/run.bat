@echo off
echo ========================================
echo Compilando os arquivos VHDL com GHDL...
echo ========================================
ghdl -a dff.vhd
ghdl -a parallel_register_8bits.vhd
ghdl -a tb_parallel_register_8bits.vhd

echo ========================================
echo Elaborando o testbench...
echo ========================================
ghdl -e tb_parallel_register_8bits

echo ========================================
echo Executando simulação...
echo ========================================
ghdl -r tb_parallel_register_8bits --vcd=parallel_register_8bits.vcd

echo ========================================
echo Abrindo GTKWave...
echo ========================================
gtkwave parallel_register_8bits.vcd


del *.cf
pause