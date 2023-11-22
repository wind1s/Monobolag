library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;           


entity VIDEO_RAM is
	port (
		clk        : in std_logic;
		-- port 1
		cs 				 : in std_logic;
		we1        : in std_logic;
		data_in1   : in std_logic_vector(7 downto 0);
		addr1      : in unsigned(12 downto 0);
		-- port 2
		data_out2  : out std_logic_vector(7 downto 0);
		addr2      : in unsigned(12 downto 0)
	);
end VIDEO_RAM;

architecture Behavioral of VIDEO_RAM is

	type ram_t is array (0 to 4799) of std_logic_vector(7 downto 0);
	signal VideoRAM : ram_t := (others => x"00");

begin

	process(clk)
	begin
		if rising_edge(clk) then
			-- Input from CPU
			if (we1 = '1' and cs = '1') then
				VideoRAM(to_integer(addr1)) <= data_in1;
			end if;

			-- Output to VGA_MOTOR
			data_out2 <= VideoRAM(to_integer(addr2));
		end if;
	end process;

end Behavioral;

