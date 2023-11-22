library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- dataMem interface
entity DM is
  port(
    clk         : in std_logic;
    ChipSelect  : in std_logic;
    WriteEnable : in std_logic;
    Address     : in unsigned(10 downto 0);
    DataIn      : in std_logic_vector(19 downto 0);
    DataOut     : out std_logic_vector(19 downto 0)
    );
end DM;

architecture Behavioral of DM is

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
      Address     : in unsigned((address_width - 1)downto 0);
      DataIn      : in std_logic_vector((data_width-1) downto 0);
      DataOut     : out std_logic_vector((data_width-1) downto 0)
      );
  end component;

begin

  DataMemory : LUT_RAM 
    generic map(data_rows => 2048, data_width => 20, address_width => 11)
    port map(clk=>clk, ChipSelect=>ChipSelect, WriteEnable=>WriteEnable, Address=>Address, DataIn=>DataIn, DataOut=>DataOut); 

end Behavioral;