LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY light_food IS
    PORT (
        clk : IN STD_LOGIC;
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        C : IN STD_LOGIC;
        D : IN STD_LOGIC;
        L : OUT STD_LOGIC
    );
END ENTITY light_food;

ARCHITECTURE behavior OF light_food IS
BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            L <= (A AND B) OR (A AND C) OR (B AND C AND D);
        END IF;
    END PROCESS;
END ARCHITECTURE behavior;