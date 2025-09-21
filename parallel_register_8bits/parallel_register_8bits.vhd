LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY parallel_register_8bits IS
    PORT (
        clk : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        Qn : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE structural OF parallel_register_8bits IS
    COMPONENT dff
        PORT (
            clk : IN STD_LOGIC;
            D : IN STD_LOGIC;
            Q : OUT STD_LOGIC;
            Qn : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    gen_ff : FOR i IN 0 TO 7 GENERATE
        ff_i : dff
        PORT MAP(
            clk => clk,
            D => D(i),
            Q => Q(i),
            Qn => Qn(i)
        );
    END GENERATE;
END ARCHITECTURE;