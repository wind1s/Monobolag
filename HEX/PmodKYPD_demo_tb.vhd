-- PmodKYPD_demo_tb
-- Testbench for PmodKYPD_demo

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PmodKYPD_demo_tb is
end;

architecture sim of PmodKYPD_demo_tb is

component PmodKYPD_demo is
	port(
		clk : in std_logic;
		rst	: in std_logic;
		JA : inout std_logic_vector(7 downto 0);
		an : out std_logic_vector(3 downto 0);
		seg : out std_logic_vector(7 downto 0)
		);
end component;

signal clk : std_logic;
signal rst : std_logic;
signal row : std_logic_vector(7 downto 0);

begin

	U0 : PmodKYPD_demo port map(
		clk => clk,
		rst => rst,
		JA => row
	);

	rst <= '1', '0' after 13 ns;
	
	-- Simulate key 1 being pressed and released
	row <= "11110000", "01110000" after 1 ms, "11110000" after 2 ms;

	process
	begin
	
		for i in 0 to 1200000 loop
			clk <= '0';
			wait for 5 ns;
			clk <= '1';
			wait for 5 ns;
		end loop;
		
		wait; -- wait forever, will finish simulation
	end process;	
	
end;
