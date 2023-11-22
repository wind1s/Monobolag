library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UARTProgrammer is
  port (
    clk, rst, rx : in std_logic; -- rst är tryckknappen i mitten under displayen
    StartCPU : out std_logic;
    UARTData : out std_logic_vector(31 downto 0);
    UARTAddress : out unsigned(15 downto 0);
    UARTWriteEnable : out std_logic
    );
end UARTProgrammer;

architecture behavioral of UARTProgrammer is

  signal sreg : std_logic_vector(9 downto 0) := b"0_00000000_0"; -- 10 bit skiftregister
  signal Data : std_logic_vector(31 downto 0) := x"00000000";
  signal Address : unsigned(15 downto 0) := x"0000";
  signal rx1, rx2 : std_logic; -- vippor på insignalen
  signal sp : std_logic; -- skiftpuls
  signal lp : std_logic; -- laddpuls
  signal pos : unsigned(2 downto 0) := b"000";
  signal pos_load : std_logic;
  signal we : std_logic; -- write enable intern
  signal clock : unsigned(9 downto 0) := b"0000000000"; -- räknare i styrenhet
  signal bit_counter : unsigned(3 downto 0) := b"0000"; -- bit räknare för skiftpuls
  signal ce_styr : std_logic; -- count enable styrenhet

begin
  
  -- *****************************
  -- *  synkroniseringsvippor    *
  -- *****************************
  process (clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        rx1 <= '0';
        rx2 <= '0';
      else
        rx1 <= rx;
        rx2 <= rx1;
      end if;
    end if;
  end process;

  -- *****************************
  -- *       styrenhet           *
  -- *****************************
  process (clk) begin
    if rising_edge(clk) then
      sp <= '0';
      lp <= '0';

      if rst = '1' then
        ce_styr <= '0';
        clock <= (others => '0');
        bit_counter <= (others => '0');

      elsif ce_styr = '0' and ((not rx1) and rx2) = '1' then
        ce_styr <= '1';
        clock <= clock + 1;

      elsif ce_styr = '1' then
        clock <= clock + 1;

        if clock = 217 then
          sp <= '1';

        elsif clock = 433 then
          bit_counter <= bit_counter + 1;
          clock <= (others => '0');

          if bit_counter = 9 then
            ce_styr <= '0';
            bit_counter <= (others => '0');
            lp <= '1';
          end if;
        end if;
      else
        ce_styr <= '0';
        clock <= (others => '0');
        bit_counter <= (others => '0');
      end if;
    end if;
  end process;

  -- *****************************
  -- * 10 bit skiftregister      *
  -- *****************************
  process (clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        sreg <= (others => '0');
      elsif sp = '1' then
        sreg <= rx2 & sreg(9 downto 1);
      end if;
    end if;
  end process;

  -- ****************************
  -- * 3  bit räknare           *
  -- ****************************

  pos_load <= '1' when pos = 5 else '0';

  process (clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        pos <= (others => '0');
      elsif lp = '1' then
        if pos_load = '1' then
          pos <= (others => '0');
        else
          pos <= pos + 1;
        end if;
      end if;
    end if;
  end process;

  -- *****************************
  -- * 32 bit register           *
  -- *****************************
  process (clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        we <= '0';
        Data <= (others => '0');
        Address <= (others => '0');
      elsif lp = '1' then
        if pos_load = '1' then
          we <= '1';
        end if;

        case pos is
          when "000" => Data(7 downto 0) <= sreg(8 downto 1);
          when "001" => Data(15 downto 8) <= sreg(8 downto 1);
          when "010" => Data(23 downto 16) <= sreg(8 downto 1);
          when "011" => Data(31 downto 24) <= sreg(8 downto 1);
          when "100" => Address(7 downto 0) <= unsigned(sreg(8 downto 1));
          when "101" => Address(15 downto 8) <= unsigned(sreg(8 downto 1));
          when others => Data <= (others => '0'); Address <= (others => '0');
        end case;

      else
        we <= '0';
      end if;
    end if;
  end process;

  
  -- ***************
  -- * Write enhet *
  -- ***************
  process (clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        StartCPU <= '0';
        UARTWriteEnable <= '0';
        UARTAddress <= (others => '0');
        UARTData <= (others => '0');
      else 
        UARTWriteEnable <= we;

        if we = '1' then
          if Address = x"FFFF" then
            StartCPU <= '1';
          else
            StartCPU <= '0';
            UARTAddress <= Address;
            UARTData <= Data;
          end if;
        end if;  
      end if;
    end if;
  end process;

end behavioral;