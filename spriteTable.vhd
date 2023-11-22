library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity spriteTable is
  port(
      clk : in std_logic;
      ChipSelect : in std_logic;
      WriteEnable : in std_logic;
      SpriteNum : in unsigned(2 downto 0); 
      SpriteValueOut : out unsigned(9 downto 0);
      SpriteValueIn  : in unsigned(9 downto 0);
      sprite1X, sprite2X, sprite3X, sprite4X : out unsigned(9 downto 0);
      sprite1Y, sprite2Y, sprite3Y, sprite4Y : out unsigned(9 downto 0)
    );
end entity;

architecture Behavioral of spriteTable is

  type sprites_t is array (0 to 7) of unsigned(9 downto 0);
  signal sprites : sprites_t := (others => (others=>'0'));

begin
  
  SpriteValueOut <= sprites(to_integer(SpriteNum));

  process(clk) begin
    if rising_edge(clk) then
      if (WriteEnable = '1' and ChipSelect = '1') then
        sprites(to_integer(SpriteNum)) <= SpriteValueIn;
      end if;
    end if;
  end process;

  sprite1X <= sprites(0);
  sprite1Y <= sprites(1);
  sprite2X <= sprites(2);
  sprite2Y <= sprites(3);
  sprite3X <= sprites(4);
  sprite3Y <= sprites(5);
  sprite4X <= sprites(6);
  sprite4Y <= sprites(7);

end Behavioral;
