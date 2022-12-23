----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.10.2022 10:58:33
-- Design Name: 
-- Module Name: sumator_8_biti - Behavioral
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

entity sumator_anticipare is
    Generic (m : natural := 16);
    Port (
        X, Y : in std_logic_vector(m - 1 downto 0);
        Tin  : in std_logic;
        S    : out std_logic_vector(m - 1 downto 0);
        Tout : out std_logic
   );
end sumator_anticipare;

architecture Behavioral of sumator_anticipare is

component sumator_mic is
Generic (n : natural := 2);
Port ( 
        X, Y : in std_logic_vector((n - 1) downto 0);
        Tin  : in std_logic;
        S    : out std_logic_vector((n - 1) downto 0);
        P, G : out std_logic
  );
end component;

--component c2Op is
--Generic(n : natural := 12);
--    Port ( 
--        op : in std_logic_vector(n - 1 downto 0);
--        c2 : out std_logic_vector(n - 1 downto 0)
--    );
--end component;

constant n : natural := 2;
signal T, P, G : std_logic_vector(0 to m / n);
-- signal Yneg : std_logic_vector((m - 1) downto 0);

begin
    -- NEG : c2Op port map(op => Y, c2 => Yneg);
    T(0) <= Tin;
    MAPPING : for i in 0 to (m / n - 1) generate
        DUT : sumator_mic port map (X => X((i * n + n - 1) downto i * n), Y => Y((i * n + n - 1) downto i * n), Tin => T(i), S => S((i * n + n - 1) downto i * n), P => P(i), G => G(i));
        T(i + 1) <= G(i) or (P(i) and T(i));
    end generate;
    Tout <= T(m / n); 
end Behavioral;
