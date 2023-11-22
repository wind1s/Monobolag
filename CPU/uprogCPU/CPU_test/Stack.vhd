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

  type s_mem_t is array (0 to 1023) of std_logic_vector(19 downto 0);
  constant s_mem_c : s_mem_t := (others => (others=>'0'));
  signal s_mem : s_mem_t := s_mem_c;

begin

  process(clk) 
  begin 
    if rising_edge(clk) then
      if WriteEnable = '1' and ChipSelect = '1' then
        s_mem(to_integer(Address)) <= DataIn;
      end if;
    end if;
  end process;

  DataOut <= s_mem(to_integer(Address)) when (ChipSelect = '1') else (others => '0');

end Behavioral;