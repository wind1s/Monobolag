--------------------------------------------------------------------------------
-- PIX
-- Description:
--   Logic for muxing of tiles and sprites.


-- library declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;            -- basic IEEE library
use IEEE.NUMERIC_STD.ALL;               -- IEEE library for the unsigned type


-- entity
entity PIX is
	port (
		TILE_data       : in std_logic_vector(7 downto 0);
		Xpixel          : in unsigned(9 downto 0);
		Ypixel          : in unsigned(9 downto 0);
		sprite1X, sprite2X, sprite3X, sprite4X		: in unsigned(9 downto 0);
		sprite1Y, sprite2Y, sprite3Y, sprite4Y		: in unsigned(9 downto 0);
		sprite1_data    : in std_logic_vector(7 downto 0);
		sprite2_data    : in std_logic_vector(7 downto 0);
		sprite3_data    : in std_logic_vector(7 downto 0);
		sprite4_data    : in std_logic_vector(7 downto 0);
		SPRITE_ADDR     : out unsigned(7 downto 0);
		pixel           : out std_logic_vector(7 downto 0));
end PIX;

architecture Behavioral of PIX is
	-- Signals for which sprite will we output.
	signal sprite4_inbound : std_logic;
	signal sprite3_inbound : std_logic;
	signal sprite2_inbound : std_logic;
	signal sprite1_inbound : std_logic;
	
	-- Signals for saving the adress internally
	signal sprite4_addr	   : unsigned(14 downto 0);
	signal sprite3_addr	   : unsigned(14 downto 0);
	signal sprite2_addr	   : unsigned(14 downto 0);
	signal sprite1_addr	   : unsigned(14 downto 0);

	constant sprite_size : unsigned(4 downto 0) := to_unsigned(16, 5); -- Width and height of sprites
	constant transparent : std_logic_vector(7 downto 0) := x"03";
begin

	-- Check if we should output a sprite
	sprite4_inbound <= '1' when (Xpixel >= sprite4X and Xpixel < (sprite4X + sprite_size)) and (Ypixel >= sprite4Y and Ypixel < (sprite4Y + sprite_size)) else '0';
	sprite3_inbound <= '1' when (Xpixel >= sprite3X and Xpixel < (sprite3X + sprite_size)) and (Ypixel >= sprite3Y and Ypixel < (sprite3Y + sprite_size)) else '0';
	sprite2_inbound <= '1' when (Xpixel >= sprite2X and Xpixel < (sprite2X + sprite_size)) and (Ypixel >= sprite2Y and Ypixel < (sprite2Y + sprite_size)) else '0';
	sprite1_inbound <= '1' when (Xpixel >= sprite1X and Xpixel < (sprite1X + sprite_size)) and (Ypixel >= sprite1Y and Ypixel < (sprite1Y + sprite_size)) else '0';

	-- Make adress for sprite
	sprite4_addr <= sprite_size*(Ypixel-sprite4Y) + (Xpixel-sprite4X);
	sprite3_addr <= sprite_size*(Ypixel-sprite3Y) + (Xpixel-sprite3X);
	sprite2_addr <= sprite_size*(Ypixel-sprite2Y) + (Xpixel-sprite2X);
	sprite1_addr <= sprite_size*(Ypixel-sprite1Y) + (Xpixel-sprite1X);
	
	-- Send the correct addr to the SPRITE_ADDR bus.
	SPRITE_ADDR <= sprite4_addr(7 downto 0) when sprite4_inbound = '1' else
				   sprite3_addr(7 downto 0) when sprite3_inbound = '1' else
				   sprite2_addr(7 downto 0) when sprite2_inbound = '1' else
				   sprite1_addr(7 downto 0) when sprite1_inbound = '1' else
				   (others => '0');

	-- Output to the VGA-port
	pixel <= sprite4_data when (sprite4_inbound = '1') and (sprite4_data /= transparent) else
			 sprite3_data when (sprite3_inbound = '1') and (sprite3_data /= transparent) else
			 sprite2_data when (sprite2_inbound = '1') and (sprite2_data /= transparent) else
			 sprite1_data when (sprite1_inbound = '1') and (sprite1_data /= transparent) else 
			 TILE_data;

end Behavioral;