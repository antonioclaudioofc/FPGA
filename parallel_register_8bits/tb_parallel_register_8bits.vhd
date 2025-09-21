LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_parallel_register_8bits IS
END ENTITY tb_parallel_register_8bits;

ARCHITECTURE sim OF tb_parallel_register_8bits IS

    COMPONENT parallel_register_8bits
        PORT (
            clk : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            Qn : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk_tb : STD_LOGIC := '0';
    SIGNAL D_tb : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Q_tb : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Qn_tb : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
    UUT : parallel_register_8bits
    PORT MAP(
        clk => clk_tb,
        D => D_tb,
        Q => Q_tb,
        Qn => Qn_tb
    );

    clk_process : PROCESS
    BEGIN
        WHILE now < 100 ns LOOP
            clk_tb <= '1';
            WAIT FOR 5 ns;
            clk_tb <= '0';
            WAIT FOR 5 ns;
        END LOOP;
        WAIT;
    END PROCESS;

    stim_process : PROCESS
    BEGIN
    
        D_tb <= "00000000";
        WAIT FOR 10 ns;

        D_tb <= "11111111";
        WAIT FOR 10 ns;

        D_tb <= "01010101";
        WAIT FOR 10 ns;

        D_tb <= "10101010";
        WAIT FOR 10 ns;

        D_tb <= "11110000";
        WAIT FOR 10 ns;

        D_tb <= "00001111";
        WAIT FOR 10 ns;

        D_tb <= "11001100";
        WAIT FOR 10 ns;

        D_tb <= "00110011";
        WAIT FOR 10 ns;

        D_tb <= "10000000";
        WAIT FOR 10 ns;

        D_tb <= "00000001";
        WAIT FOR 10 ns;

        D_tb <= "01111111";
        WAIT FOR 10 ns;

        D_tb <= "11111110";
        WAIT FOR 10 ns;

        D_tb <= "10100101";
        WAIT FOR 10 ns;

        D_tb <= "01011010";
        WAIT FOR 10 ns;

        D_tb <= "10011001";
        WAIT FOR 10 ns;

        D_tb <= "01100110";
        WAIT FOR 10 ns;

        WAIT FOR 20 ns;
        WAIT;
    END PROCESS;

END ARCHITECTURE sim;