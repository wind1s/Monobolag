--------------------------------------------------------------------------------
-- SPRITE_ROM
-- Description:
-- * ROM for SPRITES


-- library declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;            -- basic IEEE library
use IEEE.NUMERIC_STD.ALL;               -- IEEE library for the unsigned type


-- entity
entity SPRITES is
	port (
		clk              : in std_logic;
		SPRITE_ADDR      : in unsigned(7 downto 0);
		sprite1_data     : out std_logic_vector(7 downto 0); -- Is this correct? 
		sprite2_data     : out std_logic_vector(7 downto 0);
		sprite3_data     : out std_logic_vector(7 downto 0);
		sprite4_data     : out std_logic_vector(7 downto 0));

end SPRITES;


-- architecture
architecture Behavioral of SPRITES is
	type rom_t is array (0 to 255) of std_logic_vector(7 downto 0);
	signal SPRITE1_ROM : rom_t;
	signal SPRITE2_ROM : rom_t;
	signal SPRITE3_ROM : rom_t;
	signal SPRITE4_ROM : rom_t;

begin

	-- Read from the ROM:
	process(clk)
	begin
		if rising_edge(clk) then
			sprite1_data <= SPRITE1_ROM(to_integer(SPRITE_ADDR));
			sprite2_data <= SPRITE2_ROM(to_integer(SPRITE_ADDR));
			sprite3_data <= SPRITE3_ROM(to_integer(SPRITE_ADDR));
			sprite4_data <= SPRITE4_ROM(to_integer(SPRITE_ADDR));
		end if;
	end process;
	
	SPRITE1_ROM <= (
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",  -- sprite1
		x"03",x"03",x"03",x"03",x"03",x"FC",x"FC",x"FC",x"FC",x"FC",x"03",x"03",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"03",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"03",x"03",x"03",x"03",
		x"03",x"03",x"FC",x"00",x"00",x"00",x"FC",x"FC",x"FC",x"00",x"00",x"00",x"FC",x"03",x"03",x"03",
		x"03",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"03",x"03",
		x"03",x"FC",x"FC",x"00",x"00",x"00",x"FC",x"FC",x"FC",x"00",x"00",x"00",x"FC",x"FC",x"03",x"03",
		x"03",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"03",x"03",
		x"03",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"03",x"03",
		x"03",x"FC",x"FC",x"00",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"00",x"FC",x"FC",x"03",x"03",
		x"03",x"03",x"FC",x"FC",x"00",x"FC",x"FC",x"FC",x"FC",x"FC",x"00",x"FC",x"FC",x"03",x"03",x"03",
		x"03",x"03",x"03",x"FC",x"FC",x"00",x"00",x"00",x"00",x"00",x"FC",x"FC",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"FC",x"03",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"03",x"FC",x"FC",x"FC",x"FC",x"FC",x"03",x"03",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03"
	);

    SPRITE2_ROM <= (
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",  -- sprite2
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"03",x"03",x"03",
		x"03",x"03",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"03",x"03",
		x"03",x"03",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"03",x"03",
		x"03",x"03",x"E2",x"E2",x"E2",x"E2",x"E2",x"FC",x"FC",x"E2",x"E2",x"E2",x"E2",x"E2",x"03",x"03",
		x"03",x"03",x"E2",x"E2",x"E2",x"E2",x"FC",x"FC",x"FC",x"FC",x"E2",x"E2",x"E2",x"E2",x"03",x"03",
		x"03",x"03",x"E2",x"E2",x"E2",x"E2",x"FC",x"FC",x"FC",x"FC",x"E2",x"E2",x"E2",x"E2",x"03",x"03",
		x"03",x"03",x"E2",x"E2",x"E2",x"E2",x"E2",x"FC",x"FC",x"E2",x"E2",x"E2",x"E2",x"E2",x"03",x"03",
		x"03",x"03",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"03",x"03",
		x"03",x"03",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"03",x"03",
		x"03",x"03",x"03",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"E2",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03"
	);

    SPRITE3_ROM <= (
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",  -- sprite3
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"03",x"03",x"03",
		x"03",x"03",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"03",x"03",
		x"03",x"03",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"03",x"03",
		x"03",x"03",x"7F",x"7F",x"7F",x"7F",x"7F",x"FC",x"FC",x"7F",x"7F",x"7F",x"7F",x"7F",x"03",x"03",
		x"03",x"03",x"7F",x"7F",x"7F",x"7F",x"FC",x"FC",x"FC",x"FC",x"7F",x"7F",x"7F",x"7F",x"03",x"03",
		x"03",x"03",x"7F",x"7F",x"7F",x"7F",x"FC",x"FC",x"FC",x"FC",x"7F",x"7F",x"7F",x"7F",x"03",x"03",
		x"03",x"03",x"7F",x"7F",x"7F",x"7F",x"7F",x"FC",x"FC",x"7F",x"7F",x"7F",x"7F",x"7F",x"03",x"03",
		x"03",x"03",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"03",x"03",
		x"03",x"03",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"03",x"03",
		x"03",x"03",x"03",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"7F",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03"
	);

    SPRITE4_ROM <= (
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",  -- sprite4
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"03",x"03",x"03",
		x"03",x"03",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"03",x"03",
		x"03",x"03",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"03",x"03",
		x"03",x"03",x"47",x"47",x"47",x"47",x"47",x"FC",x"FC",x"47",x"47",x"47",x"47",x"47",x"03",x"03",
		x"03",x"03",x"47",x"47",x"47",x"47",x"FC",x"FC",x"FC",x"FC",x"47",x"47",x"47",x"47",x"03",x"03",
		x"03",x"03",x"47",x"47",x"47",x"47",x"FC",x"FC",x"FC",x"FC",x"47",x"47",x"47",x"47",x"03",x"03",
		x"03",x"03",x"47",x"47",x"47",x"47",x"47",x"FC",x"FC",x"47",x"47",x"47",x"47",x"47",x"03",x"03",
		x"03",x"03",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"03",x"03",
		x"03",x"03",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"03",x"03",
		x"03",x"03",x"03",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"47",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",
		x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"03"
	);
	
end Behavioral;

