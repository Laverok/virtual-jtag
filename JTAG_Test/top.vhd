library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity top is 
	port (leds : out std_logic_vector(3 downto 0)
		);
	
end top;


architecture behav of top is

	component vJtag is
		port (
		tdi                : out std_logic;                                       -- jtag.tdi
		tdo                : in  std_logic                    := '0';             --     .tdo
		ir_in              : out std_logic_vector(0 downto 0);                    --     .ir_in
		--ir_out             : in  std_logic_vector(0 downto 0) := (others => '0'); --     .ir_out
		--virtual_state_cdr  : out std_logic;                                       --     .virtual_state_cdr
		virtual_state_sdr  : out std_logic;                                       --     .virtual_state_sdr
		--virtual_state_e1dr : out std_logic;                                       --     .virtual_state_e1dr
		--virtual_state_pdr  : out std_logic;                                       --     .virtual_state_pdr
		--virtual_state_e2dr : out std_logic;                                       --     .virtual_state_e2dr
		virtual_state_udr  : out std_logic;                                       --     .virtual_state_udr
		--virtual_state_cir  : out std_logic;                                       --     .virtual_state_cir
		--virtual_state_uir  : out std_logic;                                       --     .virtual_state_uir
		--tms                : out std_logic;                                       --     .tms
		--jtag_state_tlr     : out std_logic;                                       --     .jtag_state_tlr
		--jtag_state_rti     : out std_logic;                                       --     .jtag_state_rti
		--jtag_state_sdrs    : out std_logic;                                       --     .jtag_state_sdrs
		--jtag_state_cdr     : out std_logic;                                       --     .jtag_state_cdr
		--jtag_state_sdr     : out std_logic;                                       --     .jtag_state_sdr
		--jtag_state_e1dr    : out std_logic;                                       --     .jtag_state_e1dr
		--jtag_state_pdr     : out std_logic;                                       --     .jtag_state_pdr
		--jtag_state_e2dr    : out std_logic;                                       --     .jtag_state_e2dr
		--jtag_state_udr     : out std_logic;                                       --     .jtag_state_udr
		--jtag_state_sirs    : out std_logic;                                       --     .jtag_state_sirs
		--jtag_state_cir     : out std_logic;                                       --     .jtag_state_cir
		--jtag_state_sir     : out std_logic;                                       --     .jtag_state_sir
		--jtag_state_e1ir    : out std_logic;                                       --     .jtag_state_e1ir
		--jtag_state_pir     : out std_logic;                                       --     .jtag_state_pir
		--jtag_state_e2ir    : out std_logic;                                       --     .jtag_state_e2ir
		--jtag_state_uir     : out std_logic;                                       --     .jtag_state_uir
		tck                : out std_logic                                        --  tck.clk
	);
	end component;
	
	component vJTAG_Interface is
		port(tck : in std_logic;
		tdi : in std_logic;
		ir_in : in std_logic;
		--cdr : in std_logic;
		sdr : in std_logic;
		--e1dr : in std_logic;
		--pdr : in std_logic;
		udr : in std_logic;
		--cir : in std_logic;
		--uir : in std_logic;
		tdo : out std_logic;
		leds : out std_logic_vector(3 downto 0)
		);
	end component;
	
	signal tck : std_logic;
	signal tdi : std_logic;
	signal ir_in : std_logic_vector(0 downto 0);
	signal tdo : std_logic;
	signal sdr : std_logic;
	signal udr : std_logic;
	
begin 
	
	JTAG : vJTAG
		port map(tck=>tck, tdi=>tdi, ir_in=>ir_in, tdo=>tdo, virtual_state_sdr=>sdr, virtual_state_udr=>udr);
	
	JTAGInterface : vJTAG_Interface
		port map(tck=>tck, tdi=>tdi, ir_in=>ir_in(0), tdo=>tdo, sdr=>sdr, udr=>udr, leds=>leds);

	
end behav;