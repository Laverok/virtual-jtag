library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 7seg version
entity vJTAG_Interface is
	port(tck : in std_logic;
		tdi : in std_logic;
		ir_in : in std_logic_vector(3 downto 0);
		cdr : in std_logic;
		sdr : in std_logic;
		--e1dr : in std_logic;
		pdr : in std_logic;
		udr : in std_logic;
		cir : in std_logic;
		uir : in std_logic;
		tdo : out std_logic;
		data_out : out std_logic_vector(15 downto 0)
		);
end vJTAG_Interface;

architecture behav of vJTAG_Interface is
signal shift_buffer : std_logic_vector(15 downto 0) := (others => '0');

--Instructions:
--BYPASS - 1111

begin
		process (tck) is
		begin
			if rising_edge(tck) then
				if sdr = '1' then
					shift_buffer <= tdi & shift_buffer(15 downto 1);
				elsif udr = '1' then
					data_out <= shift_buffer;
				end if;
			end if;
		end process;
		
--		process(tdi, shift_buffer) is
--		begin
--			if ir_in = "1111" then
--				tdo <= '1';
--			elsif ir_in = "1100" then
--				tdo <= shift_buffer(0);
--			end if;
--		end process;
		
	end behav;
	