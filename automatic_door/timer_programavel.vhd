-- Temporizador programável com pulso de done
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY timer_programavel IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        start : IN STD_LOGIC; -- Inicia a contagem
        preset : IN unsigned(7 DOWNTO 0); -- Valor de tempo
        done : OUT STD_LOGIC -- Pulso de término
    );
END timer_programavel;

ARCHITECTURE behavioral OF timer_programavel IS
    SIGNAL count : unsigned(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL counting : STD_LOGIC := '0';
BEGIN
    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            count <= (OTHERS => '0');
            counting <= '0';
            done <= '0';
        ELSIF rising_edge(clk) THEN
            IF start = '1' THEN
                count <= (OTHERS => '0'); -- Reinicia contagem
                counting <= '1';
                done <= '0';
            ELSIF counting = '1' THEN
                IF count = preset THEN
                    done <= '1'; -- Pulso de saída
                    counting <= '0';
                ELSE
                    count <= count + 1;
                    done <= '0';
                END IF;
            ELSE
                done <= '0';
            END IF;
        END IF;
    END PROCESS;
END behavioral;