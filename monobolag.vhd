library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Monobolag is
  port (
    clk, rst : in std_logic; -- rst är tryckknappen i mitten under displayen
    rx : in std_logic; -- Uart data
    vgaRed   : out std_logic_vector(2 downto 0);
		vgaGreen : out std_logic_vector(2 downto 0);
		vgaBlue  : out std_logic_vector(2 downto 1);
		Hsync    : out std_logic;
		Vsync    : out std_logic;
    JA 		 : inout  std_logic_vector (7 downto 0));
end entity;

architecture Behavioral of Monobolag is

  component UARTProgrammer
    port (
      clk, rst, rx : in std_logic;
      StartCPU : out std_logic;
      UARTData : out std_logic_vector(31 downto 0);
      UARTAddress : out unsigned(15 downto 0);
      UARTWriteEnable : out std_logic
    );
  end component;

  component uprogCPU
    port(
      clk                : in std_logic;
      rst                : in std_logic;
      StartCPU           : in std_logic;
      UARTAddress        : in unsigned(15 downto 0);
      UARTData           : in std_logic_vector(31 downto 0);
      UARTWriteEnable    : in std_logic;
      IOChipSelect       : out std_logic_vector(2 downto 0); -- VRAM, sprite och KBD 
      IOWriteEnable      : out std_logic;
      IOAddress          : out unsigned(15 downto 0); -- Address för VRAM och vilket sprite register.
      IODataOut          : out std_logic_vector(9 downto 0); -- T.ex. data som skickas till video ram, sprite reg 
      IODataIn           : in std_logic_vector(9 downto 0) -- Kunna läsa från video ram och sprite register
    );
  end component;

  component VGA_MOTOR
    port (
      clk      : in std_logic;
      VR_data  : in std_logic_vector(7 downto 0);
      VR_addr  : out unsigned(12 downto 0);
      rst      : in std_logic;
      vgaRed   : out std_logic_vector(2 downto 0);
      vgaGreen : out std_logic_vector(2 downto 0);
      vgaBlue  : out std_logic_vector(2 downto 1);
      Hsync    : out std_logic;
      Vsync    : out std_logic;
      sprite1X, sprite2X, sprite3X, sprite4X : in unsigned(9 downto 0);
      sprite1Y, sprite2Y, sprite3Y, sprite4Y : in unsigned(9 downto 0)
    );
  end component;

  component VIDEO_RAM
    port (
      clk        : in std_logic;
      cs 				 : in std_logic;
      we1        : in std_logic;
      data_in1   : in std_logic_vector(7 downto 0);
      addr1      : in unsigned(12 downto 0);
      data_out2  : out std_logic_vector(7 downto 0);
      addr2      : in unsigned(12 downto 0)
    );
  end component;

  component spriteTable
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
  end component;

  component PmodKYPD is
    port (
        clk : in  std_logic;
        rst : in std_logic;
        row : in  std_logic_vector (3 downto 0);
        col : out  std_logic_vector (3 downto 0);
        key : out  std_logic_vector (3 downto 0);
        strobe : out std_logic
    );
  end component;

  signal StartCPU           : std_logic;
  signal UARTAddress        : unsigned(15 downto 0);
  signal UARTData           : std_logic_vector(31 downto 0);
  signal UARTWriteEnable    : std_logic;
  signal IOChipSelect       : std_logic_vector(2 downto 0);
  signal IOWriteEnable      : std_logic;
  signal IOAddress          : unsigned(15 downto 0); 
  signal IODataOut          : std_logic_vector(9 downto 0);
  signal IODataIn           : std_logic_vector(9 downto 0);

  signal VRData             : std_logic_vector(7 downto 0);
  signal VRAddress          : unsigned(12 downto 0);
  signal readVR             : std_logic_vector(7 downto 0);

  signal sprite1X, sprite2X, sprite3X, sprite4X : unsigned(9 downto 0);
  signal sprite1Y, sprite2Y, sprite3Y, sprite4Y : unsigned(9 downto 0);
  signal SpriteValueOut : unsigned(9 downto 0);

  signal HexDataOut : std_logic_vector(3 downto 0);
  signal hexMem    : std_logic_vector(4 downto 0) := (others=>'0');
  signal strobe    : std_logic;

  --signal ClkDiv : unsigned(1 downto 0);
  signal Clock  : std_logic;
  --constant Divisor : unsigned(1 downto 0) := "01";

  signal reset : std_logic;
  
