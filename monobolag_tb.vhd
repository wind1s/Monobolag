library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Monobolag_tb is
end Monobolag_tb;

architecture behavior of Monobolag_tb is
  
  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal rx : std_logic := '1';

  signal tb_running : boolean := true;
  signal rxs : unsigned(0 to 39) := b"0_10001100_10_01001100_10_11001100_10_00101100_1";

begin
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

    wait until rising_edge(clk); -- se till att reset släpps synkront
    -- med klockan
    rst <= '0';
    report "reset released" severity note;
    wait for 1 us;

    -- SKRIV EGEN TESTBÄNK HÄRIFRÅN

    for i in 0 to 39 loop
      rx <= rxs(i);
      wait for 8.68 us;
    end loop; -- i

    for i in 0 to 50000000 loop -- vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop; -- i

    tb_running <= false; -- stanna klockan (vilket medför att inga
    -- nya event genereras vilket stannar
    -- simuleringen).
    wait;
  end process;

end;