library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mux7Seg is -- Responsible for displaying numbers on a 7seg display
    Port (mux_ctrl : in STD_LOGIC_VECTOR(1 downto 0);
    	   data_in : in STD_LOGIC_VECTOR (15 downto 0); -- 4x4bit BCD input
			--dp_ctrl : in STD_LOGIC_VECTOR (3 downto 0);
         seven_seg : out STD_LOGIC_VECTOR (6 downto 0); -- 6:0 -> A:G leds 
			--dp : out STD_LOGIC_VECTOR(3 downto 0); 
         cathode : out STD_LOGIC_VECTOR(3 downto 0)); -- Controls which digit is displayed at the moment
end Mux7Seg;

architecture Behavioral of Mux7Seg is
	signal digit : STD_LOGIC_VECTOR (3 downto 0); -- Digit being sent to the 7seg
	
begin

	mux : process(mux_ctrl) begin -- 7seg multiplexing
		case mux_ctrl is
			when "00" =>
				digit <= Data_In(15 downto 12);
				cathode <= "1000";
			when "01" =>
				digit <= Data_In(11 downto 8);
				cathode <= "0100";
			when "10" =>
				digit <= Data_In(7 downto 4);
				cathode <= "0010";
			when "11" =>
				digit <= Data_In(3 downto 0);
				cathode <= "0001";
			when others =>
				digit <= "0000";
		end case;
	end process;
	
	BCD7Seg : process(digit) begin -- BCD to 7 segment conversion
		case digit is
			when "0000" =>
				seven_seg <= "1111110";
			when "0001" =>
				seven_seg <= "0110000"; 
			when "0010" =>
				seven_seg <= "1101101"; 
			when "0011" =>
				seven_seg <= "1111001"; 
			when "0100" =>
				seven_seg <= "0110011"; 
			when "0101" =>
				seven_seg <= "1011011"; 
			when "0110" =>
				seven_seg <= "1011111"; 
			when "0111" =>
				seven_seg <= "1110000"; 
			when "1000" =>
				seven_seg <= "1111111"; 
			when "1001" =>
				seven_seg <= "1111011"; 
			when "1010" =>
				seven_seg <= "1110111"; 
			when "1011" =>
				seven_seg <= "0011111"; 
			when "1100" =>
				seven_seg <= "1001110"; 
			when "1101" =>
				seven_seg <= "0111101"; 
			when "1110" =>
				seven_seg <= "1001111"; 
			when "1111" =>
				seven_seg <= "1000111"; 
			when others =>
				seven_seg <= "0000000"; 
		end case;
	end process;
end Behavioral;