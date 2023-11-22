library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity K2 is
  port(
    AddressIn      : in unsigned(2 downto 0);
    AddressOut     : out unsigned(6 downto 0)
    );
end K2;

architecture Behavioral of K2 is

  type table_t is array (0 to 7) of unsigned(6 downto 0);
  constant K2_c : table_t :=
  (
    0 => b"0000010",
    1 => b"0000011",
    2 => b"0000100",
    3 => b"0000101",
    4 => b"0000110",
    5 => b"0000100",
    6 => b"0000101",
    7 => b"0000110"
  );
  signal K2 : table_t := K2_c;

begin
  
  AddressOut <= K2(to_integer(AddressIn));

end Behavioral;