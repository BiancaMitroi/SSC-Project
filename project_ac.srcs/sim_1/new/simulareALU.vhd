----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2022 20:07:20
-- Design Name: 
-- Module Name: ALU_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simulareALU is
--  Port ( );
end simulareALU;

architecture Behavioral of simulareALU is
component ALU is
    Generic(n : natural := 8);
    Port ( 
        X, Y : in std_logic_vector(n - 1 downto 0);
        r, clk : in std_logic;
        result : out std_logic_vector(2 * n downto 0);
        sel : in std_logic_vector(1 downto 0);
        div_by_zero_flag : out std_logic
    );
end component;
constant n : natural := 8;
signal R, clk, div_by_zero_flag: std_logic;
signal x, y: std_logic_vector(7 downto 0);
signal result: std_logic_vector(16 downto 0);
signal sel: std_logic_vector(1 downto 0);
begin
    MAPPING: ALU port map(

    clk=>clk,
    r =>r ,
    x => x,
    y => y,
    result => result,
    sel => sel,
    div_by_zero_flag => div_by_zero_flag

    );
    process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;
    process
    begin
--        x <= x"03"; y <= x"02"; sel <= "10";
--        wait for 100 ns;
--        x <= x"03"; y <= x"02"; sel <= "01";
--        wait for 100 ns;
--        x <= x"03"; y <= x"02"; sel <= "00";
--        wait for 100 ns;
--        x <= x"03"; y <= x"02"; sel <= "11"; r <= '1';
--        wait for 100 ns;
--        r <= '0';
--        wait for 600 ns;
        x <= x"ff"; y <= x"ff"; sel <= "11"; r <= '1';
        wait for 100 ns;
        r <= '0';
        wait;
    end process;

end Behavioral;
