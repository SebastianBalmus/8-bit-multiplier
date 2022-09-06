library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiply is
    Port ( CLK100MHZ : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
           a : in STD_LOGIC_VECTOR (3 downto 0);
           leds_a: out STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           leds_b: out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (0 to 6);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           start: in STD_LOGIC);
end multiply;

architecture Behavioral of multiply is

component full_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           cout : out STD_LOGIC;
           s : out STD_LOGIC);
end component full_adder;

component half_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cout : out STD_LOGIC;
           s: out STD_LOGIC);
end component half_adder;

component driver7seg is
    Port ( clk : in STD_LOGIC; --100MHz board clock input
           Din : in STD_LOGIC_VECTOR (15 downto 0); --16 bit binary data for 4 displays
           an : out STD_LOGIC_VECTOR (3 downto 0); --anode outputs selecting individual displays 3 to 0
           seg : out STD_LOGIC_VECTOR (0 to 6)); -- cathode outputs for selecting LED-s in each display
end component driver7seg;

signal result:std_logic_vector(15 downto 0);
signal final_result:std_logic_vector(15 downto 0);
signal a0b0, a1b0, a2b0, a3b0, a0b1, a1b1, a2b1, a3b1, a0b2, a1b2, a2b2, a3b2, a0b3, a1b3, a2b3, a3b3:std_logic;
signal resha1, resha2, resha3, resha4:std_logic;
signal carryha1, carryha2, carryha3, carryha4:std_logic;
signal carryfa1, carryfa2, carryfa3, carryfa4, carryfa5, carryfa6, carryfa7, carryfa8:std_logic;
signal resfa1, resfa2, resfa3, resfa4, resfa5, resfa6, resfa7, resfa8:std_logic;
signal outputsig:std_logic_vector(15 downto 0);

begin



--setting the signal values
a0b0 <= a(0) AND b(0);
a1b0 <= a(1) AND b(0);
a2b0 <= a(2) AND b(0);
a3b0 <= a(3) AND b(0);
a0b1 <= a(0) AND b(1);
a1b1 <= a(1) AND b(1);
a2b1 <= a(2) AND b(1);
a3b1 <= a(3) AND b(1);
a0b2 <= a(0) AND b(2);
a1b2 <= a(1) AND b(2);
a2b2 <= a(2) AND b(2);
a3b2 <= a(3) AND b(2);
a0b3 <= a(0) AND b(3);
a1b3 <= a(1) AND b(3);
a2b3 <= a(2) AND b(3);
a3b3 <= a(3) AND b(3);

ha1: half_adder port map(a =>a1b0,
                         b => a0b1,
                         s => resha1,
                         cout => carryha1);                                               
ha2: half_adder port map(a =>a2b0,
                         b => a1b1,
                         s => resha2,
                         cout => carryha2);                        
ha3: half_adder port map(a =>a3b0,
                         b => a2b1,
                         s => resha3,
                         cout => carryha3);
fa1: full_adder port map(a => resha2,
                         b => a0b2,
                         cin => carryha1,
                         cout => carryfa1,
                         s => resfa1);
fa2: full_adder port map(a => resha3,
                         b => a1b2,
                         cin => carryha2,
                         cout => carryfa2,
                         s => resfa2);
fa3: full_adder port map(a => a3b1,
                         b => a2b2,
                         cin => carryha3,
                         cout => carryfa3,
                         s => resfa3);
fa4: full_adder port map(a => resfa2,
                         b => a0b3,
                         cin => carryfa1,
                         cout => carryfa4,
                         s => resfa4);
fa5: full_adder port map(a => resfa3,
                         b => a1b3,
                         cin => carryha2,
                         cout => carryfa5,
                         s => resfa5);
fa6: full_adder port map(a => a3b2,
                         b => a2b3,
                         cin => carryfa3,
                         cout => carryfa6,
                         s => resfa6);                                                                      
ha4: half_adder port map(a =>resfa5,
                         b => carryfa4,
                         s => resha4,
                         cout => carryha4);                         
fa7: full_adder port map(a => resfa6,
                         b => carryha4,
                         cin => carryfa5,
                         cout => carryfa7,
                         s => resfa7); 
fa8: full_adder port map(a => a3b3,
                         b => carryfa7,
                         cin => carryfa6,
                         cout => carryfa8,
                         s => resfa8); 
                         

result(0) <= a0b0;
result(1) <= resha1;
result(2) <= resfa1;
result(3) <= resfa4;
result(4) <= resha4;
result(5) <= resfa7;
result(6) <= resfa8;
result(7) <= carryfa8;
result(8) <= '0';
result(9) <= '0';
result(10) <= '0';
result(11) <= '0';
result(12) <= '0';
result(13) <= '0';
result(14) <= '0';
result(15) <= '0';

btn:process(CLK100MHZ, start)
begin
    if rising_edge(CLK100MHZ) then
        if start = '1' then
            final_result <= result;
        end if;
    end if;
end process;

leds_a <= a;
leds_b <= b;

display :  driver7seg port map (
    clk => CLK100MHZ,
    Din => final_result,
    an => an,
    seg => seg);

end Behavioral;
