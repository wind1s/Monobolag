library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


entity PM is
  port(
    clk         : in std_logic;
    ChipSelect  : in std_logic;
    WriteEnable : in std_logic;
    Address     : in unsigned(10 downto 0);
    DataIn      : in std_logic_vector(31 downto 0);
    DataOut     : out std_logic_vector(31 downto 0)
    );
end PM;

architecture Behavioral of PM is

  type p_mem_t is array (0 to 2047) of std_logic_vector(31 downto 0);

  constant p_mem_c : p_mem_t := 
            --  OP_MOD_REGTILL_REGFRÅN_ADRESS
      (
      0 => b"00110_000_0000_0000_0000000000000101", -- mov r0, 5
      1 => b"01110_000_0000_0000_0000000000000110", -- cmp r0, 6
      2 => b"01011_000_0000_0000_0000000000000000", -- jlt 0
      3 => b"00001_000_0000_0000_0000000000000011", -- jmp 3

      others => (others=>'0')
      );

  signal p_mem : p_mem_t := p_mem_c;

begin

  process(clk) 
  begin 
    if rising_edge(clk) then
      if WriteEnable = '1' and ChipSelect = '1' then
        p_mem(to_integer(Address)) <= DataIn;
      end if;
    end if;
  end process;

  DataOut <= p_mem(to_integer(Address));

end Behavioral;
  
