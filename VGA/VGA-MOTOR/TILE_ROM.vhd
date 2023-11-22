library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;             

entity TILE_ROM is
	port (
		clk      : in std_logic;
		addr     : in unsigned(13 downto 0);
		data     : out std_logic_vector(7 downto 0));
end TILE_ROM;

architecture Behavioral of TILE_ROM is
	type rom_t is array (0 to 7743) of std_logic_vector(7 downto 0);
	signal ROM_DATA : rom_t;

begin

	process(clk)
	begin
		if rising_edge(clk) then
			data <= ROM_DATA(to_integer(addr));
		end if;
	end process;
	
	ROM_DATA <= (

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- Green background 
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 0
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",  -- A
		x"1E",x"00",x"00",x"1E",x"00",x"00",x"1E",x"1E",  -- index 1
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- B
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",  -- index 2
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- C
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",  -- index 3
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"1E",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- D
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",  -- index 4
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- E
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 5
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- F
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 6
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- G
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",  -- index 7
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"00",x"00",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"1E",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",  -- H
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",  -- index 8
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- I
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",  -- index 9
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",x"1E",  -- J
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",  -- index 10
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",  -- K
		x"00",x"00",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",  -- index 11
		x"00",x"00",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",x"1E",  -- L
		x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",x"1E",  -- index 12
		x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"00",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"00",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",  -- M
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",  -- index 13
		x"00",x"1E",x"00",x"1E",x"00",x"1E",x"00",x"1E",
		x"00",x"1E",x"00",x"1E",x"00",x"1E",x"00",x"1E",
		x"00",x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",
		x"00",x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"00",x"1E",x"1E",x"00",x"00",x"1E",  -- N
		x"00",x"00",x"00",x"1E",x"1E",x"00",x"00",x"1E",  -- index 14
		x"00",x"00",x"1E",x"00",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"00",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"00",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"00",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- O
		x"1E",x"00",x"00",x"1E",x"1E",x"00",x"00",x"1E",  -- index 15
		x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",
		x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",
		x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",
		x"1E",x"00",x"00",x"1E",x"1E",x"00",x"00",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",x"1E",  -- P
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",  -- index 16
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",  -- Q
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",  -- index 17
		x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",
		x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",
		x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",
		x"1E",x"1E",x"00",x"1E",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"1E",x"00",x"00",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- R
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",  -- index 18
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"00",x"00",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",  -- S
		x"1E",x"00",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",  -- index 19
		x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"00",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"00",x"00",x"00",x"00",x"00",x"00",x"1E",  -- T
		x"1E",x"00",x"00",x"00",x"00",x"00",x"00",x"1E",  -- index 20
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",  -- U
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",  -- index 21
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"00",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",  -- V
		x"1E",x"00",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",  -- index 22
		x"1E",x"00",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",  -- W
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",  -- index 23
		x"00",x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",
		x"00",x"00",x"1E",x"00",x"1E",x"00",x"00",x"1E",
		x"1E",x"00",x"1E",x"00",x"1E",x"00",x"1E",x"1E",
		x"1E",x"00",x"00",x"1E",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",  -- X
		x"1E",x"00",x"00",x"1E",x"00",x"00",x"1E",x"1E",  -- index 24
		x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"00",x"00",x"1E",x"00",x"00",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"00",x"00",x"1E",x"1E",x"00",x"00",x"1E",  -- Y
		x"1E",x"00",x"00",x"1E",x"1E",x"00",x"00",x"1E",  -- index 25
		x"1E",x"00",x"00",x"1E",x"1E",x"00",x"00",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"1E",  -- Z
		x"1E",x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",  -- index 26
		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",  -- Å
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 27
		x"1E",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"1E",x"00",x"1E",x"00",x"1E",x"1E",x"1E",  -- Ä
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 28
		x"1E",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"1E",x"1E",x"00",x"1E",x"00",x"1E",x"1E",x"1E",  -- Ö index 29
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"00",x"00",x"1E",
		x"1E",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- 0
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",  -- index 30
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",x"1E",  -- 1
		x"1E",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",  -- index 31
		x"1E",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"00",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"1E",x"00",x"00",x"1E",x"1E",x"1E",  -- 2
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",  -- index 32
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",  -- 3
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",  -- index 33
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",  -- 4
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",  -- index 34
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- 5
		x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 35
		x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",  -- 6
		x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 36
		x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- 7
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",  -- index 37
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- 8
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",  -- index 38
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",  -- 9
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",  -- index 39
		x"1E",x"1E",x"00",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",
		x"1E",x"1E",x"00",x"00",x"00",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- Black tile 
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- index 40
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- purple property tile 0
		x"00",x"62",x"62",x"62",x"62",x"62",x"62",x"62",  -- index 127 --> 41
		x"00",x"62",x"62",x"62",x"62",x"62",x"62",x"62",  -- colours : 00 = black, 62 = purple
		x"00",x"62",x"62",x"62",x"62",x"62",x"62",x"62",  -- pointing left
		x"00",x"62",x"62",x"62",x"62",x"62",x"62",x"62",
		x"00",x"62",x"62",x"62",x"62",x"62",x"62",x"62",
		x"00",x"62",x"62",x"62",x"62",x"62",x"62",x"62",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- purple property tile 1
		x"62",x"62",x"62",x"62",x"62",x"62",x"62",x"62",  -- index 128 --> 42
		x"62",x"62",x"62",x"62",x"62",x"62",x"62",x"62",  
		x"62",x"62",x"62",x"62",x"62",x"62",x"62",x"62",
		x"62",x"62",x"62",x"62",x"62",x"62",x"62",x"62",
		x"62",x"62",x"62",x"62",x"62",x"62",x"62",x"62",
		x"62",x"62",x"62",x"62",x"62",x"62",x"62",x"62",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- Top left sejdel 
		x"1E",x"1E",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- index 43
		x"1E",x"1E",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		x"1E",x"1E",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		x"1E",x"1E",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		x"1E",x"1E",x"FF",x"D8",x"FF",x"FF",x"FF",x"D8",
		x"1E",x"1E",x"4F",x"D8",x"D8",x"D8",x"D8",x"D8",
		x"1E",x"1E",x"4F",x"D8",x"D8",x"D8",x"D8",x"D8",

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- top right sejdel 
		x"FF",x"FF",x"FF",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 44
		x"FF",x"FF",x"FF",x"FF",x"1E",x"1E",x"1E",x"1E",
		x"4F",x"4F",x"4F",x"FF",x"1E",x"1E",x"1E",x"1E",
		x"FF",x"FF",x"FF",x"FF",x"4F",x"4F",x"4F",x"1E",
		x"D8",x"D8",x"D8",x"4F",x"1E",x"1E",x"4F",x"1E",
		x"D8",x"D8",x"D8",x"4F",x"1E",x"1E",x"4F",x"1E",
		x"D8",x"D8",x"D8",x"4F",x"1E",x"1E",x"4F",x"1E",

		x"1E",x"1E",x"4F",x"D8",x"D8",x"D8",x"D8",x"D8",  -- bottom left sejdel 
		x"1E",x"1E",x"4F",x"D8",x"D8",x"D8",x"D8",x"D8",  -- index 45
		x"1E",x"1E",x"4F",x"D8",x"D8",x"D8",x"D8",x"D8",
		x"1E",x"1E",x"4F",x"D8",x"D8",x"D8",x"D8",x"D8",
		x"1E",x"1E",x"4F",x"D8",x"D8",x"D8",x"D8",x"D8",
		x"1E",x"1E",x"4F",x"4F",x"4F",x"4F",x"4F",x"4F",
		x"1E",x"1E",x"1E",x"4F",x"4F",x"4F",x"4F",x"4F",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"D8",x"D8",x"D8",x"4F",x"1E",x"1E",x"4F",x"1E",  -- bottom right sejdel 46
		x"D8",x"D8",x"D8",x"4F",x"1E",x"1E",x"4F",x"1E",  -- index 46
		x"D8",x"D8",x"D8",x"4F",x"4F",x"4F",x"4F",x"1E",
		x"D8",x"D8",x"D8",x"4F",x"1E",x"1E",x"1E",x"1E",
		x"D8",x"D8",x"D8",x"4F",x"1E",x"1E",x"1E",x"1E",
		x"4F",x"4F",x"4F",x"4F",x"1E",x"1E",x"1E",x"1E",
		x"4F",x"4F",x"4F",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E", 

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"72",x"72",  -- top left beercan  
		x"1E",x"1E",x"1E",x"72",x"72",x"72",x"32",x"32",  -- index 47
		x"1E",x"1E",x"72",x"32",x"32",x"32",x"72",x"72",  -- colours: 72 = light gray, 32 = dark gray, 50 = dark green, 54 = light green
		x"1E",x"1E",x"50",x"72",x"72",x"72",x"32",x"32",
		x"1E",x"1E",x"50",x"50",x"50",x"50",x"72",x"72",
		x"1E",x"1E",x"50",x"54",x"54",x"54",x"50",x"50",
		x"1E",x"1E",x"50",x"54",x"54",x"54",x"54",x"54",
		x"1E",x"1E",x"50",x"54",x"54",x"54",x"54",x"54",

		x"72",x"72",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- top right beercan 
		x"32",x"32",x"72",x"72",x"72",x"1E",x"1E",x"1E",  -- index 48
		x"72",x"72",x"32",x"32",x"32",x"72",x"1E",x"1E",
		x"32",x"32",x"72",x"72",x"72",x"50",x"1E",x"1E",
		x"72",x"72",x"50",x"50",x"50",x"50",x"1E",x"1E",
		x"50",x"50",x"54",x"54",x"50",x"50",x"1E",x"1E",
		x"54",x"54",x"54",x"54",x"50",x"50",x"1E",x"1E",
		x"54",x"54",x"54",x"54",x"50",x"50",x"1E",x"1E",

		x"1E",x"1E",x"50",x"54",x"54",x"54",x"54",x"54",  -- bottom left beercan 
		x"1E",x"1E",x"50",x"54",x"54",x"54",x"54",x"54",  -- index 49
		x"1E",x"1E",x"50",x"54",x"54",x"54",x"54",x"54",
		x"1E",x"1E",x"50",x"54",x"54",x"54",x"54",x"54",
		x"1E",x"1E",x"50",x"50",x"54",x"54",x"54",x"54",
		x"1E",x"1E",x"50",x"50",x"50",x"50",x"50",x"50",
		x"1E",x"1E",x"72",x"72",x"50",x"50",x"50",x"50",
		x"1E",x"1E",x"1E",x"72",x"72",x"72",x"72",x"72",

		x"54",x"54",x"54",x"54",x"50",x"50",x"1E",x"1E",  -- bottom right beercan 
		x"54",x"54",x"54",x"54",x"50",x"50",x"1E",x"1E",  -- index 50
		x"54",x"54",x"54",x"54",x"50",x"50",x"1E",x"1E",
		x"54",x"54",x"54",x"54",x"50",x"50",x"1E",x"1E",
		x"54",x"54",x"54",x"50",x"50",x"50",x"1E",x"1E",
		x"50",x"50",x"50",x"50",x"50",x"50",x"1E",x"1E",
		x"50",x"50",x"50",x"50",x"72",x"72",x"1E",x"1E",
		x"72",x"72",x"72",x"72",x"72",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"A0",x"A0",  -- top left cider
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"A1",x"A2",  -- index 51
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"60",x"60",  -- colours: A0 = dark pink, A1 = pink, A2 = light pink, 60 = red 
		x"1E",x"1E",x"1E",x"1E",x"1E",x"A2",x"A1",x"A2",
		x"1E",x"1E",x"1E",x"1E",x"A2",x"A1",x"A2",x"A0",
		x"1E",x"1E",x"1E",x"1E",x"A1",x"A0",x"A0",x"A0",
		x"1E",x"1E",x"1E",x"1E",x"A1",x"A0",x"A0",x"A0",
		x"1E",x"1E",x"1E",x"1E",x"A1",x"A0",x"A0",x"A0", 

		x"A0",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- top right cider 
		x"A1",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 52
		x"60",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"A1",x"A2",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"A0",x"A1",x"A2",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"A0",x"A0",x"A1",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"A1",x"A0",x"A1",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"A1",x"A0",x"A1",x"1E",x"1E",x"1E",x"1E",x"1E", 

		x"1E",x"1E",x"1E",x"1E",x"A1",x"A0",x"A0",x"A0",  -- bottom left cider 
		x"1E",x"1E",x"1E",x"1E",x"A1",x"A0",x"A0",x"A0",  -- index 53
		x"1E",x"1E",x"1E",x"1E",x"A1",x"A0",x"A0",x"A0",
		x"1E",x"1E",x"1E",x"1E",x"A1",x"A0",x"A0",x"A0",
		x"1E",x"1E",x"1E",x"1E",x"A1",x"A0",x"A0",x"A0",
		x"1E",x"1E",x"1E",x"1E",x"A1",x"A0",x"A0",x"A0",
		x"1E",x"1E",x"1E",x"1E",x"A2",x"A0",x"A0",x"A0",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"A1",x"A1",x"A1", 

		x"A1",x"A0",x"A1",x"1E",x"1E",x"1E",x"1E",x"1E",  -- bottom right cider 
		x"A1",x"A0",x"A1",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 54
		x"A1",x"A0",x"A1",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"A1",x"A0",x"A1",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"A1",x"A0",x"A1",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"A1",x"A0",x"A1",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"A0",x"A0",x"A2",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"A1",x"A1",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"00",  -- top left winebottle
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"44",  -- index 55
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"44",  -- colours: 00 = black, 44 = brown, FF = white, 7B = light blue, 80 = light red, 64 = dark red
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"FF",x"7B",
		x"1E",x"1E",x"1E",x"1E",x"00",x"FF",x"FF",x"7B",
		x"1E",x"1E",x"1E",x"1E",x"00",x"FF",x"7B",x"7B",
		x"1E",x"1E",x"1E",x"1E",x"00",x"80",x"64",x"64",

		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- top right winebottle
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 56
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"7B",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"FF",x"7B",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"FF",x"7B",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"80",x"64",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"1E",x"1E",x"00",x"80",x"64",x"00",  -- bottom left winebottle  
		x"1E",x"1E",x"1E",x"1E",x"00",x"80",x"64",x"00",  -- index 57
		x"1E",x"1E",x"1E",x"1E",x"00",x"80",x"64",x"00",
		x"1E",x"1E",x"1E",x"1E",x"00",x"80",x"64",x"00",
		x"1E",x"1E",x"1E",x"1E",x"00",x"80",x"64",x"00",
		x"1E",x"1E",x"1E",x"1E",x"00",x"80",x"64",x"64",
		x"1E",x"1E",x"1E",x"1E",x"00",x"80",x"64",x"64",
		x"1E",x"1E",x"1E",x"1E",x"00",x"00",x"00",x"00",

		x"00",x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",  -- bottom right winebottle 58
		x"80",x"80",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 58
		x"80",x"80",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"80",x"80",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"64",x"64",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"64",x"64",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E", 

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"00",  -- top left dunksprit
		x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"1E",x"1E",  -- index 59
		x"1E",x"02",x"00",x"00",x"00",x"00",x"00",x"00",  -- colours: 00 = black, 02 = dark gray?, 4E = blue, 4F = light blue, 7B = lighest blue, 2A = dark blue, 72 = gray-blue, FF = white
		x"1E",x"02",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",  
		x"1E",x"02",x"4F",x"4F",x"4F",x"4F",x"4F",x"4F",
		x"1E",x"02",x"4F",x"4F",x"4F",x"4F",x"4F",x"4F",
		x"1E",x"02",x"4F",x"4F",x"4F",x"4F",x"4F",x"4F",
		x"1E",x"02",x"4F",x"4F",x"4F",x"4F",x"4F",x"4F", 

		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- top right dunksprit 
		x"1E",x"1E",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 60
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"1E",
		x"4F",x"2A",x"4E",x"2A",x"4E",x"2A",x"00",x"1E",
		x"7B",x"2A",x"72",x"4E",x"72",x"4E",x"00",x"1E",
		x"7B",x"4E",x"72",x"72",x"72",x"4E",x"00",x"1E",
		x"7B",x"4E",x"72",x"72",x"72",x"72",x"00",x"1E",
		x"7B",x"4E",x"72",x"72",x"72",x"72",x"00",x"1E",

		x"1E",x"02",x"4F",x"4F",x"4F",x"4F",x"4F",x"4F",  -- bottom left dunksprit 
		x"1E",x"02",x"4F",x"4F",x"4F",x"4F",x"4F",x"4F",  -- index 61
		x"1E",x"02",x"4F",x"4F",x"4F",x"4F",x"4F",x"4F",
		x"1E",x"02",x"4F",x"4F",x"4F",x"4F",x"4F",x"4F",
		x"1E",x"02",x"4F",x"4F",x"4F",x"4F",x"4F",x"4F",
		x"1E",x"02",x"4F",x"7B",x"7B",x"7B",x"7B",x"7B",
		x"1E",x"02",x"02",x"02",x"02",x"02",x"02",x"02",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"7B",x"4E",x"72",x"4F",x"4F",x"72",x"00",x"1E",  -- bottom right dunksprit 
		x"7B",x"4E",x"72",x"4F",x"4F",x"72",x"00",x"1E",  -- index 62
		x"7B",x"4E",x"72",x"4F",x"4F",x"72",x"00",x"1E",
		x"7B",x"4E",x"72",x"4F",x"4F",x"72",x"00",x"1E",
		x"7B",x"4E",x"72",x"72",x"72",x"72",x"00",x"1E",
		x"FF",x"4E",x"4F",x"4F",x"4F",x"4F",x"00",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E", 

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",x"32",  -- top left vodka 
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",x"32",  -- index 63
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"72",x"72",  -- colours: 32 = dark gray, 72 = light gray, 7B = light blue
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"72",x"72",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"7B",x"7B",x"7B",
		x"1E",x"1E",x"1E",x"1E",x"7B",x"7B",x"7B",x"7B",
		x"1E",x"1E",x"1E",x"1E",x"7B",x"7B",x"7B",x"72",
		x"1E",x"1E",x"1E",x"1E",x"7B",x"7B",x"7B",x"72",

		x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- top right vodka 64
		x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 64
		x"72",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"72",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"7B",x"7B",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"7B",x"7B",x"7B",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"72",x"72",x"72",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"72",x"72",x"72",x"1E",x"1E",x"1E",x"1E",x"1E", 

		x"1E",x"1E",x"1E",x"1E",x"7B",x"7B",x"7B",x"72",  -- bottom left vodka 65
		x"1E",x"1E",x"1E",x"1E",x"7B",x"7B",x"7B",x"72",  -- index 65
		x"1E",x"1E",x"1E",x"1E",x"7B",x"7B",x"7B",x"72",
		x"1E",x"1E",x"1E",x"1E",x"7B",x"7B",x"7B",x"72",
		x"1E",x"1E",x"1E",x"1E",x"7B",x"7B",x"7B",x"7B",
		x"1E",x"1E",x"1E",x"1E",x"7B",x"7B",x"7B",x"7B",
		x"1E",x"1E",x"1E",x"1E",x"7B",x"7B",x"7B",x"7B",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"7B",x"7B",x"7B", 

		x"72",x"72",x"72",x"1E",x"1E",x"1E",x"1E",x"1E",  -- bottom right vodka 66
		x"72",x"72",x"72",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 66
		x"72",x"72",x"72",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"72",x"72",x"72",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"7B",x"7B",x"7B",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"7B",x"7B",x"7B",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"7B",x"7B",x"7B",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"7B",x"7B",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"1E",x"1E",x"1E",x"FF",x"FF",x"FF",  -- top left cup
		x"1E",x"1E",x"FF",x"FF",x"FF",x"72",x"72",x"72",  -- index 67
		x"1E",x"FF",x"72",x"72",x"72",x"72",x"32",x"32",  -- colours: FF = white, 32 = dark gray, 72 = light gray, 64 = dark red, 84 = red
		x"1E",x"64",x"FF",x"FF",x"FF",x"32",x"32",x"32",
		x"1E",x"1E",x"64",x"84",x"84",x"FF",x"FF",x"FF",
		x"1E",x"1E",x"64",x"64",x"84",x"84",x"84",x"84",
		x"1E",x"1E",x"64",x"64",x"84",x"84",x"84",x"84",
		x"1E",x"1E",x"64",x"64",x"84",x"84",x"84",x"84",

		x"FF",x"FF",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- top right cup 
		x"72",x"72",x"FF",x"FF",x"FF",x"1E",x"1E",x"1E",  -- index 68
		x"32",x"72",x"72",x"72",x"72",x"FF",x"1E",x"1E",
		x"32",x"32",x"FF",x"FF",x"FF",x"84",x"1E",x"1E",
		x"FF",x"FF",x"84",x"84",x"84",x"1E",x"1E",x"1E",
		x"84",x"84",x"84",x"84",x"84",x"1E",x"1E",x"1E",
		x"84",x"84",x"84",x"84",x"84",x"1E",x"1E",x"1E",
		x"84",x"84",x"84",x"84",x"84",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"64",x"64",x"84",x"84",x"84",x"84",  -- bottom left cup 
		x"1E",x"1E",x"64",x"64",x"84",x"84",x"84",x"84",  -- index 69
		x"1E",x"1E",x"64",x"64",x"84",x"84",x"84",x"84",
		x"1E",x"1E",x"64",x"64",x"84",x"84",x"84",x"84",
		x"1E",x"1E",x"64",x"64",x"64",x"84",x"84",x"84",
		x"1E",x"1E",x"1E",x"64",x"64",x"64",x"84",x"84",
		x"1E",x"1E",x"1E",x"1E",x"64",x"64",x"64",x"64",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E", 

		x"84",x"84",x"84",x"84",x"84",x"1E",x"1E",x"1E",  -- bottom right cup 
		x"84",x"84",x"84",x"84",x"84",x"1E",x"1E",x"1E",  -- index 70
		x"84",x"84",x"84",x"84",x"84",x"1E",x"1E",x"1E",
		x"84",x"84",x"84",x"84",x"84",x"1E",x"1E",x"1E",
		x"84",x"84",x"84",x"84",x"84",x"1E",x"1E",x"1E",
		x"84",x"84",x"84",x"84",x"1E",x"1E",x"1E",x"1E",
		x"64",x"64",x"64",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- top left cocktail glass
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 71
		x"1E",x"AC",x"AC",x"AC",x"1E",x"1E",x"1E",x"1E",  -- colours: AC = orange, B0 = light orange, 72 = light gray, F9 = light yellow, F8 = dark yellow, 54 light green
		x"AC",x"B0",x"B0",x"B0",x"AC",x"1E",x"1E",x"1E",
		x"AC",x"B0",x"72",x"72",x"72",x"72",x"72",x"72",
		x"1E",x"1E",x"1E",x"72",x"F9",x"F9",x"F9",x"F9",
		x"1E",x"1E",x"1E",x"1E",x"72",x"72",x"F9",x"F8",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"72",x"F8",

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- top right cocktail glass
		x"1E",x"1E",x"1E",x"54",x"54",x"54",x"1E",x"1E",  -- index 72
		x"1E",x"1E",x"1E",x"54",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"54",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"72",x"72",x"72",x"72",x"72",x"72",x"72",x"1E",
		x"F9",x"F9",x"F9",x"F9",x"F9",x"72",x"1E",x"1E",
		x"F8",x"F8",x"F8",x"72",x"72",x"1E",x"1E",x"1E",
		x"F8",x"F8",x"72",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"72",x"F8",  -- bottom left cocktail glass 
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"72",  -- index 73
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"72",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"72",x"72",x"72",

		x"F8",x"F8",x"72",x"1E",x"1E",x"1E",x"1E",x"1E",  -- bottom right cocktail glass 74
		x"72",x"72",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 74
		x"72",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"72",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"72",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"72",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"72",x"72",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"72",x"72",x"72",x"72",x"1E",x"1E",x"1E",x"1E",

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- go tile 0
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 75
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- colours: 00 = black, 64 = red 75
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"64",x"64",x"64",x"64",x"64",x"64",
		x"00",x"1E",x"64",x"64",x"64",x"64",x"64",x"64",
		x"00",x"1E",x"64",x"64",x"00",x"00",x"00",x"00",
		x"00",x"1E",x"64",x"64",x"00",x"00",x"1E",x"1E",

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- go tile 1 
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 76
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"64",x"64",x"64",x"64",x"64",x"64",x"1E",x"1E",
		x"64",x"64",x"64",x"64",x"64",x"64",x"00",x"00",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- go tile 2 
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 77
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"64",x"64",x"64",x"64",x"64",x"64",x"64",x"64",
		x"64",x"64",x"64",x"64",x"64",x"64",x"64",x"64",
		x"64",x"64",x"00",x"00",x"00",x"00",x"00",x"00",
		x"64",x"64",x"00",x"00",x"1E",x"1E",x"1E",x"1E",

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- go tile 3 
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",  -- index 78
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"64",x"64",x"64",x"64",x"1E",x"1E",x"1E",x"00",
		x"64",x"64",x"64",x"64",x"00",x"00",x"1E",x"00",
		x"1E",x"1E",x"64",x"64",x"00",x"00",x"1E",x"00",
		x"1E",x"1E",x"64",x"64",x"00",x"00",x"1E",x"00",

		x"00",x"1E",x"64",x"64",x"00",x"00",x"1E",x"1E",  -- go tile 4 
		x"00",x"1E",x"64",x"64",x"00",x"00",x"1E",x"1E",  -- index 79
		x"00",x"1E",x"64",x"64",x"00",x"00",x"1E",x"1E",
		x"00",x"1E",x"64",x"64",x"00",x"00",x"1E",x"1E",
		x"00",x"1E",x"64",x"64",x"00",x"00",x"1E",x"1E",
		x"00",x"1E",x"64",x"64",x"00",x"00",x"1E",x"1E",
		x"00",x"1E",x"64",x"64",x"00",x"00",x"1E",x"1E",
		x"00",x"1E",x"64",x"64",x"00",x"00",x"1E",x"1E",

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- go tile 5 
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 80
		x"64",x"64",x"64",x"64",x"64",x"64",x"1E",x"1E",
		x"64",x"64",x"64",x"64",x"64",x"64",x"00",x"00",
		x"1E",x"1E",x"00",x"00",x"64",x"64",x"00",x"00",
		x"1E",x"1E",x"1E",x"1E",x"64",x"64",x"00",x"00",
		x"1E",x"1E",x"1E",x"1E",x"64",x"64",x"00",x"00",
		x"1E",x"1E",x"1E",x"1E",x"64",x"64",x"00",x"00",

		x"64",x"64",x"00",x"00",x"1E",x"1E",x"1E",x"1E",  -- go tile 6 
		x"64",x"64",x"00",x"00",x"1E",x"1E",x"1E",x"1E",  -- index 81
		x"64",x"64",x"00",x"00",x"1E",x"1E",x"1E",x"1E",
		x"64",x"64",x"00",x"00",x"1E",x"1E",x"1E",x"1E",
		x"64",x"64",x"00",x"00",x"1E",x"1E",x"1E",x"1E",
		x"64",x"64",x"00",x"00",x"1E",x"1E",x"1E",x"1E",
		x"64",x"64",x"00",x"00",x"1E",x"1E",x"1E",x"1E",
		x"64",x"64",x"00",x"00",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"64",x"64",x"00",x"00",x"1E",x"00",  -- go tile 7 
		x"1E",x"1E",x"64",x"64",x"00",x"00",x"1E",x"00",  -- index 82
		x"1E",x"1E",x"64",x"64",x"00",x"00",x"1E",x"00",
		x"1E",x"1E",x"64",x"64",x"00",x"00",x"1E",x"00",
		x"1E",x"1E",x"64",x"64",x"00",x"00",x"1E",x"00",
		x"1E",x"1E",x"64",x"64",x"00",x"00",x"1E",x"00",
		x"1E",x"1E",x"64",x"64",x"00",x"00",x"1E",x"00",
		x"1E",x"1E",x"64",x"64",x"00",x"00",x"1E",x"00",

		x"00",x"1E",x"64",x"64",x"00",x"00",x"1E",x"1E",  -- go tile 8 
		x"00",x"1E",x"64",x"64",x"64",x"64",x"64",x"64",  -- index 83
		x"00",x"1E",x"64",x"64",x"64",x"64",x"64",x"64",
		x"00",x"1E",x"00",x"00",x"00",x"00",x"00",x"00",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"64",x"64",x"64",
		x"00",x"1E",x"1E",x"1E",x"64",x"64",x"64",x"64",

		x"1E",x"1E",x"1E",x"1E",x"64",x"64",x"00",x"00",  -- go tile 9 
		x"64",x"64",x"64",x"64",x"64",x"64",x"00",x"00",  -- index 84
		x"64",x"64",x"64",x"64",x"64",x"64",x"00",x"00",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"64",x"64",x"00",x"00",x"1E",x"1E",x"1E",x"1E",  -- go tile 10 
		x"64",x"64",x"64",x"64",x"64",x"64",x"64",x"64",  -- index 85
		x"64",x"64",x"64",x"64",x"64",x"64",x"64",x"64",
		x"1E",x"1E",x"00",x"00",x"00",x"00",x"00",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"64",

		x"1E",x"1E",x"64",x"64",x"00",x"00",x"1E",x"00",  -- go tile 11 
		x"64",x"64",x"64",x"64",x"00",x"00",x"1E",x"00",  -- index 86
		x"64",x"64",x"64",x"64",x"00",x"00",x"1E",x"00",
		x"00",x"00",x"00",x"00",x"00",x"00",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"64",x"64",x"64",x"64",x"64",x"1E",x"00",
		x"64",x"64",x"64",x"64",x"64",x"64",x"1E",x"00",

		x"00",x"1E",x"64",x"64",x"64",x"64",x"64",x"64",  -- go tile 12 
		x"00",x"1E",x"64",x"64",x"64",x"64",x"64",x"64",  -- index 87
		x"00",x"1E",x"1E",x"1E",x"64",x"64",x"64",x"64",
		x"00",x"1E",x"1E",x"1E",x"1E",x"64",x"64",x"64",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		x"64",x"64",x"64",x"64",x"64",x"64",x"64",x"64",  -- go tile 13 
		x"64",x"64",x"64",x"64",x"64",x"64",x"64",x"64",  -- index 88
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		x"64",x"64",x"64",x"64",x"64",x"64",x"64",x"64",  -- go tile 14 
		x"64",x"64",x"64",x"64",x"64",x"64",x"64",x"64",  -- index 89
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"64",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		x"64",x"64",x"64",x"00",x"00",x"00",x"1E",x"00",  -- go tile 15 
		x"64",x"64",x"64",x"00",x"1E",x"1E",x"1E",x"00",  -- index 90
		x"64",x"64",x"64",x"64",x"64",x"64",x"1E",x"00",
		x"1E",x"64",x"64",x"64",x"64",x"64",x"1E",x"00",
		x"1E",x"1E",x"1E",x"00",x"00",x"00",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- bench tile 0
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 91
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- colours: 00 = black, 32 = gray, F8 = yellow
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"00",
		x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"F8",x"F8",

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- bench tile 1
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 92
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"32",x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"32",x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- bench tile 2
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 93
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",x"32",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",x"32",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- bench tile 3
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",  -- index 94
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"F8",x"F8",x"00",x"1E",x"1E",x"1E",x"1E",x"00",

		x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"F8",x"F8",  -- bench tile 4
		x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"F8",x"F8",  -- index 95
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"00",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"00",
		x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"F8",x"F8",
		x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"F8",x"F8",
		x"00",x"1E",x"1E",x"1E",x"1E",x"00",x"F8",x"F8",

		x"32",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",  -- bench tile 5
		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",  -- index 96
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"32",x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",
		x"32",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",
		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",

		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"32",  -- bench tile 6
		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",  -- index 97
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",x"32",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",
		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"32",
		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",

		x"F8",x"F8",x"00",x"1E",x"1E",x"1E",x"1E",x"00",  -- bench tile 7
		x"F8",x"F8",x"00",x"1E",x"1E",x"1E",x"1E",x"00",  -- index 98
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"F8",x"F8",x"00",x"1E",x"1E",x"1E",x"1E",x"00",
		x"F8",x"F8",x"00",x"1E",x"1E",x"1E",x"1E",x"00",
		x"F8",x"F8",x"00",x"1E",x"1E",x"1E",x"1E",x"00",

		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",x"00",  -- bench tile 8
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",  -- index 99
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",
		x"00",x"1E",x"1E",x"1E",x"00",x"00",x"00",x"00",
		x"00",x"1E",x"1E",x"00",x"F8",x"F8",x"F8",x"F8",
		x"00",x"1E",x"1E",x"00",x"F8",x"F8",x"F8",x"F8",
		x"00",x"1E",x"1E",x"1E",x"00",x"00",x"00",x"00",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- bench tile 9
		x"32",x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 100
		x"32",x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",
		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"32",x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- bench tile 10
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",x"32",  -- index 101
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",x"32",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",
		x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",x"F8",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",x"32",

		x"00",x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",  -- bench tile 11
		x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",  -- index 102
		x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"00",x"00",x"00",x"00",x"1E",x"1E",x"1E",x"00",
		x"F8",x"F8",x"F8",x"F8",x"00",x"1E",x"1E",x"00",
		x"F8",x"F8",x"F8",x"F8",x"00",x"1E",x"1E",x"00",
		x"00",x"00",x"00",x"00",x"1E",x"1E",x"1E",x"00",
		x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",

		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",  -- bench tile 12
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",  -- index 103
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		x"32",x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- bench tile 13
		x"32",x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 104
		x"32",x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"32",x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",x"32",  -- bench tile 14
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",x"32",  -- index 105
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",x"32",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"32",x"32",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",  -- bench tile 15
		x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",  -- index 106
		x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"32",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- green property tile 0
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",  -- index 107
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",  -- colours: 00 = black, 54 = green
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",  -- pointing up
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- green property tile 1
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 108
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		-- green property tile 2
		-- index 108

	    -- green property tile 3
	    -- index 107

		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",  -- green property tile 4
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",  -- index 109
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",
		x"00",x"54",x"54",x"54",x"54",x"54",x"54",x"00",

		-- green property tile 5
		-- index 0

		-- green property tile 6
		-- index 0

		-- green property tile 7 
		-- index 109

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- green property tile 8
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 110
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		-- green property tile 9 
		-- index 108

		-- green property tile 10 
		-- index 108
		
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- green property tile 11
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",  -- index 111
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",

		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- green property tile 12
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 112
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- green property tile 13
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 113
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		-- green property tile 14 
		-- index 113

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",  -- green property tile 15
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",  -- index 114
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		-- blue property tile 0
		-- index 110
		-- colours: 00 = black, 4E = blue
		-- pointing right

		-- blue property tile 1
		-- index 111

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- blue property tile 2
		x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",  -- index 115
		x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",
		x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",
		x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",
		x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",
		x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",  -- blue property tile 3
		x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"00",  -- index 116
		x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"00",
		x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"00",
		x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"00",
		x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"00",
		x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"4E",x"00",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",

		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- blue property tile 4
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",  -- index 117
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",
		x"00",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",

		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",  -- blue property tile 5
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",  -- index 118
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",
		x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"1E",x"00",

		-- blue property tile 6
		-- index 0

		-- blue property tile 7
		-- index 118

		-- blue property tile 8
		-- index 117

		-- blue property tile 9
		-- index 118

		-- blue property tile 10
		-- index 0

		-- blue property tile 11
		-- index 118

		-- blue property tile 12
		-- index 112

		-- blue property tile 13
		-- index 114

		-- blue property tile 14
		-- index 115

		-- blue property tile 15
		-- index 118

		-- red property tile 0 
		-- index 110
		-- colours; 64 = red, 00 = black
		-- pointing down

		-- red property tile 1
		-- index 108

		-- red property tile 2
		-- index 108

		-- red property tile 3
		-- index 111

		-- red property tile 4
		-- index 112

		-- red property tile 5
		-- index 113

		-- red property tile 6
		-- index 113

		-- red property tile 7
		-- index 114

		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",  -- red property tile 8
		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",  -- index 119
		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",
		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",
		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",
		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",
		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",
		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",

		-- red property tile 9
		-- index 0

		-- red property tile 10
		-- index 0

		-- red property tile 11
		-- index 119

		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",  -- red property tile 12
		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",  -- index 120
		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",
		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",
		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",
		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",
		x"00",x"64",x"64",x"64",x"64",x"64",x"64",x"00",
		x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00"

		-- red property tile 13
		-- index 113

		-- red property tile 14
		-- index 113

		-- red property tile 15
		-- index 120

		-- purple property tile 0 and 1 have index 41 and 42
		-- purple property tile 2
		-- index 110

		-- purple property tile 3
		-- index 111

		-- purple property tile 4
		-- index 117

		-- purple property tile 5
		-- index 0

		-- purple property tile 6
		-- index 117

		-- purple property tile 7
		-- index 118

		-- purple property tile 8
		-- index 117

		-- purple property tile 9
		-- index 0

		-- purple property tile 10
		-- index 117

		-- purple property tile 11
		-- index 118

		-- purple property tile 12
		-- index 127

		-- purple property tile 13
		-- index 128

		-- purple property tile 14
		-- index 112

		-- purple property tile 15
		-- index 114

	);
	
end Behavioral;

