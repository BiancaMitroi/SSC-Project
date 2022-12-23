----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.11.2022 16:14:43
-- Design Name: 
-- Module Name: inmultitorOrganigrama - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_signed.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity inmultitorOrganigrama is
    Generic( n : natural := 8);
    Port (
        X : in std_logic_vector(n downto 0); -- n + 1 biti
        Y : in std_logic_vector(n downto 0); -- n + 1 biti (9, de la 8 la 0)
        P : out std_logic_vector(2 * n + 1 downto 0); --  2 * n + 2 biti (18, de la 17 la 0) 
        R, clk : in std_logic
    );
end inmultitorOrganigrama;

architecture Behavioral of inmultitorOrganigrama is

-- codificare stari
type STATE is (start, idle, shifting, stop);
signal currentState, nextState : STATE;

-- registers, Q(-1) and C
signal B    : std_logic_vector(n downto 0) := '0' & x"00";
signal A    : std_logic_vector(n downto 0) := '0' & x"00";
signal Q    : std_logic_vector(n downto 0) := '0' & x"00";
signal Q_1  : std_logic := '0';
signal C    : natural := n + 1;

begin
    
    next_state : process(currentState, X, Y)
    begin

            case currentState is
                when start => 
                    nextState <= idle;
                when idle =>
                        nextState <= shifting;
                when shifting =>
                    if C > 1 then nextState <= idle;
                    else nextState <= stop; end if;
                when stop => nextState <= stop;
            end case;

    end process next_state;
    
    setting_state : process(clk)
    begin
        if rising_edge(CLK) then
            if R = '1' then
                currentState <= start;
            else
                currentState <= nextState;
            end if;
        end if;
    end process setting_state;
    
    flow_chart : process(currentState, X, Y)
    begin

            case currentState is
                when start => 
                    B <= X;
                    Q <= Y;
                    A <= '0' & x"00";
                    C <= n + 1;
                when idle =>
                    if Q(0) = '1' and Q_1 = '0' then -- cazul '10'
                        A <= A - B;
                    elsif Q(0) = '0' and Q_1 = '1' then -- cazul '01'
                        A <= A + B;
                    end if;
                when shifting => Q_1 <= Q(0); Q <= A(0) & Q(n downto 1); A <= A(n) & A(n downto 1); C <= C - 1;
                when stop => P(2 * n + 1 downto n + 1) <= A; P (n downto 0) <= Q;
            end case;

    end process flow_chart;
    

end Behavioral;
