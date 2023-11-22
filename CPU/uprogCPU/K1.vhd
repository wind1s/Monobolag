library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity K1 is
  port(
    AddressIn      : in unsigned(4 downto 0);
    AddressOut     : out unsigned(6 downto 0)
    );
end K1;

architecture Behavioral of K1 is

  type table_t is array (0 to 31) of unsigned(6 downto 0);
  constant K1_c : table_t :=
  (
    0 =>  b"0001101", --NOP
    1 =>  b"0001111", --JMP
    2 =>  b"0011100", --CALL
    3 =>  b"0011110", --RET
    4 =>  b"0100000", --PUSH
    5 =>  b"0100001", --POP
    6 =>  b"0010000", --MOV
    7 =>  b"0100011", --JEQ
    8 =>  b"0100101", --JNE
    9 =>  b"0100111", --JGT
    10 => b"0101000", --JGE
    11 => b"0101110", --JLT
    12 => b"0101101", --JLE
    13 => b"0110000", --JCS
    14 => b"0011010", --CMP
    15 => b"0010010", --ADD
    16 => b"0010011", --SUB
    17 => b"0010100", --MUL
    18 => b"0010101", --INC
    19 => b"0010110", --DEC
    20 => b"0010111", --AND
    21 => b"0011000", --OR
    22 => b"0011001", --XOR
    23 => b"0110100", --LSR
    24 => b"0110101", --LSL
    25 => b"0011011", --CLR
    26 => b"0110100", --MOVZ
    27 => b"0110110", --ADDZ
    28 => b"0111000", --MULZ
    29 => b"0111010", --ANDZ
    30 => b"0111100", --ORZ
    31 => b"0001110", --HALT
    others => (others => '0')
  );
  signal K1 : table_t := K1_c;

begin
  
  AddressOut <= K1(to_integer(AddressIn));

end Behavioral;