LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY dff IS
    PORT (
        clk : IN STD_LOGIC;
        D : IN STD_LOGIC;
        Q : OUT STD_LOGIC;
        Qn : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF dff IS
BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            Q <= D;
            Qn <= NOT D;
        END IF;
    END PROCESS;
END ARCHITECTURE;