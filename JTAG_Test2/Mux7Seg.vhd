library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mux7Seg is -- Responsible for displaying numbers on a 7seg display
    Port ( clk : in STD_LOGIC;
    	   data_in : in STD_LOGIC_VECTOR (15 downto 0); -- 4x4bit BCD input
         seven_seg : out STD_LOGIC_VECTOR (6 downto 0); -- 6:0 -> A:G leds 
         cathode : out STD_LOGIC_VECTOR(3 downto 0)); -- Controls which digit is displayed at the moment
end Mux7Seg;

architecture Behavioral of Mux7Seg is
	signal ctrl : STD_LOGIC_VECTOR(1 downto 0) := "00"; -- Used for multiplexing data on 7seg
	signal digit : STD_LOGIC_VECTOR (3 downto 0); -- Digit being sent to the 7seg
	
begin

	mux : process(clk) begin -- 7seg multiplexing
		if (rising_edge(clk)) then
		case ctrl is
			when "11" =>
				digit <= Data_In(15 downto 12);
				cathode <= "1000";
			when "10" =>
				digit <= Data_In(11 downto 8);
				cathode <= "0100";
			when "01" =>
				digit <= Data_In(7 downto 4);
				cathode <= "0010";
			when "00" =>
				digit <= Data_In(3 downto 0);
				cathode <= "0001";
			when others =>
				digit <= "0000";
		end case;
		end if;	
	end process;
	
	ctrl_inc : process(clk) begin -- Increments the multiplexer signal on clock's rising edge
		if (rising_edge(clk)) then
			if (ctrl = "11") then
				ctrl <= "00";
			else
				ctrl <= ctrl + 1;	
			end if;
		end if;	
	
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
			when others =>
				seven_seg <= "0000000"; 
		end case;
	end process;
end Behavioral;