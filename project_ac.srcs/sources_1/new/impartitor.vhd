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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity impartitor is
    Generic( n : natural := 8);
    Port (
        X : in std_logic_vector(n - 1 downto 0); -- n biti
        Y : in std_logic_vector(n - 1 downto 0); -- n biti 
        Cat : out std_logic_vector(n - 1 downto 0); --  n biti  
        Rest : out std_logic_vector(n downto 0); --  n biti  
        R, clk : in std_logic;
        gata : out std_logic
    );
end impartitor;

architecture Behavioral of impartitor is

-- registers, Q(-1) and C
signal B    : std_logic_vector(n - 1 downto 0) := x"00";
signal A    : std_logic_vector(n downto 0) := '0' & x"00";
signal Q    : std_logic_vector(n - 1 downto 0) := x"00";
signal BS, gat  : std_logic := '0';
signal C    : natural := n;

-- codificare stari
-- type STATE is (idle, intermediate, intermediate2, renew, stop);
type STATE is (start, idle, intermediate, intermediate2, renew, stop);
-- signal currentState, nextState : STATE;
signal currentState : STATE := start;

begin

--    START_STATE: process(clk)
--    begin
--        if rising_edge(clk) then
--            if r = '1' then
--                    B <= Y;
--                    Q <= X;
--                    A <= '0' & x"00";
--                    C <= n;
--                    BS <= '0';
--                    currentState <= idle;
--            end if;
--        end if;
--    end process;
--    IDLE_STATE: process(clk)
--    begin
--        if rising_edge(clk) then
--            if r = '0' then
--                if currentState = idle then
--                    A <= A(n - 1 downto 0) & Q(n - 1);
--                    Q <= Q(n - 2 downto 0) & '0';
--                    currentState <= intermediate;
--                end if;
--            end if;
--        end if;
--    end process;
--    INTERMEDIATE_STATE: process(clk)
--    begin
--        if rising_edge(clk) then
--            if r = '0' then
--                if currentState = intermediate then
--                    if BS = '1' then
--                        A <= A + B;
--                    else
--                        A <= A - B;
--                    end if;
--                    currentState <= intermediate2;
--                end if;
--            end if;
--        end if;
--    end process;
--    INTERMEDIATE2_STATE: process(clk)
--    begin
--        if rising_edge(clk) then
--            if r = '0' then
--                if currentState = intermediate2 then
--                    Q(0) <= not A(n);
--                    BS <= A(n);
--                    C <= C - 1;
--                    if C > 1 then
--                        currentState <= idle;
--                    else
--                        currentState <= renew;
--                    end if;
--                end if;
--            end if;
--        end if;
--    end process;
--    RENEW_STATE: process(clk)
--    begin
--        if rising_edge(clk) then
--            if r = '0' then
--                if currentState = renew then
--                    if BS = '1' then
--                        A <= A + B;
--                    end if;
--                    currentState <= stop;
--                end if;
--            end if;
--        end if;
--    end process;
--    STOP_STATE: process(clk)
--    begin
--        if rising_edge(clk) then
--            if r = '0' then
--                if currentState = stop then
--                    currentState <= stop;
--                end if;
--            end if;
--        end if;
--    end process;
    
--    next_state : process(currentState, X, Y)
--    begin

--            case currentState is
--                when start => 
--                    nextState <= idle;
--                when idle =>
--                    nextState <= intermediate;
--                when intermediate =>
--                    nextState <= intermediate2;
--                when intermediate2 =>
--                    if C > 1 then
--                        nextState <= idle;
--                    else
--                        nextState <= renew;
--                    end if;
--                when renew =>
--                    nextState <= stop;
--                when stop => nextState <= stop;
--            end case;

--    end process next_state;
    
--    setting_state : process(clk)
--    begin
--        if rising_edge(CLK) then
--            if R = '1' then
--                currentState <= start;
--            else
--                currentState <= nextState;
--            end if;
--        end if;
--    end process setting_state;
    
    flow_chart : process(CLK)
    begin
        if rising_edge(clk) then
            if R = '1' then
                currentState <= start;
            else
                case currentState is
                when start => 
                    B <= Y;
                    Q <= X;
                    A <= '0' & x"00";
                    C <= n;
                    BS <= '0';
                    gata <= '0';
                    currentState <= idle;
                when idle =>
                    A <= A(n - 1 downto 0) & Q(n - 1);
                    Q <= Q(n - 2 downto 0) & '0';
                    currentState <= intermediate;
                when intermediate =>
                    if BS = '1' then
                        A <= A + B;
                    else
                        A <= A - B;
                    end if;
                    currentState <= intermediate2;
                when intermediate2 =>
                    Q(0) <= not A(n);
                    BS <= A(n);
                    C <= C - 1;
                    if C > 1 then
                        currentState <= idle;
                    else
                        currentState <= renew;
                    end if;
                when renew => 
                    if BS = '1' then
                        A <= A + B;
                    end if;
                    currentState <= stop;
                when stop => currentState <= stop;
            end case;
            end if;
        end if;
            
    end process flow_chart;
    Cat <= Q; Rest <= A;
end Behavioral;
