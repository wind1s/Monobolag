library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--CPU interface
entity uprogCPU is
  port(
    clk                          : in std_logic;
    rst                          : in std_logic;
    StartCPU                     : in std_logic;
    UARTAddress                  : in unsigned(15 downto 0);
    UARTData                     : in std_logic_vector(31 downto 0);
    UARTWriteEnable              : in std_logic;
    IOChipSelect                 : out std_logic_vector(2 downto 0); -- VRAM, sprite och KBD 
    IOWriteEnable                : out std_logic;
    IOAddress                    : out unsigned(15 downto 0); -- Address för VRAM och vilket sprite register.
    IODataOut                    : out std_logic_vector(9 downto 0); -- T.ex. data som skickas till video ram, sprite reg 
    IODataIn                     : in std_logic_vector(9 downto 0) -- Kunna läsa från video ram och sprite register
  );
end entity;

architecture func of uprogCPU is
  -- micro Memory component
  component uMem
    port (
      Address                    : in unsigned(6 downto 0);
      Data                       : out std_logic_vector(25 downto 0)
    );
  end component;

  -- program Memory component.
  component PM
    port(
      clk                        : in std_logic;
      ChipSelect                 : in std_logic;
      WriteEnable                : in std_logic;
      Address                    : in unsigned(10 downto 0);
      DataIn                     : in std_logic_vector(31 downto 0);
      DataOut                    : out std_logic_vector(31 downto 0)
      );
  end component;

  -- Data memory component.
  component DM
    port(
      clk                        : in std_logic;
      ChipSelect                 : in std_logic;
      WriteEnable                : in std_logic;
      Address                    : in unsigned(10 downto 0);
      DataIn                     : in std_logic_vector(19 downto 0);
      DataOut                    : out std_logic_vector(19 downto 0)
      );
  end component; 

  -- Stack memory component.
  component Stack
    port(
      clk                        : in std_logic;
      ChipSelect                 : in std_logic;
      WriteEnable                : in std_logic;
      Address                    : in unsigned(9 downto 0);
      DataIn                     : in std_logic_vector(19 downto 0);
      DataOut                    : out std_logic_vector(19 downto 0)
      );
  end component;

 -- ALU component
  component ALU
    port(
        clk                      : in std_logic;
        rst                      : in std_logic; 
        A                        : in unsigned(19 downto 0);
        B                        : in unsigned(19 downto 0);
        Rx                       : in unsigned(19 downto 0);
        IR_address               : in unsigned(15 downto 0);
        SR                       : out std_logic_vector(3 downto 0);
        AR                       : out unsigned(19 downto 0); 
        Operation                : in std_logic_vector(3 downto 0)
      );
  end component;

 -- MMU component
  component MMU  
    port(
        --internal buses
        AddressOut               : out unsigned(15 downto 0);
        DataOut                  : out std_logic_vector(31 downto 0);
        DataIn                   : in std_logic_vector(19 downto 0);
        --ext signals
        DatabusIn                : in std_logic_vector(19 downto 0);
        DatabusOut               : out std_logic_vector(19 downto 0);
        AddressbusIn             : in unsigned(15 downto 0);
        UARTAddress              : in unsigned(15 downto 0);
        UARTData                 : in std_logic_vector(31 downto 0);
        StartCPU                 : in std_logic;
        UARTWriteEnable          : in std_logic;
        --write enable
        PMWriteEnable            : out std_logic;
        WriteEnableOut           : out std_logic;
        WriteEnableIn            : in std_logic;
        ChipSelect               : out std_logic_vector(5 downto 0) -- PM, DM, Stack, VRAM, Sprite, KBD
      );
  end component;

  -- Register table component
  component regTable
    port(
        clk, rst                 : in std_logic;
        ModCode                  : in unsigned(2 downto 0);
        RaAddress                : in unsigned(3 downto 0);
        RdAddress                : in unsigned(3 downto 0); 
        RdWriteEnable            : in std_logic;
        Rd                       : in unsigned(19 downto 0);
        Rx, RaOut, RdOut         : out unsigned(19 downto 0)
      );
  end component;

  --K-COMPONENTS
  component K1
    port(
      AddressIn                  : in unsigned(4 downto 0);
      AddressOut                 : out unsigned(6 downto 0) 
    );
  end component;
  
  component K2
    port(
      AddressIn                  : in unsigned(2 downto 0);
      AddressOut                 : out unsigned(6 downto 0)
    );
  end component;

  component K3
    port(
      AddressIn                  : in unsigned(2 downto 0);
      AddressOut                 : out unsigned(6 downto 0)
    );
  end component;

  component MicroPC
    port (
      clk, rst    : in std_logic;
      SEQ         : in std_logic_vector(3 downto 0);
      SR          : in std_logic_vector(3 downto 0);
      uADR        : in unsigned(6 downto 0);
      K1Address   : in unsigned(6 downto 0);
      K2Address   : in unsigned(6 downto 0);
      K3Address   : in unsigned(6 downto 0);
      uPC         : out unsigned(6 downto 0)
    );
  end component;

  -- micro memory signals //IR-data
  signal uM                      : std_logic_vector(25 downto 0); -- micro Memory output
  alias ALU_OP                   : std_logic_vector(3 downto 0) is uM(25 downto 22);
  alias TDB                      : std_logic_vector(2 downto 0) is uM(21 downto 19);
  alias FDB                      : std_logic_vector(2 downto 0) is uM(18 downto 16);
  alias TAB                      : std_logic_vector(2 downto 0) is uM(15 downto 13);
  alias P                        : std_logic_vector(1 downto 0) is uM(12 downto 11);
  alias SEQ                      : std_logic_vector(3 downto 0) is uM(10 downto 7); 
  alias uADR                     : std_logic_vector(6 downto 0) is uM(6 downto 0);

  -- local registers
  signal uPC                     : unsigned(6 downto 0) := (others => '0'); 
  signal PC                      : unsigned(10 downto 0) := (others => '0');
  signal SP                      : unsigned(15 downto 0) := x"13FF"; 
  signal HR                      : unsigned(19 downto 0) := (others => '0');

  -- register table signals
  signal Rx, RdFromBus, RaOut, RdOut : unsigned(19 downto 0);
  signal RdWriteEnable           : std_logic;

  -- ALU signals
  signal AR, Mux1, Mux2          : unsigned(19 downto 0);
  signal SR                      : std_logic_vector(3 downto 0);
  alias Z                        : std_logic is SR(3);
  alias N                        : std_logic is SR(2);
  alias C                        : std_logic is SR(1);
  alias V                        : std_logic is SR(0);
  
  -- MMU registers
  signal DATAWriteEnable  : std_logic;
  signal DATA_out         : std_logic_vector(19 downto 0) := (others => '0');
  signal DATA_in          : std_logic_vector(19 downto 0) := (others => '0');
  signal MMUDataOut       : std_logic_vector(31 downto 0);
  signal MMUDataIn        : std_logic_vector(19 downto 0);
  signal MMUAddrOut       : unsigned(15 downto 0);
  signal MMUWriteEnable   : std_logic;
  signal MMUChipSelect    : std_logic_vector(5 downto 0);

  -- Program memory signals
  signal PMWriteEnable    : std_logic;
  alias PMChipSelect      : std_logic is MMUChipSelect(0);
  signal IR_Data          : std_logic_vector(31 downto 0);

  -- Data memory signals
  alias DMChipSelect      : std_logic is MMUChipSelect(1);
  signal DMData_out       : std_logic_vector(19 downto 0);

  -- Stack memory signals
  alias StackChipSelect   : std_logic is MMUChipSelect(2);
  signal StackData_out    : std_logic_vector(19 downto 0);

  -- K1, K2, K3 signals
  signal K1Address, K2Address, K3Address : unsigned(6 downto 0);

  -- Instruktions register
  signal IR               : unsigned(31 downto 0); -- Instruction Register
  alias OP                : unsigned(4 downto 0) is IR(31 downto 27);
  alias IR_Mod            : unsigned(2 downto 0) is IR(26 downto 24);
  alias RdAddr            : unsigned(3 downto 0) is IR(23 downto 20);
  alias RaAddr            : unsigned(3 downto 0) is IR(19 downto 16);
  alias IR_Address        : unsigned(15 downto 0) is IR(15 downto 0);
  alias IR_Konstant       : unsigned(19 downto 0) is IR(19 downto 0);


  -- local combinatorials
  signal DATA_BUS         : std_logic_vector(19 downto 0); -- Data Bus
  signal ADDR_BUS         : unsigned(15 downto 0); -- Address Bus

  constant OMEDELBAR_MOD        : unsigned(2 downto 0) := "000";
  constant DIREKT_REGISTER_MOD  : unsigned(2 downto 0) := "001";
  constant DIREKT_FRAN_MOD      : unsigned(2 downto 0) := "010";
  constant INDIREKT_FRAN_MOD    : unsigned(2 downto 0) := "011";
  constant INDEXERAD_FRAN_MOD   : unsigned(2 downto 0) := "100";
  constant DIREKT_TILL_MOD      : unsigned(2 downto 0) := "101";
  constant INDIREKT_TILL_MOD    : unsigned(2 downto 0) := "110";
  constant INDEXERAD_TILL_MOD   : unsigned(2 downto 0) := "111";

