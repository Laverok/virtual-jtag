library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vJTAG_Interface is
	port(tck : in std_logic;
		tdi : in std_logic;
		ir_in : in std_logic;
		cdr : in std_logic;
		sdr : in std_logic;
		e1dr : in std_logic;
		pdr : in std_logic;
		udr : in std_logic;
		cir : in std_logic;
		uir : in std_logic;
		tdo : out std_logic;
		leds : out std_logic_vector(3 downto 0)
		);
end vJTAG_Interface;

architecture behav of vJTAG_Interface is
signal shift_buffer : std_logic_vector(3 downto 0) := "0000";

begin
		process (tck) is
		begin
			if rising_edge(tck) then
				if sdr = '1' then
					shift_buffer <= tdi & shift_buffer(3 downto 1);
				elsif udr = '1' then
					leds <= shift_buffer;
				end if;
			end if;
		end process;
		
	end behav;