library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity sim is
--  Port ( );
end sim;

architecture Behavioral of sim is

component multiply is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           res : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal s1, s2: std_logic_vector(3 downto 0);
signal sout: std_logic_vector(7 downto 0);

begin

UUT: multiply port map( a => s1,
                        b => s2,
                        res => sout);
process

begin                    
    s1 <= "0000";
    s2 <= "0000";
    wait for 1ns;
    s1 <= "0000";
    s2 <= "0001";
    wait for 1ns;
    s1 <= "0000";
    s2 <= "0010";
    wait for 1ns;
    s1 <= "0000";
    s2 <= "0011";
    wait for 1ns;
    s1 <= "0000";
    s2 <= "0100";
    wait for 1ns;
    s1 <= "0001";
    s2 <= "0101";
    wait for 1ns;
    s1 <= "0001";
    s2 <= "0110";
    wait for 1ns;
    s1 <= "0001";
    s2 <= "0111";
    wait for 1ns;
    s1 <= "0001";
    s2 <= "1000";
    wait for 1ns;
    s1 <= "0001";
    s2 <= "1001";
    wait for 1ns;
    s1 <= "0001";
    s2 <= "1010";
    wait for 1ns;
    s1 <= "0001";
    s2 <= "1011";
    wait for 1ns;
    s1 <= "0001";
    s2 <= "1100";
    wait for 1ns;
    s1 <= "0001";
    s2 <= "1101";
    wait for 1ns;
    s1 <= "0001";
    s2 <= "1110";
    wait for 1ns;
    s1 <= "0001";
    s2 <= "1111";
    wait for 1ns;
end process;


end Behavioral;