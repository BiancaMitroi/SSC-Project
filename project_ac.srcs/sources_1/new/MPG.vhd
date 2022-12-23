library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MPG is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           enable : out STD_LOGIC);
end MPG;

architecture Behavioral of MPG is

signal counter: STD_LOGIC_VECTOR(15 downto 0):= "0000000000000000";
signal Q1: STD_LOGIC;
signal Q2: STD_LOGIC;
signal Q3: STD_LOGIC;

begin

    process(clk)
    begin
    if rising_edge(clk) then
            if counter(15 downto 0)="1111111111111111" then
                Q1 <= btn;
            end if;
        end if;        
    end process;

    process(clk)
    begin
    if rising_edge(clk) then
        counter <= counter + 1;
    end if;    
    end process;

    process(clk)
    begin
    if rising_edge(clk) then
        Q2<=Q1;
        Q3<=Q2;
    end if;    
    end process;
    
    enable <= (not Q3) and Q2;
	
end Behavioral;