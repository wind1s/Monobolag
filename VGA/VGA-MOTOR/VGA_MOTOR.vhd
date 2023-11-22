--------------------------------------------------------------------------------
-- VGA MOTOR
-- Version 1.1: 2016-02-16, Anders Nilsson
-- Version 1.2: 2023-01-11, Petter Kallstrom. Changelog: Corrected a pipeline mistake.


-- library declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;            -- basic IEEE library
use IEEE.NUMERIC_STD.ALL;               -- IEEE library for the unsigned type


-- entity
entity VGA_MOTOR is
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
end VGA_MOTOR;


-- architecture
architecture Behavioral of VGA_MOTOR is
	
	signal Xpixel1, Xpixel2, Xpixel3 : unsigned(9 downto 0); -- Horizontal pixel counter, and its pipelined version
	signal Ypixel1, Ypixel2, Ypixel3 : unsigned(9 downto 0); -- Vertical pixel counter         
	signal Clock  : std_logic;              -- Clock to generate 25 MHz signal       
	
	signal TILE_addr  : unsigned(13 downto 0);       -- address for TILE_ROM
	signal TILE_data : std_logic_vector(7 downto 0); -- data from TILE_ROM.

	signal SPRITE_ADDR  : unsigned(7 downto 0);       -- address for SPRITE_ROM
	signal sprite1_data : std_logic_vector(7 downto 0); -- data from SPRITE_ROM.
	signal sprite2_data : std_logic_vector(7 downto 0); -- data from SPRITE_ROM.
	signal sprite3_data : std_logic_vector(7 downto 0); -- data from SPRITE_ROM.
	signal sprite4_data : std_logic_vector(7 downto 0); -- data from SPRITE_ROM.
	signal pixel : std_logic_vector(7 downto 0);
	
	signal blank1, blank2, blank : std_logic; -- blanking signal, with delayed versions
	signal Hsync1, Hsync2 : std_logic;
	signal Vsync1, Vsync2 : std_logic;
	
	-- Tile rom:
	component TILE_ROM is
		port (
			clk      : in std_logic;
			addr     : in unsigned(13 downto 0);
			data     : out std_logic_vector(7 downto 0));
	end component;

	-- Sprite rom:
	component SPRITES is
		port (
			clk              : in std_logic;
			SPRITE_ADDR      : in unsigned(7 downto 0);
			sprite1_data     : out std_logic_vector(7 downto 0);
			sprite2_data     : out std_logic_vector(7 downto 0);
			sprite3_data     : out std_logic_vector(7 downto 0);
			sprite4_data     : out std_logic_vector(7 downto 0));
	end component;

	-- PIX - Pixel logic:
	component PIX is
		port (
			TILE_data       : in std_logic_vector(7 downto 0);
			Xpixel         : in unsigned(9 downto 0);
			Ypixel         : in unsigned(9 downto 0);
			sprite1X, sprite2X, sprite3X, sprite4X		: in unsigned(9 downto 0);
			sprite1Y, sprite2Y, sprite3Y, sprite4Y		: in unsigned(9 downto 0);
			sprite1_data    : in std_logic_vector(7 downto 0);
			sprite2_data    : in std_logic_vector(7 downto 0);
			sprite3_data    : in std_logic_vector(7 downto 0);
			sprite4_data    : in std_logic_vector(7 downto 0);
			SPRITE_ADDR     : out unsigned(7 downto 0);
			pixel           : out std_logic_vector(7 downto 0));
	end component;

  constant Vsync_s : unsigned(9 downto 0) := to_unsigned(521, 10);
  constant Vsync_disp : unsigned(8 downto 0) := to_unsigned(480, 9);
  constant Vsync_pw : unsigned(1 downto 0) := to_unsigned(2, 2);
  constant Vsync_fp : unsigned(3 downto 0) := to_unsigned(10, 4);

  constant Hsync_s : unsigned(9 downto 0) := to_unsigned(800, 10);
  constant Hsync_disp : unsigned(9 downto 0) := to_unsigned(640, 10);
  constant Hsync_pw : unsigned(6 downto 0) := to_unsigned(96, 7);
  constant Hsync_fp : unsigned(4 downto 0) := to_unsigned(16, 5);
	
