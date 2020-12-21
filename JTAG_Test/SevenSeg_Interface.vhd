library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevenSeg_Interface is
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
		mux_ctrl : out std_logic_vector(1 downto 0);
		data_out : out std_logic_vector(15 downto 0)
		);
end SevenSeg_Interface;

--Instructions:
--CHSELECT 0001
--WRITEDATA 0010

architecture behav of SevenSeg_Interface is
signal temp_mux : std_logic_vector(1 downto 0) := (others => '0');
signal temp_data : std_logic_vector(15 downto 0) := (others => '0');
signal bypass_reg : std_logic := '0';
--signal bypass : std_logic := '0';
signal ch_select : std_logic := '0';
signal write_data : std_logic := '0';

begin
		ch_select <= not ir_in(3) and not ir_in(2) and not ir_in(1) and ir_in(0);	
		write_data <= not ir_in(3) and not ir_in(2) and ir_in(1) and not ir_in(0);
		
		process(tck) is
		begin
			if rising_edge(tck) then
				bypass_reg <= tdi;
			end if;
		end process;
		
		process (tck) is
		begin
			if rising_edge(tck) then
				if ch_select = '1' then
					if sdr = '1' then
						temp_mux <= tdi & temp_mux(1);
					elsif udr = '1' then
						mux_ctrl <= temp_mux;
					end if;
				elsif write_data = '1' then
					if sdr = '1' then
						temp_data <= tdi & temp_data(15 downto 1);
					elsif udr = '1' then
						data_out <= temp_data;
					end if;
				end if;
			end if;
		end process;
		
		process (tck) is
		begin
			if rising_edge(tck) then
				tdo <= bypass_reg;
			end if;
		end process;
		
end behav;
	