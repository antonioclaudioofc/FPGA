LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY automatic_door IS
    PORT (
        clk : IN STD_LOGIC;
        rst_n : IN STD_LOGIC;
        sensor : IN STD_LOGIC;
        fechar_manual : IN STD_LOGIC;
        fim_curso_aberta : IN STD_LOGIC;
        fim_curso_fechada : IN STD_LOGIC;
        motor_abrir : OUT STD_LOGIC;
        motor_fechar : OUT STD_LOGIC
    );
END automatic_door;

ARCHITECTURE Behavioral OF automatic_door IS

    TYPE state_type IS (FECHADA, ABRINDO, ABERTA, FECHANDO);
    SIGNAL estado_atual, prox_estado : state_type;

    SIGNAL T_ABERTA : unsigned(3 DOWNTO 0) := (OTHERS => '0');
    CONSTANT LIMITE_T_ABERTA : unsigned(3 DOWNTO 0) := to_unsigned(15, 4); 

BEGIN
    PROCESS (clk, rst_n)
    BEGIN
        IF rst_n = '0' THEN
            estado_atual <= FECHADA;
            T_ABERTA <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            estado_atual <= prox_estado;

            IF estado_atual = ABERTA THEN
                IF sensor = '1' THEN
                    T_ABERTA <= (OTHERS => '0'); -- reinicia se há presença
                ELSIF T_ABERTA < LIMITE_T_ABERTA THEN
                    T_ABERTA <= T_ABERTA + 1; -- incrementa até limite
                END IF;
            ELSE
                T_ABERTA <= (OTHERS => '0'); -- zera fora do estado ABERTA
            END IF;
        END IF;
    END PROCESS;

    PROCESS (estado_atual, sensor, fechar_manual, fim_curso_aberta, fim_curso_fechada, T_ABERTA)
    BEGIN
        prox_estado <= estado_atual;

        CASE estado_atual IS
            WHEN FECHADA =>
                IF sensor = '1' THEN
                    prox_estado <= ABRINDO;
                END IF;

            WHEN ABRINDO =>
                IF fim_curso_aberta = '1' THEN
                    prox_estado <= ABERTA;
                END IF;

            WHEN ABERTA =>
                IF fechar_manual = '1' THEN
                    prox_estado <= FECHANDO;
                ELSIF (sensor = '0') AND (T_ABERTA = LIMITE_T_ABERTA) THEN
                    prox_estado <= FECHANDO;
                END IF;

            WHEN FECHANDO =>
                IF fim_curso_fechada = '1' THEN
                    prox_estado <= FECHADA;
                END IF;

            WHEN OTHERS =>
                prox_estado <= FECHADA;
        END CASE;
    END PROCESS;

    PROCESS (estado_atual)
    BEGIN
        motor_abrir <= '0';
        motor_fechar <= '0';

        CASE estado_atual IS
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
        END CASE;
    END PROCESS;

END Behavioral;