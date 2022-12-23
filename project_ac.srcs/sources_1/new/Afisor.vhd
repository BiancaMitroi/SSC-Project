library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_unsigned.all;

entity Afisor is
	port( input : in STD_LOGIC_VECTOR(15 downto 0);
		  clk : in STD_LOGIC;
		  cat : out STD_LOGIC_VECTOR(6 downto 0);
	  	  an : out STD_LOGIC_VECTOR(3 downto 0));
end entity;

architecture Behavioral of Afisor is
	signal sel: STD_LOGIC_VECTOR(1 downto 0) := "00"; -- selectie
	signal digit: STD_LOGIC_VECTOR(3 downto 0); -- un afisor
	signal clk_div: STD_LOGIC_VECTOR(15 downto 0); -- divizor de frecventa
	
begin

	process(clk) -- divizor de frecventa
    begin
        if rising_edge(clk) then
            clk_div <= clk_div + 1;
        end if;
    end process;
	sel <= clk_div(15 downto 14); -- selectie
	
	
	process(sel) -- MUX anod
        begin
           case sel is
                when "00" => an <= "1110";
                when "01" => an <= "1101";
                when "10" => an <= "1011";
                when others => an <= "0111";
            end case;
        end process;
	
	
	process(sel) -- MUX catod
	begin
		case sel is
			when "00" => digit <= input(3 downto 0);
			when "01" => digit <= input(7 downto 4);
			when "10" => digit <= input(11 downto 8);
			when others => digit <= input(15 downto 12);
		end case;
	end process;
	
	process(digit) -- HEX to 7SEG DCD
	begin
		case digit is
			when "0001" => cat  <= "1111001";
			when "0010" => cat  <= "0100100";
			when "0011" => cat  <= "0110000";
			when "0100" => cat  <= "0011001";
			when "0101" => cat  <= "0010010";
			when "0110" => cat  <= "0000010";
			when "0111" => cat  <= "1111000";
			when "1000" => cat  <= "0000000";
			when "1001" => cat  <= "0010000";
			when "1010" => cat  <= "0001000";
			when "1011" => cat  <= "0010000";
			when "1100" => cat  <= "1000110";
			when "1101" => cat  <= "0100001";
			when "1110" => cat  <= "0000110";
			when "1111" => cat  <= "0001110";
			when others => cat  <= "1000000";
		end case;
	end process;

end Behavioral;
