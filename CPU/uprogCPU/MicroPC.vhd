library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MicroPC is
  port (
    clk, rst    : in std_logic;
    SEQ         : in std_logic_vector(3 downto 0);
    SR          : in std_logic_vector(3 downto 0);
    uADR        : in unsigned(6 downto 0);
    K1Address   : in unsigned(6 downto 0);
    K2Address   : in unsigned(6 downto 0);
    K3Address   : in unsigned(6 downto 0);
    uPC         : out unsigned(6 downto 0)
  );
end entity;

architecture Behavioral of MicroPC is

  signal uPC_s              : unsigned(6 downto 0) := (others => '0');
  signal uPC_plus_1         : unsigned(6 downto 0) := (others => '0');
  signal uPC_Z0, uPC_Z1     : unsigned(6 downto 0);
  signal uPC_C0, uPC_C1     : unsigned(6 downto 0);
  signal uPC_V0, uPC_V1     : unsigned(6 downto 0);
  signal uPC_N1             : unsigned(6 downto 0);

  alias Z   : std_logic is SR(3);
  alias N   : std_logic is SR(2);
  alias C   : std_logic is SR(1);
  alias V   : std_logic is SR(0);

  constant uPC_INC      : std_logic_vector(3 downto 0) := "0000";
  constant uPC_ZERO     : std_logic_vector(3 downto 0) := "0001";
  constant uPC_K1       : std_logic_vector(3 downto 0) := "0010";
  constant uPC_K2       : std_logic_vector(3 downto 0) := "0011";
  constant uPC_K3       : std_logic_vector(3 downto 0) := "0100";
  constant uPC_uADR     : std_logic_vector(3 downto 0) := "0101";
  constant uPC_JMP_Z0   : std_logic_vector(3 downto 0) := "0110";
  constant uPC_JMP_Z1   : std_logic_vector(3 downto 0) := "0111";
  constant uPC_JMP_C0   : std_logic_vector(3 downto 0) := "1000";
  constant uPC_JMP_C1   : std_logic_vector(3 downto 0) := "1001";
  constant uPC_JMP_V0   : std_logic_vector(3 downto 0) := "1010";
  constant uPC_JMP_V1   : std_logic_vector(3 downto 0) := "1011";
  constant uPC_JMP_N1   : std_logic_vector(3 downto 0) := "1100";

begin

  uPC <= uPC_s;

  uPC_plus_1 <= uPC_s + 1;
  uPC_Z0 <= uADR when (Z = '0') else uPC_plus_1;
  uPC_Z1 <= uADR when (Z = '1') else uPC_plus_1;
  uPC_C0 <= uADR when (C = '0') else uPC_plus_1;
  uPC_C1 <= uADR when (C = '1') else uPC_plus_1;
  uPC_V0 <= uADR when (V = '0') else uPC_plus_1;
  uPC_V1 <= uADR when (V = '1') else uPC_plus_1;
  uPC_N1 <= uADR when (N = '1') else uPC_plus_1;

  -- mPC : micro Program Counter
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        uPC_s <= (others => '0');
      else
        case SEQ is 
          when uPC_INC => uPC_s <= uPC_plus_1;
          when uPC_ZERO => uPC_s <= (others => '0');
          when uPC_K1 => uPC_s <= K1Address;
          when uPC_K2 => uPC_s <= K2Address;
          when uPC_K3 => uPC_s <= K3Address;
          when uPC_uADR => uPC_s <= uADR; 
          when uPC_JMP_Z0 => uPC_s <= uPC_Z0;
          when uPC_JMP_Z1 => uPC_s <= uPC_Z1;
          when uPC_JMP_C0 => uPC_s <= uPC_C0;
          when uPC_JMP_C1 => uPC_s <= uPC_C1;
          when uPC_JMP_V0 => uPC_s <= uPC_V0;
          when uPC_JMP_V1 => uPC_s <= uPC_V1;
          when uPC_JMP_N1 => uPC_s <= uPC_N1;
          when others => uPC_s <= uPC_s;
        end case;
      end if;
    end if;
  end process;
end Behavioral;