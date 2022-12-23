----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2022 15:40:37
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
    Generic(n : natural := 8);
    Port ( 
        X, Y : in std_logic_vector(n - 1 downto 0);
        r, clk : in std_logic;
        result : out std_logic_vector(2 * n downto 0);
        sel : in std_logic_vector(1 downto 0);
        div_by_zero_flag : out std_logic
    );
end ALU;

architecture Behavioral of ALU is

component sumator_anticipare is 
    Generic (m : natural := 16);
    Port (
        X, Y : in std_logic_vector(m - 1 downto 0);
        Tin  : in std_logic;
        S    : out std_logic_vector(m - 1 downto 0);
        Tout : out std_logic
   );
end component;

component scazator is
    Generic (m : natural := 8);
    Port (
        X, Y : in std_logic_vector(m - 1 downto 0);
        Tin  : in std_logic;
        S    : out std_logic_vector(m - 1 downto 0);
        Tout : out std_logic
   );
end component;

component inmultitor is
    Generic (n : natural := 8);
    Port ( 
        X, Y : in std_logic_vector(n - 1 downto 0);
        P    : out std_logic_vector(2 * n downto 0)
  );
end component;

component impartitor is
    Generic( n : natural := 8);
    Port (
        X : in std_logic_vector(n - 1 downto 0); -- n biti
        Y : in std_logic_vector(n - 1 downto 0); -- n biti 
        Cat : out std_logic_vector(n - 1 downto 0); --  n biti  
        Rest : out std_logic_vector(n downto 0); --  n biti  
        R, clk : in std_logic;
        gata : out std_logic
    );
end component;
component clkDivider is
    Port ( 
        clk : in std_logic;
        clkDiv : out std_logic
      );
end component;
signal XForAdd, YForAdd : std_logic_vector(2 * n - 1 downto 0);
signal resultFromAdder : std_logic_vector(2 * n downto 0);
signal resultFromMul : std_logic_vector(2 * n downto 0);
signal resultFromDiv : std_logic_vector(2 * n downto 0);
signal resultFromSubber : std_logic_vector(n - 1 downto 0);
signal cout, gata, clkDiv : std_logic;
begin
    XForAdd <= x"00" & X;
    YForAdd <= x"00" & Y;
    ADD: sumator_anticipare port map(x => XForAdd, y => YForAdd, tin => '0', tout => resultFromAdder(2 * n), s => resultFromAdder(2 * n - 1 downto 0));
    SUB: scazator port map(x =>X, y => Y, s => resultFromSubber, tin =>'0', tout =>cout);
    MUL: inmultitor port map(x => X, y => y, p => resultFromMul);
    DIV: impartitor port map(x =>X, y =>Y, cat =>resultFromDiv(n - 1 downto 0), rest => resultFromDiv(2 * n downto n), r =>r, clk =>clk, gata => gata );
    MAPPING_CLKDIVIDER: clkDivider port map(
        clk => clk,
        clkDiv => clkDiv
    );
    result <= resultFromAdder when sel = "00" else
              '0' & x"00" & resultFromSubber when sel = "01" else
              resultFromMul when sel = "10" else
              resultFromDiv when sel = "11" and Y /= x"00" else
              '1' & x"FFFF" when sel = "11" and Y = x"00";
    div_by_zero_flag <= '1' when sel = "11" and Y = x"00" else
                        '0' when sel /= "11";
end Behavioral;