library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ADC_Interface is 
	port (clk : in std_logic;
			data_out : out std_logic_vector(11 downto 0)
			);
end ADC_Interface;

architecture behav of ADC_Interface is

	component ADC is
		port (clk_clk                : in  std_logic                     := '0';             --      clk.clk
				command_valid          : in  std_logic                     := '0';             --  command.valid
				command_channel        : in  std_logic_vector(4 downto 0)  := (others => '0'); --         .channel
				command_startofpacket  : in  std_logic                     := '0';             --         .startofpacket
				command_endofpacket    : in  std_logic                     := '0';             --         .endofpacket
				command_ready          : out std_logic;                                        --         .ready
				reset_reset_n          : in  std_logic                     := '0';             --    reset.reset_n
				response_valid         : out std_logic;                                        -- response.valid
				response_channel       : out std_logic_vector(4 downto 0);                     --         .channel
				response_data          : out std_logic_vector(11 downto 0);                    --         .data
				response_startofpacket : out std_logic;                                        --         .startofpacket
				response_endofpacket   : out std_logic    
		);
	end component;
	
	--Internal signals
	signal clk_clk : std_logic;             
	signal command_valid : std_logic;            
	signal command_channel : std_logic_vector(4 downto 0);
	signal command_startofpacket : std_logic;
	signal command_endofpacket : std_logic;
	signal command_ready : std_logic;
	signal reset_reset_n : std_logic;
	signal response_valid : std_logic;
	signal response_channel : std_logic_vector(4 downto 0);                     
	signal response_data : std_logic_vector(11 downto 0);                    
	signal response_startofpacket : std_logic;                                      
	signal response_endofpacket : std_logic;    
	
begin	
	
	ADC0 : ADC
		port map(clk_clk => clk,        
		command_valid => command_valid,           
		command_channel => command_channel,
		command_startofpacket => command_startofpacket,
		command_endofpacket => command_endofpacket,
		command_ready => command_ready,
		reset_reset_n => reset_reset_n, 
		response_valid => response_valid,
		response_channel => response_channel,                
		response_data => response_data,                   
		response_startofpacket => response_startofpacket,                                    
		response_endofpacket => response_endofpacket);

	command_valid <= '1';
	command_channel <= "01111";
	command_startofpacket <= '1';
	command_ready <= '1';
	reset_reset_n <= '1';
	
	process(clk)
		begin
			if rising_edge(clk) and response_valid = '1' then
				data_out <= response_data;
			end if;
	end process;
	
end behav;
