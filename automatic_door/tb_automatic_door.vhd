LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_automatic_door IS
END tb_automatic_door;

ARCHITECTURE sim OF tb_automatic_door IS

    SIGNAL clk, rst_n : STD_LOGIC := '0';
    SIGNAL sensor, fechar_manual, fim_curso_aberta, fim_curso_fechada : STD_LOGIC := '0';
    SIGNAL motor_abrir, motor_fechar : STD_LOGIC;

    COMPONENT automatic_door
        PORT (
            clk, rst_n, sensor, fechar_manual, fim_curso_aberta, fim_curso_fechada : IN STD_LOGIC;
            motor_abrir, motor_fechar : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    DUT : automatic_door
    PORT MAP(
        clk => clk,
        rst_n => rst_n,
        sensor => sensor,
        fechar_manual => fechar_manual,
        fim_curso_aberta => fim_curso_aberta,
        fim_curso_fechada => fim_curso_fechada,
        motor_abrir => motor_abrir,
        motor_fechar => motor_fechar
    );

    clk_proc : PROCESS
    BEGIN
        WHILE now < 800 ns LOOP
            clk <= NOT clk;
            WAIT FOR 5 ns;
        END LOOP;
        WAIT;
    END PROCESS clk_proc;

    stimulus : PROCESS
    BEGIN
        -- reset inicial
        rst_n <= '0';
        WAIT FOR 20 ns;
        rst_n <= '1';
        WAIT FOR 10 ns;

        -- 1) Pessoa chega → FECHADA → ABRINDO
        sensor <= '1';
        WAIT FOR 40 ns;
        fim_curso_aberta <= '1'; -- ABRINDO → ABERTA
        WAIT FOR 10 ns;
        fim_curso_aberta <= '0';
        WAIT FOR 20 ns;

        -- 2) Durante ABERTA, sensor=1 reinicia T_ABERTA
        sensor <= '1';
        WAIT FOR 10 ns;
        sensor <= '0';
        WAIT FOR 30 ns;

        -- 3) Pessoa sai → T_ABERTA expira → ABERTA → FECHANDO
        WAIT FOR 200 ns; -- simula expiração do temporizador

        -- 4) FECHANDO → FECHADA
        fim_curso_fechada <= '1';
        WAIT FOR 20 ns;
        fim_curso_fechada <= '0';
        WAIT FOR 40 ns;

        -- 5) Teste fechamento manual: pessoa entra → ABERTA → FECHANDO por fechar_manual
        sensor <= '1';
        WAIT FOR 40 ns;
        fim_curso_aberta <= '1';
        WAIT FOR 10 ns;
        fim_curso_aberta <= '0';
        WAIT FOR 20 ns;

        fechar_manual <= '1'; -- força FECHANDO
        WAIT FOR 20 ns;
        fechar_manual <= '0';
        WAIT FOR 40 ns;

        -- Final da simulação
        WAIT;
    END PROCESS stimulus;

END sim;