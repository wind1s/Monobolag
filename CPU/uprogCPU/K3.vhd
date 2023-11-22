library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity K3 is
  port(
    AddressIn      : in unsigned(2 downto 0);
    AddressOut     : out unsigned(6 downto 0)
    );
end K3;

architecture Behavioral of K3 is

  type table_t is array (0 to 7) of unsigned(6 downto 0);
  constant K3_c : table_t :=
  (
    0 => b"0001000",
    1 => b"0001000",
    2 => b"0001000",
    3 => b"0001000",
    4 => b"0001000",
    5 => b"0001001",
    6 => b"0001010",
    7 => b"0001011"
  );
  signal K3 : table_t := K3_c;

begin
  
  AddressOut <= K3(to_integer(AddressIn));

end Behavioral;