begin

  -- Clock divisor
	-- Divide system clock (100 MHz) by 2
	process(clk)
	begin
		if rising_edge(clk) then
      Clock <= not Clock;
		end if;
  end process;
  
  -- Extra reset signal som även gäller när cpu inte har startats av UART bootloadern.
  reset <= '1' when (rst = '1' or StartCPU = '0') else '0';

  UART : UARTProgrammer port map(clk=>Clock, rst=>rst, rx=>rx,
                                StartCPU=>StartCPU, 
                                UARTData=>UARTData, 
                                UARTAddress=>UARTAddress, 
                                UARTWriteEnable=>UARTWriteEnable);

  CPU : uprogCPU port map(clk=>Clock, rst=>reset, 
                          StartCPU=>StartCPU, 
                          UARTAddress=>UARTAddress, 
                          UARTData=>UARTData, 
                          UARTWriteEnable=>UARTWriteEnable, 
                          IOChipSelect=>IOChipSelect,
                          IOWriteEnable=>IOWriteEnable, 
                          IOAddress=>IOAddress, 
                          IODataOut=>IODataOut, 
                          IODataIn=>IODataIn);

  VGAMotor : VGA_MOTOR port map(clk=>Clock, rst=>rst, 
                                vgaRed=>vgaRed, vgaGreen=>vgaGreen, vgaBlue=>vgaBlue, Hsync=>Hsync, Vsync=>Vsync,
                                VR_data=>VRData, VR_addr=>VRAddress, 
                                sprite1X=>sprite1X, sprite2X=>sprite2X, sprite3X=>sprite3X, sprite4X=>sprite4X, 
                                sprite1Y=>sprite1Y, sprite2Y=>sprite2Y, sprite3Y=>sprite3Y, sprite4Y=>sprite4Y);

  VRAM : VIDEO_RAM port map(clk=>Clock, cs=>IOChipSelect(0), 
                            we1=>IOWriteEnable, data_in1=>IODataOut(7 downto 0),
                            addr1=>IOAddress(12 downto 0), data_out2=>VRData, addr2=>VRAddress);

  Sprites : spriteTable port map(clk=>Clock, 
                                  ChipSelect=>IOChipSelect(1),
                                  WriteEnable=>IOWriteEnable, 
                                  SpriteNum=>IOAddress(2 downto 0), 
                                  SpriteValueOut=>SpriteValueOut, 
                                  SpriteValueIn=>unsigned(IODataOut(9 downto 0)), 
                                  sprite1X=>sprite1X, sprite2X=>sprite2X, sprite3X=>sprite3X, sprite4X=>sprite4X, 
                                  sprite1Y=>sprite1Y, sprite2Y=>sprite2Y, sprite3Y=>sprite3Y, sprite4Y=>sprite4Y);

  HEX : PmodKYPD port map(clk=>clk, rst=>reset, 
                          key=>HexDataOut, strobe=>strobe, 
                          row=>JA(7 downto 4), col=>JA(3 downto 0));
  
  -- Tangentbords register.
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        hexMem <= (others => '0');
      elsif strobe = '1' then
        hexMem <= '1' & HexDataOut;
      else 
        hexMem <= '0' & hexMem(3 downto 0);
      end if;
    end if;
  end process;

  with IOChipSelect select
    IODataIn <= std_logic_vector(SpriteValueOut)  when "010",
                "00000" & hexMem                  when "100",
                (others => '0')                   when others;              

end Behavioral;