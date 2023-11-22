--------------------------------------------------------------------------------
-- VGA lab
-- Version 1.0: 2015-12-16. Anders Nilsson
-- Version 2.0: 2023-01-12. Petter Kallstrom. Changelog: Splitting KBD_ENC into KBD_ENC + PRETENDED_CPU


-- library declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;            -- basic IEEE library
use IEEE.NUMERIC_STD.ALL;               -- IEEE library for the unsigned type
                                        -- and various arithmetic operations

-- entity
entity VGA is
	port (
		clk      : in std_logic;                         -- system clock
		rst      : in std_logic;                         -- reset
		Hsync    : out std_logic;                        -- horizontal sync
		Vsync    : out std_logic;                        -- vertical sync
		vgaRed   : out std_logic_vector(2 downto 0);     -- VGA red
		vgaGreen : out std_logic_vector(2 downto 0);     -- VGA green
		vgaBlue  : out std_logic_vector(2 downto 1);     -- VGA blue
		JA 		 : inout  std_logic_vector (7 downto 0));
end VGA;


-- architecture
architecture Behavioral of VGA is
	
	-- picture memory component
	component VIDEO_RAM
		port (
			clk        : in std_logic;
		-- port 1
			cs 				 : in std_logic;
			we1        : in std_logic;
			data_in1   : in std_logic_vector(7 downto 0);
			data_out1  : out std_logic_vector(7 downto 0);
			addr1      : in unsigned(12 downto 0);
			-- port 2
			data_out2  : out std_logic_vector(7 downto 0);
			addr2      : in unsigned(12 downto 0));
	end component;
	
	-- VGA motor component
	component VGA_MOTOR
		port (
			clk      : in std_logic;
			VR_data  : in std_logic_vector(7 downto 0);
			VR_addr  : out unsigned(12 downto 0);
			rst      : in std_logic;
			vgaRed   : out std_logic_vector(2 downto 0);
			vgaGreen : out std_logic_vector(2 downto 0);
			vgaBlue  : out std_logic_vector(2 downto 1);
			Hsync    : out std_logic;
			Vsync    : out std_logic;
			sprite1X, sprite2X, sprite3X, sprite4X : in unsigned(9 downto 0);
			sprite1Y, sprite2Y, sprite3Y, sprite4Y : in unsigned(9 downto 0));
	end component;

	component PmodKYPD_demo
		Port ( 
			clk : in  std_logic;
			rst : in std_logic;
			JA : inout  std_logic_vector (7 downto 0); --
			key_out : out std_logic_vector (3 downto 0));							   
	end component;
	
	-- intermediate signals between VIDEO_RAM and VGA_MOTOR
	signal data_out2_s : std_logic_vector(7 downto 0); -- data
	signal addr2_s     : unsigned(12 downto 0);        -- address

	-- Signals for testing
	signal data_out1_s : std_logic_vector(7 downto 0);
	signal data_in1_s  : std_logic_vector(7 downto 0);
	signal tile_cntr   : unsigned(7 downto 0);
	signal addr1_s	   : unsigned(12 downto 0) := "1111111111111";
	signal time_cntr   : unsigned(10 downto 0) := "00000000000";
	constant max_time  : unsigned(10 downto 0) := "10000000000";

	signal key: std_logic_vector (3 downto 0);
	signal sprite1X_s : unsigned(9 downto 0);
	--signal JA_s : std_logic_vector (7 downto 0);
	
begin

	-- Testing the VGA with different tiles.
	process(clk)
	begin
		if rising_edge(clk) then
			--if addr1_s > "0000001001111" then
			--	data_in1_s <= x"00";
			--	addr1_s <= addr1_s + 1;
			--else 	
			--	data_in1_s <= x"1E";
			--	addr1_s <= addr1_s + 1;
			--end if;

			-- test 2
			--addr1_s <= addr1_s + 1;
			--tile_cntr <= tile_cntr + 1;
			--data_in1_s <= std_logic_vector(tile_cntr);
			
			-- test 3
			addr1_s <= addr1_s + 1;

			if addr1_s = "0000000000000" then
				data_in1_s <= x"2B";
			elsif addr1_s = "0000000000001" then
				data_in1_s <= x"2C";
			elsif addr1_s = "0000001010000" then
				data_in1_s <= x"2D";
			elsif addr1_s = "0000001010001" then
				data_in1_s <= x"2E";
			else 
				data_in1_s <= x"29";
			end if;
		end if;
	end process;
	
	with key select
        sprite1X_s <= "0000010001" when "0001",
                      "0000000010" when "0010",
                      "0000100011" when "0011",
                      "0000000100" when "0100",
                      "0000000101" when "0101",
                      "0000000110" when "0110",
                      "0000000111" when "0111",
                      "0000001000" when "1000",
                      "0000001001" when "1001",
                      "0000001010" when "1010",
                      "0000001011" when "1011",
                      "0000001100" when "1100",
                      "0000001101" when "1101",
                      "0000001110" when "1110",
											"0000101111" when "1111",
											(others => '0') when others;
											

	-- picture memory component connection
	U1 : VIDEO_RAM port map(clk=>clk, cs=>'1', we1=>'1', data_in1=>data_in1_s, data_out1=>data_out1_s, addr1=>addr1_s, data_out2=>data_out2_s, addr2=>addr2_s);
	
	-- VGA motor component connection
	U2 : VGA_MOTOR port map(clk=>clk, rst=>rst, VR_data=>data_out2_s, VR_addr=>addr2_s, vgaRed=>vgaRed, vgaGreen=>vgaGreen, vgaBlue=>vgaBlue, Hsync=>Hsync, Vsync=>Vsync, sprite1X=>sprite1X_s, sprite2X=>"0000001000",sprite3X=>"0000010000",sprite4X=>"0000011000",sprite1Y=>"0000010000",sprite2Y=>"0000100000",sprite3Y=>"0000110000",sprite4Y=>"0001000000");
	
	U3 : PmodKYPD_demo port map(clk=>clk, rst=>rst, key_out=>key, JA=>JA);

end Behavioral;

