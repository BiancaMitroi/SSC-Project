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

entity sumator_mic is
    Generic (n : natural := 2);
    Port ( 
        X, Y : in std_logic_vector((n - 1) downto 0);
        Tin  : in std_logic;
        S    : out std_logic_vector((n - 1) downto 0);
        P, G : out std_logic
  );
end sumator_mic;

architecture Behavioral of sumator_mic is

signal g_signal, p_signal : std_logic_vector((n - 1) downto 0);
signal T, accP, accG : std_logic_vector(n downto 0);

begin
    T(0) <= Tin;
    accG(n) <= '0';
    accP(n) <= '1';
    ELEMENTARY_ADDER : for i in 0 to (n - 1) generate
        g_signal(i) <= X(i) and Y(i);
        p_signal(i) <= X(i) or Y(i);
        T(i + 1) <= g_signal(i) or (p_signal(i) and T(i));
        S(i) <= X(i) xor Y(i) xor T(i);
    end generate;
    ADDER : for i in (n - 1) downto 0 generate
        accG(i) <= accG(i + 1) or (g_signal(i) and accP(i + 1));
        accP(i) <= accP(i + 1) and p_signal(i);
    end generate;
    
    P <= accP(0);
    G <= accG(0);

end Behavioral;
