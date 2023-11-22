library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- register table interface
entity regTable is
  port(
      clk, rst : in std_logic;
      ModCode : in unsigned(2 downto 0);
      RaAddress, RdAddress : in unsigned(3 downto 0); 
      RdWriteEnable : in std_logic;
      Rd : in unsigned(19 downto 0);
      Rx, RaOut, RdOut : out unsigned(19 downto 0)
    );
end entity;

architecture Behavioral of regTable is

  -- register Memory
  type reg_t is array (0 to 15) of unsigned(19 downto 0);
  constant reg_c : reg_t := (others => (others => '0'));
  signal registers : reg_t := reg_c;

  signal RdData : unsigned(19 downto 0);
  signal RaData : unsigned(19 downto 0);

  constant OMEDELBAR_MOD        : unsigned(2 downto 0) := "000";
  constant DIREKT_REGISTER_MOD  : unsigned(2 downto 0) := "001";
  constant DIREKT_FRAN_MOD      : unsigned(2 downto 0) := "010";
  constant INDIREKT_FRAN_MOD    : unsigned(2 downto 0) := "011";
  constant INDEXERAD_FRAN_MOD   : unsigned(2 downto 0) := "100";
  constant DIREKT_TILL_MOD      : unsigned(2 downto 0) := "101";
  constant INDIREKT_TILL_MOD    : unsigned(2 downto 0) := "110";
  constant INDEXERAD_TILL_MOD   : unsigned(2 downto 0) := "111";

begin
  
  RdData <= registers(to_integer(RdAddress));
  RaData <= registers(to_integer(RaAddress));

  with ModCode select
    Rx <= RdData when OMEDELBAR_MOD | DIREKT_TILL_MOD | INDIREKT_TILL_MOD | INDEXERAD_TILL_MOD,
          RaData when DIREKT_REGISTER_MOD | DIREKT_FRAN_MOD | INDIREKT_FRAN_MOD | INDEXERAD_FRAN_MOD,
          (others => '0') when others;

  RdOut <= RdData;
  RaOut <= RaData;

  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        registers <= (others => (others => '0'));
      elsif RdWriteEnable = '1' then
        registers(to_integer(RdAddress)) <= Rd;
      end if;
    end if;
  end process;

end Behavioral;
