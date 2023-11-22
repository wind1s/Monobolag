library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity LUT_RAM is
  generic(
    data_rows : integer := 2;
    data_width : integer := 2;
    address_width : integer := 2
  );
  port(
    clk         : in std_logic;
    ChipSelect  : in std_logic;
    WriteEnable : in std_logic;
    Address     : in unsigned((address_width - 1) downto 0);
    DataIn      : in std_logic_vector((data_width-1) downto 0);
    DataOut     : out std_logic_vector((data_width-1) downto 0)
    );
end LUT_RAM;

architecture Behavioral of LUT_RAM is

  type ram_t is array (0 to (data_rows - 1)) of std_logic_vector((data_width-1) downto 0);
  signal lut_ram : ram_t := (others => (others => '0'));

begin

  process(clk) 
  begin 
    if rising_edge(clk) then
      if WriteEnable = '1' and ChipSelect = '1' then
        lut_ram(to_integer(Address)) <= DataIn;
      end if;
    end if;
  end process;

  DataOut <= lut_ram(to_integer(Address)) when (ChipSelect = '1') else (others => '0');

end Behavioral;
  