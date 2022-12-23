----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2022 11:35:11
-- Design Name: 
-- Module Name: Main - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Main is
    Port ( 
    clk: in std_logic;
    sw : in std_logic_vector(15 downto 0);
    btn: in std_logic_vector(2 downto 0);
    an : out std_logic_vector(3 downto 0);
    led: out std_logic_vector(15 downto 0);
    cat: out std_logic_vector(6 downto 0)
    );
end Main;

architecture Behavioral of Main is
component Afisor is
port(     input : in STD_LOGIC_VECTOR(15 downto 0);
		  clk : in STD_LOGIC;
		  cat : out STD_LOGIC_VECTOR(6 downto 0);
	  	  an : out STD_LOGIC_VECTOR(3 downto 0));
end component;
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
component MPG is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           enable : out STD_LOGIC);
end component;

signal result_alu : std_logic_vector(16 downto 0) := '0' & x"0000";
signal input, x, y: std_logic_vector(15 downto 0) := x"0000";
signal counter_states: std_logic_vector(1 downto 0) := "00";
signal sel: std_logic_vector(1 downto 0) := "00";
signal enable: std_logic_vector(2 downto 0) := "000";
signal a, b: std_logic;
-- signal reset: std_logic := '0';
begin
    MAPPING_AFISOR: Afisor port map(
          input => input,
		  clk => clk,
		  cat => cat,
	  	  an => an
    );
    MAPPING_ALU: ALU port map(
        X =>x(7 downto 0),
        Y =>y(7 downto 0),
        r=> (not counter_states(0)) and counter_states(1) ,
        clk => enable(1),
        result => result_alu,
        sel => sel, -- primele 2 switch-uri de la dreapta la stanga pe placa
        div_by_zero_flag => led(1)
    );
    MAPPING_MPG_1: MPG port map(
        clk => clk,
        btn => btn(1),
        enable => enable(1)
    );
    MAPPING_MPG_0: MPG port map(
        clk => clk,
        btn => btn(0),
        enable => enable(0)
    );
    MAPPING_MPG_2: MPG port map(
        clk => clk,
        btn => btn(2),
        enable => enable(2)
    );
    process(enable(0))
    begin
        if rising_edge(enable(0)) then
            counter_states <= counter_states + 1;
        end if;
    end process;
    
    x <= x"00" & sw(15 downto 8);
    sel <= counter_states;
    y <= x"00" & sw(7 downto 0); 
   
    input <= result_alu(15 downto 0);
    led(0) <= result_alu(16);

end Behavioral;
