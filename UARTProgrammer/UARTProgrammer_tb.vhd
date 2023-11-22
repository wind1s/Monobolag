library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UARTProgrammer_tb is
end UARTProgrammer_tb;

architecture behavior of UARTProgrammer_tb is

  component UARTProgrammer
    port (
      clk, rst, rx : in std_logic; -- rst är tryckknappen i mitten under displayen
      StartCPU : out std_logic;
      UARTData : out std_logic_vector(31 downto 0);
      UARTAddress : out unsigned(15 downto 0);
      UARTWriteEnable : out std_logic
      );
  end component;

  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal rx : std_logic := '1';
  signal StartCPU : std_logic;
  signal UARTData : std_logic_vector(31 downto 0);
  signal UARTAddress : unsigned(15 downto 0);
  signal UARTWriteEnable : std_logic;

  signal tb_running : boolean := true;
  signal rxs : unsigned(0 to 179) := b"0_10000000_10_01000000_10_11000000_10_00100000_10_00000000_10_00000000_10_10000000_10_11000000_10_10100000_10_11100000_10_11111111_10_11111111_10_10000000_10_01000000_10_11000000_10_00100000_10_00000000_10_00000000_1";
  
begin

  uart : UARTProgrammer port map(clk=>clk, rst=>rst, rx=>rx, 
                                  StartCPU=>StartCPU, 
                                  UARTData=>UARTData, 
                                  UARTAddress=>UARTAddress, 
                                  UARTWriteEnable=>UARTWriteEnable);
  
  clk_gen : process
  begin
    while tb_running loop
      clk <= '0';
      wait for 5 ns;
      clk <= '1';
      wait for 5 ns;
    end loop;
    wait;
  end process;

  stimuli_generator : process
    variable i : integer;
  begin
    -- aktivera reset ett litet tag.
    rst <= '1';
    wait for 500 ns;

    wait until rising_edge(clk); -- se till att reset släpps synkront med klockan
    rst <= '0';
    report "reset released" severity note;
    wait for 1 us;

    for i in 0 to 179 loop
      rx <= rxs(i);
      wait for 8.68 us;
    end loop;

    for i in 0 to 500000 loop -- vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop; 

    tb_running <= false;
    wait;
  end process;

end;