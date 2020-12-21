library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity top is 
	port (clk : in std_logic;
			seven_seg : out std_logic_vector(6 downto 0);
			--seven_seg_dp : out std_logic;
			cathode : out std_logic_vector(3 downto 0)
			);
end top;


architecture behav of top is

	component vJTAG0 is
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
		tck                : out std_logic                                        --  tck.clk
	);
	end component;
	
	component VJTAG1 is
	port (
		tdi                : out std_logic;                                       -- jtag.tdi
		tdo                : in  std_logic                    := '0';             --     .tdo
		ir_in              : out std_logic_vector(3 downto 0);                    --     .ir_in
		--ir_out             : in  std_logic_vector(3 downto 0) := (others => '0'); --     .ir_out
		virtual_state_cdr  : out std_logic;                                       --     .virtual_state_cdr
		virtual_state_sdr  : out std_logic;                                       --     .virtual_state_sdr
		--virtual_state_e1dr : out std_logic;                                       --     .virtual_state_e1dr
		virtual_state_pdr  : out std_logic;                                       --     .virtual_state_pdr
		--virtual_state_e2dr : out std_logic;                                       --     .virtual_state_e2dr
		virtual_state_udr  : out std_logic;                                       --     .virtual_state_udr
		virtual_state_cir  : out std_logic;                                       --     .virtual_state_cir
		virtual_state_uir  : out std_logic;                                       --     .virtual_state_uir
		tck                : out std_logic                                        --  tck.clk
	);
	end component;

	component SevenSeg_Interface is
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
	end component;
	
	component TSensor_interface is
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
	end component;

	
	component Mux7Seg is
		port (mux_ctrl : in STD_LOGIC_VECTOR(1 downto 0);
    	data_in : in STD_LOGIC_VECTOR (15 downto 0);
      seven_seg : out STD_LOGIC_VECTOR (6 downto 0); 
      cathode : out STD_LOGIC_VECTOR(3 downto 0)
		);
	end component;
	
	component ADC_Interface is
		port (clk : in std_logic;
		data_out : out std_logic_vector(11 downto 0)
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
	signal tck_7seg : std_logic;
	signal tdi_7seg : std_logic;
	signal ir_in_7seg : std_logic_vector(3 downto 0);
	signal tdo_7seg : std_logic;
	signal cdr_7seg : std_logic;
	signal sdr_7seg : std_logic;
	signal pdr_7seg : std_logic;
	signal udr_7seg : std_logic;
	signal cir_7seg : std_logic;
	signal uir_7seg : std_logic;
	signal clk_7seg : std_logic;
	signal mux_ctrl : std_logic_vector(1 downto 0);
	signal seven_seg_in : std_logic_vector(15 downto 0);
	signal tck_T : std_logic;
	signal tdi_T : std_logic;
	signal ir_in_T : std_logic_vector(3 downto 0);
	signal tdo_T : std_logic;
	signal cdr_T : std_logic;
	signal sdr_T : std_logic;
	signal pdr_T : std_logic;
	signal udr_T : std_logic;
	signal cir_T : std_logic;
	signal uir_T : std_logic;
	signal ADC_data : std_logic_vector(11 downto 0);
	--signal clk_1Hz : std_logic;
	
begin 
	
	JTAG0 : vJTAG0
		port map(tck => tck_7seg, 
		tdi => tdi_7seg, 
		ir_in => ir_in_7seg, 
		tdo => tdo_7seg, 
		virtual_state_cdr => cdr_7seg,
		virtual_state_sdr => sdr_7seg, 
		virtual_state_pdr => pdr_7seg,
		virtual_state_udr => udr_7seg,
		virtual_state_cir => cir_7seg,
		virtual_state_uir => uir_7seg);
		
	JTAG1 : vJTAG1
		port map(tck => tck_T, 
		tdi => tdi_T, 
		ir_in => ir_in_T, 
		tdo => tdo_T, 
		virtual_state_cdr => cdr_T,
		virtual_state_sdr => sdr_T, 
		virtual_state_pdr => pdr_T,
		virtual_state_udr => udr_T,
		virtual_state_cir => cir_T,
		virtual_state_uir => uir_T);
		
	SevenSegI : SevenSeg_Interface
		port map(tck => tck_7seg, 
		tdi => tdi_7seg, 
		ir_in => ir_in_7seg, 
		tdo => tdo_7seg, 
		cdr => cdr_7seg,
		sdr => sdr_7seg,
		pdr => pdr_7seg,
		udr => udr_7seg,
		cir => cir_7seg,
		uir => uir_7seg,
		mux_ctrl => mux_ctrl,
		data_out => seven_seg_in);
	
	TSensorI : TSensor_Interface
		port map(tck => tck_T, 
			tdi => tdi_T, 
			ir_in => ir_in_T, 
			tdo => tdo_T, 
			cdr => cdr_T,
			sdr => sdr_T,
			pdr => pdr_T,
			udr => udr_T,
			cir => cir_T,
			uir => uir_T,
			data_in => ADC_data);
	
	ADCI : ADC_Interface
		port map(clk => clk,
		data_out => ADC_data);
		
	Display : Mux7Seg
		port map(mux_ctrl => mux_ctrl,
		data_in => seven_seg_in,
		seven_seg => seven_seg,
		cathode => cathode);
		
end behav;