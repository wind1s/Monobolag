--------------------------------------------------------------------------------
-- VGA lab testbench
-- Anders Nilsson
-- 26-feb-2020
-- Version 1.0


-- library declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;            -- basic IEEE library
use IEEE.NUMERIC_STD.ALL;               -- IEEE library for the unsigned type
                                        -- and various arithmetic operations
entity VGA_tb is
end entity;

architecture func of VGA_tb is

	component VGA
		port (
			clk      : in std_logic;                         -- system clock
			rst      : in std_logic;                         -- reset
			Hsync    : out std_logic;                        -- horizontal sync
			Vsync    : out std_logic;                        -- vertical sync
			vgaRed   : out std_logic_vector(2 downto 0);     -- VGA red
			vgaGreen : out std_logic_vector(2 downto 0);     -- VGA green
			vgaBlue  : out std_logic_vector(2 downto 1));     -- VGA blue
	end component;

	signal clk : std_logic;
	signal rst : std_logic;

	constant FPGA_clk_period : time := 10 ns;

begin

	vga_comp: VGA port map(
		clk => clk,
		rst => rst
	);

	clk_process : process
	begin
		clk <= '0';
		wait for FPGA_clk_period/2;
		clk <= '1';
		wait for FPGA_clk_period/2;
	end process;

	rst <= '1', '0' after 25 ns;

end architecture;