begin
  -- micro memory component connection
  uMemory : uMem port map(Address=>uPC, Data=>uM);

  -- K-component connections
  K1Comp : K1 port map(AddressIn=>OP, AddressOut=>K1Address);
  K2Comp : K2 port map(AddressIn=>IR_Mod, AddressOut=>K2Address);
  K3Comp : K3 port map(AddressIn=>IR_Mod, AddressOut=>K3Address);

  uPCComp : MicroPC port map(clk=>clk, rst=>rst, 
                              SEQ=>SEQ, SR=>SR, uADR=>unsigned(uADR), uPC=>uPC,
                              K1Address=>K1Address, K2Address=>K2Address, K3Address=>K3Address);

  with IR_Mod select
    Mux1 <= RaOut when DIREKT_REGISTER_MOD | DIREKT_TILL_MOD | INDIREKT_TILL_MOD | INDEXERAD_TILL_MOD,
            unsigned(DATA_BUS) when others;
  
  with IR_Mod select
    Mux2 <= RdOut when OMEDELBAR_MOD | DIREKT_REGISTER_MOD | DIREKT_FRAN_MOD | INDIREKT_FRAN_MOD | INDEXERAD_FRAN_MOD,
            unsigned(DATA_BUS) when others;
  
  -- ALU component connection
  ALUComp : ALU port map(clk=>clk, rst=>rst, AR=>AR, SR=>SR, 
                          A=>Mux1, B=>Mux2, Rx=>Rx, 
                          IR_Address=>IR_Address, Operation=>ALU_OP); 

  IOWriteEnable <= MMUWriteEnable;
  IOChipSelect <= MMUChipSelect(5 downto 3);
  IODataOut <= MMUDataOut(9 downto 0);
  IOAddress <= MMUAddrOut;

  MMUDataIn <= DMData_out when (DMChipSelect = '1') else
                StackData_out when (StackChipSelect = '1') else
                "0000000000" & IODataIn;

  MMUComp : MMU port map(AddressOut=>MMUAddrOut, DataOut=>MMUDataOut, DataIn=>MMUDataIn,
    DatabusIn=>DATA_in, DatabusOut=>DATA_out, AddressbusIn=>ADDR_BUS, 
    UARTData=>UARTData, UARTAddress=>UARTAddress, StartCPU=>StartCPU, UARTWriteEnable=>UARTWriteEnable,
    WriteEnableIn=>DATAWriteEnable, PMWriteEnable=>PMWriteEnable, 
    WriteEnableOut=>MMUWriteEnable, ChipSelect=>MMUChipSelect); 

  RegisterTable : regTable port map(clk=>clk, rst=>rst, ModCode=>IR_Mod, RaAddress=>RaAddr, RdAddress=>RdAddr, 
    RdWriteEnable=>RdWriteEnable, Rd=>RdFromBus, Rx=>Rx, RaOut=>RaOut, RdOut=>RdOut); 

  ProgramMemory : PM 
    port map(clk=>clk, ChipSelect=>PMChipSelect, WriteEnable=>PMWriteEnable, 
      Address=>MMUAddrOut(10 downto 0), DataIn=>MMUDataOut, DataOut=>IR_Data); 

  DataMemory : DM
    port map(clk=>clk, ChipSelect=>DMChipSelect, WriteEnable=>MMUWriteEnable, 
      Address=>MMUAddrOut(10 downto 0), DataIn=>MMUDataOut(19 downto 0), DataOut=>DMData_out);

  StackMemory : Stack
    port map(clk=>clk, ChipSelect=>StackChipSelect, WriteEnable=>MMUWriteEnable, 
      Address=>MMUAddrOut(9 downto 0), DataIn=>MMUDataOut(19 downto 0), DataOut=>StackData_out);

  -- TO data bus assignment.
  with TDB select
    DATA_BUS <= std_logic_vector(IR_Konstant)       when "001",
                DATA_out                            when "010",
                std_logic_vector("000000000" & PC)  when "011",
                std_logic_vector(AR)                when "100",
                std_logic_vector(HR)                when "101",
                std_logic_vector(Rx)                when "110",
                (others => '0')                     when others;

  -- TO addr bus assignment.
  with TAB select
    ADDR_BUS <= IR_Address      when "001",
                SP              when "010",
                "00000" & PC    when "011",
                AR(15 downto 0) when "100",
                Rx(15 downto 0) when "110",
                (others => '0') when others;

  DATA_in <= DATA_BUS when (FDB = "010") else (others => '0');
  DATAWriteEnable <= '1' when (FDB = "010") else '0';

  RdFromBus <= unsigned(DATA_BUS) when (FDB = "110") else (others => '0');
  RdWriteEnable <= '1' when (FDB = "110") else '0';

  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        HR <= (others => '0');
        IR <= (others => '0');

      else
        if FDB = "101" then
          HR <= unsigned(DATA_BUS);
        else
          HR <= HR;
        end if;
        
        -- bara när PC till adressbuss
        if PMChipSelect = '1' and StartCPU = '1' and TAB = "011" then
          IR <= unsigned(IR_Data);
        else
          IR <= IR;
        end if;
      end if;
    end if;
  end process;
	
  -- PC, Program Counter 
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        PC <= (others => '0');
      elsif FDB = "011" then
        PC <= unsigned(DATA_BUS(10 downto 0));
      elsif P = "01" then
        PC <= PC + 1;
      else
        PC <= PC;
      end if;
    end if;
  end process;

  -- SP, Stack Pointer
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        SP <= x"13FF";
      else
        case P is
          when "10" => SP <= (SP + 1);
          when "11" => SP <= (SP - 1);
          when others => SP <= SP;
        end case;
      end if;
    end if;
  end process;

end architecture;
