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

  type d_mem_t is array (0 to 2047) of std_logic_vector(19 downto 0);
  constant d_mem_c : d_mem_t := 
  (
    0 => b"00000000000000000100",
    others => (others=>'0')
    );
  signal d_mem : d_mem_t := d_mem_c;

begin

  process(clk) 
  begin 
    if rising_edge(clk) then
      if WriteEnable = '1' and ChipSelect = '1' then
        d_mem(to_integer(Address)) <= DataIn;
      end if;
    end if;
  end process;

  DataOut <= d_mem(to_integer(Address)) when (ChipSelect = '1') else (others => '0');

end Behavioral;