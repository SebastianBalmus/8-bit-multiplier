library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity full_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           cout : out STD_LOGIC;
           s : out STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is

begin

s <= a XOR b XOR cin;
cout <= (a AND b) OR (cin AND a) OR (cin AND b);

end Behavioral;