begin
	
	-- Clock divisor
	process(clk)
	begin
		if rising_edge(clk) then
      Clock <= not Clock;
		end if;
  end process;
	
	-- Horizontal pixel counter
	-- *******************************
	-- *                             *
	-- *  VHDL for:                  *
	-- *  Xpixel1                    *
	-- *                             *
	-- *******************************
	process(clk)
	begin
		if rising_edge(clk) then
			if rst='1' then
				Xpixel1 <= (others => '0');
			elsif Clock='1' then
				if Xpixel1 = Hsync_s then
					Xpixel1 <= (others => '0');
				else
					Xpixel1 <= Xpixel1 + 1;
				end if;
			end if;
		end if;
	end process;

	-- Horizontal sync
	-- *******************************
	-- *                             *
	-- *  VHDL for:                  *
	-- *  Hsync1                     *
	-- *                             *
	-- *******************************
  Hsync1 <= '0' when ((Xpixel1 >= (Hsync_disp + Hsync_fp)) and (Xpixel1 < (Hsync_disp + Hsync_fp + Hsync_pw))) else '1';

	-- Vertical pixel counter
	-- *******************************
	-- *                             *
	-- *  VHDL for:                  *
	-- *  Ypixel1                    *
	-- *                             *
	-- *******************************
	process(clk)
	begin
		if rising_edge(clk) then
			if rst='1' then
				Ypixel1 <= (others => '0');
			elsif (Clock='1') and (Xpixel1 = Hsync_s) then
       			if Ypixel1 = Vsync_s then
					Ypixel1 <= (others => '0');
				else
					Ypixel1 <= Ypixel1 + 1;
				end if;
			end if;
		end if;
	end process;

	-- Vertical Sync
	-- *******************************
	-- *                             *
	-- *  VHDL for:                  *
	-- *  Vsync1                     *
	-- *                             *
	-- *******************************
  Vsync1 <= '0' when ((Ypixel1 >= (Vsync_disp + Vsync_fp)) and (Ypixel1 < (Vsync_disp + Vsync_fp + Vsync_pw))) else '1';

	-- Video blanking signal
	-- *******************************
	-- *                             *
	-- *  VHDL for:                  *
	-- *  Blank1                     *
	-- *                             *
	-- *******************************
  blank1 <= '1' when ((Xpixel1 >= Hsync_disp) or (Ypixel1 >= Vsync_disp)) else '0';
        
	


	-- Video ram address composite
	VR_addr <= to_unsigned(80, 7) * Ypixel1(8 downto 3) + Xpixel1(9 downto 3); -- Maybe update
	
	-- VIDEO_RAM:
	-- data <= mem(addr), with one clock cycle delay
	
	process(clk)
	begin
		if rising_edge(clk) then
			blank2 <= blank1;
			Hsync2 <= Hsync1;
			Vsync2 <= Vsync1;
			Xpixel2 <= Xpixel1;
			Ypixel2 <= Ypixel1;
		end if;
	end process;
	
	-- Character rom address:
	TILE_addr <= unsigned(VR_data(7 downto 0)) & Ypixel2(2 downto 0) & Xpixel2(2 downto 0);

	process(clk)
	begin
		if rising_edge(clk) then
			Hsync <= Hsync2;
			Vsync <= Vsync2;
			blank <= blank2;
			Xpixel3 <= Xpixel2;
			Ypixel3 <= Ypixel2;
		end if;
	end process;
	
	U_TILE : TILE_ROM port map (clk=>clk, addr=>TILE_addr, data=>TILE_data); -- one clock cycle delay.

	U_PIX : PIX port map (TILE_data=>TILE_data, Xpixel=>Xpixel3, Ypixel=>Ypixel3, sprite1X=>sprite1X, 
						sprite2X=>sprite2X, sprite3X=>sprite3X, sprite4X=>sprite4X, sprite1Y=>sprite1Y, 
						sprite2Y=>sprite2Y, sprite3Y=>sprite3Y, sprite4Y=>sprite4Y,
						sprite1_data=>sprite1_data, sprite2_data=>sprite2_data, sprite3_data=>sprite3_data,
						sprite4_data=>sprite4_data, SPRITE_ADDR=>SPRITE_ADDR, pixel=>pixel);

	U_SPRITE : SPRITES port map (clk=>clk, SPRITE_ADDR=>SPRITE_ADDR, sprite1_data=>sprite1_data,
							   sprite2_data=>sprite2_data, sprite3_data=>sprite3_data, sprite4_data=>sprite4_data); -- one clock cycle delay.


	-- VGA generation
	vgaRed(2)   <= pixel(7) when blank = '0' else '0';
	vgaRed(1)   <= pixel(6) when blank = '0' else '0';
	vgaRed(0)   <= pixel(5) when blank = '0' else '0';
	vgaGreen(2) <= pixel(4) when blank = '0' else '0';
	vgaGreen(1) <= pixel(3) when blank = '0' else '0';
	vgaGreen(0) <= pixel(2) when blank = '0' else '0';
	vgaBlue(2)  <= pixel(1) when blank = '0' else '0';
	vgaBlue(1)  <= pixel(0) when blank = '0' else '0';

	-- Här efter ska vi lägga till den stora vippan.

end Behavioral;

