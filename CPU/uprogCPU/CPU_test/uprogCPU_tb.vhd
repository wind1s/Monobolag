LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY uprogCPU_tb IS
END uprogCPU_tb;

ARCHITECTURE func OF uprogCPU_tb IS

  --Component Declaration for the Unit Under Test (UUT)
  component uprogCPU
    port(
      clk              : in std_logic;
      rst              : in std_logic;
      StartCPU         : in std_logic;
      UARTAddress      : in unsigned(15 downto 0);
      UARTData         : in std_logic_vector(31 downto 0);
      UARTWriteEnable  : in std_logic;
      IOChipSelect     : out std_logic_vector(2 downto 0); -- VRAM, sprite och KBD 
      IOWriteEnable    : out std_logic;
      IOAddress        : out unsigned(15 downto 0); -- Address för VRAM och vilket sprite register.
      IODataOut        : out std_logic_vector(9 downto 0); -- T.ex. data som skickas till video ram, sprite reg 
      IODataIn         : in std_logic_vector(9 downto 0) -- Kunna läsa från video ram och sprite register
    );
  end component;

  --CPU ports
  signal clk              : std_logic := '0';
  signal rst              : std_logic := '0';
  signal IOChipSelect     : std_logic_vector(2 downto 0); 
  signal IOWriteEnable    : std_logic;
  signal IOAddress        : unsigned(15 downto 0);
  signal IODataOut        : std_logic_vector(9 downto 0);
  signal IODataIn         : std_logic_vector(9 downto 0);

  --local signals
  signal tb_running : boolean := true;

BEGIN
  -- Instantiate the Unit Under Test (UUT)
  cpu : uprogCPU PORT MAP (
    clk => clk,
    rst => rst,
    StartCPU => '1',
    UARTAddress => (others => '0'),
    UARTData => (others => '0'),
    UARTWriteEnable => '0',
    IOChipSelect => IOChipSelect,
    IOWriteEnable => IOWriteEnable,
    IOAddress => IOAddress,
    IODataOut => IODataOut,
    IODataIn => (others => '0')
  );
		
  -- Clock process definitions
  clk_gen : process
  begin
    while tb_running loop
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
    end loop;
    wait;
  end process;

  test : process
  begin
    -- aktivera reset ett litet tag.
    rst <= '1';
    wait for 500 ns;
    wait until rising_edge(clk); -- se till att reset släpps synkront
    -- med klockan
    rst <= '0';
    report "reset released" severity note;
    wait for 1 us;

    for i in 0 to 10000 loop -- vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop; -- i

    tb_running <= false;

  end process;

	rst <= '1', '0' after 1 us;
END;

