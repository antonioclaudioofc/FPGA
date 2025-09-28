LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY automatic_door IS
    PORT (
        clk : IN STD_LOGIC;
        rst_n : IN STD_LOGIC;
        sensor : IN STD_LOGIC;
        fechar_manual : IN STD_LOGIC;
        fim_curso_aberto : IN STD_LOGIC;
        fim_curso_fechado : IN STD_LOGIC;
        motor_abrir : OUT STD_LOGIC;
        motor_fechar : OUT STD_LOGIC;
    );
END ENTITY automatic_door;

ARCHITECTURE behavioral OF automatic_door IS
    TYPE state_type IS (FECHADA, ABRINDO, ABERTA, FECHANDO);
    SIGNAL state, next_state : state_type;
BEGIN
    PROCESS (clk, rst_n)
    BEGIN
        IF rst_n = '0' THEN
            state <= FECHADA;
        ELSIF rising_edge(clk) THEN
            state <= next_state;
        END IF;
    END PROCESS;

    PROCESS (state, sensor, fechar_manual, fim_curso_aberto, fim_curso_fechado)
    BEGIN
        CASE state IS
            WHEN FECHADA =>
                motor_abrir <= '0';
                motor_fechar <= '0';
                IF sensor = '1' THEN
                    next_state <= ABRINDO;
                END IF;

            WHEN ABRINDO =>
                motor_abrir <= '1';
                motor_fechar <= '0';
                IF fim_curso_aberto = '1' THEN
                    next_state <= ABERTA;
                END IF;

            WHEN ABERTA =>
                motor_abrir <= '0';
                motor_fechar <= '0';
                IF fechar_manual = '1' THEN
                    next_state <= FECHANDO;
                END IF;

            WHEN FECHANDO =>
                motor_abrir <= '0';
                motor_fechar <= '1';
                IF fim_curso_fechado = '1' THEN
                    next_state <= FECHADA;
                END IF;

            WHEN OTHERS =>
                next_state <= FECHADA;
        END CASE;
    END PROCESS;

    PROCESS (state)
    BEGIN
        CASE state IS
            WHEN FECHADA =>
                motor_abrir <= '0';
                motor_fechar <= '0';
            WHEN ABRINDO =>
                motor_abrir <= '1';
                motor_fechar <= '0';
            WHEN ABERTA =>
                motor_abrir <= '0';
                motor_fechar <= '0';
            WHEN FECHANDO =>
                motor_abrir <= '0';
                motor_fechar <= '1';
            WHEN OTHERS =>
                motor_abrir <= '0';
                motor_fechar <= '0';
        END CASE;
    END PROCESS;
END ARCHITECTURE behavioral;