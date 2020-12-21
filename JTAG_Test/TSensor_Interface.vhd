library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TSensor_interface is
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
		data_in : in std_logic_vector(11 downto 0)
		);
end TSensor_Interface;

--Instructions:
--READTEMP 0001


architecture behav of TSensor_Interface is
signal data_reg : std_logic_vector(11 downto 0) := (others => '0');
signal shift_buffer : std_logic_vector(11 downto 0) := (others => '0');
signal read_temp : std_logic := '0';

begin
		read_temp <= not ir_in(3) and not ir_in(2) and not ir_in(1) and ir_in(0);
		
		process (tck) is
		variable i : integer range 0 to 11 := 0;
		begin
			if rising_edge(tck) then
				if read_temp = '1' then
					if cdr = '1' then
						data_reg <= "111111111111";
					elsif sdr = '1' then
						tdo <= data_reg(i);
						i := i + 1;
					end if;
				end if;
			end if;
		end process;
		
--		process (tck) is
--		begin
--			if rising_edge(tck) then
--				if read_temp = '1' then
--					tdo <= shift_buffer(0);
--				end if;
--			end if;
--		end process;
end behav;
	