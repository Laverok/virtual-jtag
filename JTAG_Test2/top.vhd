library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity top is 
	port (clk : in std_logic;
			seven_seg : out std_logic_vector(6 downto 0);
			cathode : out std_logic_vector(3 downto 0)
		);
	
end top;


architecture behav of top is

	component vJtag is
		port (
		tdi                : out std_logic;                                       -- jtag.tdi
		tdo                : in  std_logic                    := '0';             --     .tdo
		ir_in              : out std_logic_vector(3 downto 0);                    --     .ir_in
		--ir_out             : in  std_logic_vector(0 downto 0) := (others => '0'); --     .ir_out
		virtual_state_cdr  : out std_logic;                                       --     .virtual_state_cdr
		virtual_state_sdr  : out std_logic;                                       --     .virtual_state_sdr
		--virtual_state_e1dr : out std_logic;                                       --     .virtual_state_e1dr
		virtual_state_pdr  : out std_logic;                                       --     .virtual_state_pdr
		--virtual_state_e2dr : out std_logic;                                       --     .virtual_state_e2dr
		virtual_state_udr  : out std_logic;                                       --     .virtual_state_udr
		virtual_state_cir  : out std_logic;                                       --     .virtual_state_cir
		virtual_state_uir  : out std_logic;                                       --     .virtual_state_uir
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
	end component;
	
	component Mux7Seg is
		port (clk : in STD_LOGIC;
    	data_in : in STD_LOGIC_VECTOR (15 downto 0);
      seven_seg : out STD_LOGIC_VECTOR (6 downto 0); 
      cathode : out STD_LOGIC_VECTOR(3 downto 0)
		);
	end component;
	
	component prescaler is 
		generic(scale_factor : integer);
		port(clk_in : in STD_LOGIC;
		CE : in STD_LOGIC := '1';
		clk_out : out STD_LOGIC
		);
	end component;
	
	--Internal signals
	signal tck : std_logic;
	signal tdi : std_logic;
	signal ir_in : std_logic_vector(3 downto 0);
	signal tdo : std_logic;
	signal cdr : std_logic;
	signal sdr : std_logic;
	signal pdr : std_logic;
	signal udr : std_logic;
	signal cir : std_logic;
	signal uir : std_logic;
	signal clk_7seg : std_logic;
	signal seven_seg_in : std_logic_vector(15 downto 0);
	signal clk_1Hz : std_logic;
begin 
	
	JTAG : vJTAG
		port map(tck => tck, 
		tdi => tdi, 
		ir_in => ir_in, 
		tdo => tdo, 
		virtual_state_cdr => cdr,
		virtual_state_sdr => sdr, 
		virtual_state_pdr => pdr,
		virtual_state_udr => udr,
		virtual_state_cir => cir,
		virtual_state_uir => uir );
	
	JTAGInterface : vJTAG_Interface
		port map(tck => clk_1Hz, 
		tdi => tdi, 
		ir_in => ir_in, 
		tdo => tdo, 
		cdr => cdr,
		sdr => sdr,
		pdr => pdr,
		udr => udr,
		cir => cir,
		uir => uir,
		data_out => seven_seg_in);

	Display : Mux7Seg
		port map(clk => clk_7seg,
		data_in => seven_seg_in,
		seven_seg => seven_seg,
		cathode => cathode);
		
	Display_clk : prescaler
		generic map(scale_factor=>20000)
		port map(clk_in => clk,
		CE => open,
		clk_out => clk_7seg);
	
	One_hz_clk : prescaler
		generic map(scale_factor => 10000000)
		port map(clk_in => clk,
		CE => open,
		clk_out => clk_1Hz);
		
end behav;