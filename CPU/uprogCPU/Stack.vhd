library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- sMem interface 
entity Stack is
  port(
    clk         : in std_logic;
    ChipSelect  : in std_logic;
    WriteEnable : in std_logic;
    Address     : in unsigned(9 downto 0);
    DataIn      : in std_logic_vector(19 downto 0);
    DataOut     : out std_logic_vector(19 downto 0)
    );
end Stack;

architecture Behavioral of Stack is

  component LUT_RAM
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
  end component;

begin

  StackMemory : LUT_RAM 
    generic map(data_rows => 1024, data_width => 20, address_width => 10)
    port map(clk=>clk, ChipSelect=>ChipSelect, WriteEnable=>WriteEnable, Address=>Address, DataIn=>DataIn, DataOut=>DataOut);

end Behavioral;