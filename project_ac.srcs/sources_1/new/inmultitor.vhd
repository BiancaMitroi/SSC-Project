----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.11.2022 14:49:37
-- Design Name: 
-- Module Name: inmultitor - Behavioral
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

entity inmultitor is
    Generic (n : natural := 8);
    Port ( 
        X, Y : in std_logic_vector(n - 1 downto 0);
        P    : out std_logic_vector(2 * n downto 0)
  );
end inmultitor;

architecture Behavioral of inmultitor is

component sumator_salvare is
  Generic (n : natural := 16);
    Port ( 
        X, Y, Z : in std_logic_vector(n downto 0);
        S       : out std_logic_vector(n downto 0);
        T       : out std_logic_vector(n downto 0)
  );
end component;

component sumator_anticipare is
    Generic (m : natural := 16);
    Port (
        X, Y : in std_logic_vector(m - 1 downto 0);
        Tin  : in std_logic;
        S    : out std_logic_vector(m - 1 downto 0);
        Tout : out std_logic
   );
end component;
-- n=8
signal s_xy0, s_xy1, s_xy2, s_xy3, s_xy4, s_xy5, s_xy6, s_xy7: std_logic_vector(n - 1 downto 0) := x"00"; -- 8
-- signal : std_logic_vector(n downto 0) := "000000000"; -- 9
-- signal : std_logic_vector(n + 1 downto 0) := "0000000000"; -- 10
-- signal : std_logic_vector(n + 2 downto 0) := "00000000000"; -- 11
signal s_s02, s_s35, s_s05, s_s37, s_s07, s_s: std_logic_vector(2 * n downto 0) := '0' & x"0000"; -- 16
signal xy_0, xy_1, xy_2, xy_3, xy_4, xy_5, xy_6, xy_7 : std_logic_vector(2 * n downto 0) := '0' & x"0000"; -- 16
signal s35, s02, s05, s07, s37, ss : std_logic_vector(2 * n - 1 downto 0) := x"0000"; -- 16
signal t35, t02, t05, t07, t37, st, s_t02, s_t35, s_t05, s_t37, s_t07, s_t: std_logic_vector(2 * n downto 0) := '0' & x"0000"; -- 17
signal tout_s : std_logic := '0';
begin
    XY0 : for i in 0 to (n - 1) generate
        s_xy0(i) <= X(i) and y(0);
    end generate;
    
    XY1 : for i in 0 to (n - 1) generate
        s_xy1(i) <= X(i) and Y(1);
    end generate;
    
    XY2 : for i in 0 to (n - 1) generate
        s_xy2(i) <= X(i) and y(2);
    end generate;
    
    XY3 : for i in 0 to (n - 1) generate
        s_xy3(i) <= X(i) and y(3);
    end generate;
    
    XY4 : for i in 0 to (n - 1) generate
        s_xy4(i) <= X(i) and y(4);
    end generate;
    
    XY5 : for i in 0 to (n - 1) generate
        s_xy5(i) <= X(i) and Y(5);
    end generate;
    
    XY6 : for i in 0 to (n - 1) generate
        s_xy6(i) <= X(i) and y(6);
    end generate;
    
    XY7 : for i in 0 to (n - 1) generate
        s_xy7(i) <= X(i) and y(7);
    end generate;
    xy_0 <= '0' & "0000" & "00" & s_xy2 & "00";
    xy_1 <= '0' & "0000" & "000" & s_xy1 & '0';
    xy_2 <= '0' & "0000" & "0000" & s_xy0;
    xy_3 <= '0' & "000" & s_xy5 & "00000";
    xy_4 <= '0' & "0000" & s_xy4 & "0000";
    xy_5 <= '0' & "0000" & "0" & s_xy3 & "000";
    xy_6 <= '0' & '0' & s_xy7 & "0000000";
    xy_7 <= '0' & "00" & s_xy6 & "000000";
    
--    s35 <= "0000" & s_s35;
--    s02 <= "0000" & s_s02;
--    s05 <= "000" & s_s05;
--    s07 <= "00" & s_S07;
--    s37 <= "000" & s_s37;
--    ss <= '0' & s_s;
    
--    t02 <= "0000" & s_t02;
--    t05 <= "000" & s_t05;
--    t07 <= "00" & s_t07;
--    t35 <= "0000" & s_t35;
--    t37 <= "000" & s_t37;
--    st <= '0' & s_t;
    --                                  X -> 8     Y -> 8       Z -> 8     S -> 8       T -> 9
    SST_02 : sumator_salvare port map (X => xy_0, Y => xy_1, Z => xy_2, S => s_s02, T => s_t02);
    --                                  X -> 8     Y -> 8       Z -> 8     S -> 8       T -> 9
    SST_35 : sumator_salvare port map (X => xy_3, Y => xy_4, Z => xy_5, S => s_s35, T => s_t35);
    --                                  X -> 9     Y -> 9       Z -> 9     S -> 9       T -> 10
    SST_05 : sumator_salvare port map (X => s_s35, Y => s_t02, Z => s_s02, S => s_s05, T => s_t05);
    --                                  X -> 9     Y -> 9       Z -> 9     S -> 9       T -> 10
    SST_37 : sumator_salvare port map (X => xy_6, Y => xy_7, Z => s_t35, S => s_s37, T => s_t37);
    --                                  X -> 10     Y -> 10       Z -> 10     S -> 10       T -> 11
    SST_07 : sumator_salvare port map (X => s_s37, Y => s_t05, Z => s_s05, S => s_s07, T => s_t07);
    --                                  X -> 11     Y -> 11       Z -> 11     S -> 11       T -> 12
    SST : sumator_salvare port map (X => s_t37, Y => s_t07, Z => s_s07, S => s_s, T => s_t);
    --                                  X -> 12     Y -> 12     S -> 12
    SAT : sumator_anticipare port map (X => s_t(2 * n - 1 downto 0), Y => s_s(2 * n - 1 downto 0), Tin => '0', S => P(2 * n - 1 downto 0), Tout => tout_s);
    P(2 * n) <= s_t(2 * n) or tout_s;
end Behavioral;
