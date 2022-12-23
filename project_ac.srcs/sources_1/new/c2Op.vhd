----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2022 12:53:57
-- Design Name: 
-- Module Name: c2Op - Behavioral
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
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- this entity receives an operand and sends the operand passed through 2-complement
entity c2Op is
    Generic(n : natural := 8);
    Port ( 
        op : in std_logic_vector(n - 1 downto 0);
        c2 : out std_logic_vector(n - 1 downto 0)
    );
end c2Op;

architecture Behavioral of c2Op is

signal opNegated : std_logic_vector(n - 1 downto 0);

begin
    INVERTER : for i in 0 to n - 1 generate
        opNegated(i) <= not op(i);
    end generate;
    c2 <= opNegated + 1;

end Behavioral;
