----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.10.2022 10:49:37
-- Design Name: 
-- Module Name: sumator_2_biti - Behavioral
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

entity sumator_salvare is
    Generic (n : natural := 16);
    Port ( 
        X, Y, Z : in std_logic_vector(n downto 0);
        S       : out std_logic_vector(n downto 0);
        T       : out std_logic_vector(n downto 0)
  );
end sumator_salvare;

architecture Behavioral of sumator_salvare is

begin

 SUMATOARE_ELMENTARE : for i in n - 1 downto 0 generate
    S(i) <= X(i) xor Y(i) xor Z(i);
    T(i + 1) <= (X(i) and Y(i)) or ((X(i) or Y(i)) and Z(i));
 end generate;
    S(n) <= '0';
    T(0) <= '0';
end Behavioral;
