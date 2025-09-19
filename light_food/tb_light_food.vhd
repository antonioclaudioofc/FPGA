LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_light_food IS
END ENTITY tb_light_food;

ARCHITECTURE sim OF tb_light_food IS

    COMPONENT light_food
        PORT (
            clk : IN STD_LOGIC;
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            C : IN STD_LOGIC;
            D : IN STD_LOGIC;
            L : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL A, B, C, D : STD_LOGIC := '0';
    SIGNAL L : STD_LOGIC;

BEGIN

    UUT : light_food
    PORT MAP(
        clk => clk,
        A => A,
        B => B,
        C => C,
        D => D,
        L => L
    );

    clk_process : PROCESS
    BEGIN
        WHILE now < 160 ns LOOP
            clk <= NOT clk;
            WAIT FOR 5 ns;
        END LOOP;
        WAIT;
    END PROCESS;

    stim_process : PROCESS
    BEGIN
        A <= '0';
        B <= '0';
        C <= '0';
        D <= '0';
        WAIT FOR 10 ns;
        A <= '0';
        B <= '0';
        C <= '0';
        D <= '1';
        WAIT FOR 10 ns;
        A <= '0';
        B <= '0';
        C <= '1';
        D <= '0';
        WAIT FOR 10 ns;
        A <= '0';
        B <= '0';
        C <= '1';
        D <= '1';
        WAIT FOR 10 ns;
        A <= '0';
        B <= '1';
        C <= '0';
        D <= '0';
        WAIT FOR 10 ns;
        A <= '0';
        B <= '1';
        C <= '0';
        D <= '1';
        WAIT FOR 10 ns;
        A <= '0';
        B <= '1';
        C <= '1';
        D <= '0';
        WAIT FOR 10 ns;
        A <= '0';
        B <= '1';
        C <= '1';
        D <= '1';
        WAIT FOR 10 ns;
        A <= '1';
        B <= '0';
        C <= '0';
        D <= '0';
        WAIT FOR 10 ns;
        A <= '1';
        B <= '0';
        C <= '0';
        D <= '1';
        WAIT FOR 10 ns;
        A <= '1';
        B <= '0';
        C <= '1';
        D <= '0';
        WAIT FOR 10 ns;
        A <= '1';
        B <= '0';
        C <= '1';
        D <= '1';
        WAIT FOR 10 ns;
        A <= '1';
        B <= '1';
        C <= '0';
        D <= '0';
        WAIT FOR 10 ns;
        A <= '1';
        B <= '1';
        C <= '0';
        D <= '1';
        WAIT FOR 10 ns;
        A <= '1';
        B <= '1';
        C <= '1';
        D <= '0';
        WAIT FOR 10 ns;
        A <= '1';
        B <= '1';
        C <= '1';
        D <= '1';
        WAIT FOR 10 ns;
        WAIT;
    END PROCESS;

END ARCHITECTURE sim;