library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- MMU interface
entity MMU is
    port(
         --internal buses
        AddressOut               :  out unsigned(15 downto 0);
        DataOut                  :  out std_logic_vector(31 downto 0);
        DataIn                   :  in std_logic_vector(19 downto 0);
        --ext signals    
        DatabusIn                :  in std_logic_vector(19 downto 0);
        DatabusOut               :  out std_logic_vector(19 downto 0);
        AddressbusIn             :  in unsigned(15 downto 0);
        UARTAddress              :  in unsigned(15 downto 0);
        UARTData                 :  in std_logic_vector(31 downto 0);
        StartCPU                 :  in std_logic;
        UARTWriteEnable          :  in std_logic;
        --write enable
        PMWriteEnable            :  out std_logic;
        WriteEnableOut           :  out std_logic;
        WriteEnableIn            :  in std_logic;
        -- PM, DM, Stack, VRAM, Sprite, KBD
        ChipSelect               :  out std_logic_vector(5 downto 0) 
        );
end entity;

architecture Behavioral of MMU is

    signal CS_PM, CS_DM, CS_Stack, CS_VR, CS_Sprite, CS_KBD : std_logic;
    signal Address : unsigned(15 downto 0);
    signal WriteEnable : std_logic;

    --CONSTANT LIMITS
    constant PMStart        : unsigned(15 downto 0) := x"0000"; 
    constant PMEnd          : unsigned(15 downto 0) := x"07FF";
    constant DMStart        : unsigned(15 downto 0) := x"0800"; 
    constant DMEnd          : unsigned(15 downto 0) := x"0FFF";
    constant StackStart     : unsigned(15 downto 0) := x"1000";
    constant StackEnd       : unsigned(15 downto 0) := x"13FF";
    constant VRStart        : unsigned(15 downto 0) := x"1400";
    constant VREnd          : unsigned(15 downto 0) := x"26BF";
    constant SpriteStart    : unsigned(15 downto 0) := x"26C0"; 
    constant SpriteEnd      : unsigned(15 downto 0) := x"26C7"; 
    constant KBDAddress     : unsigned(15 downto 0) := x"26C8"; 

begin

    Address <= AddressbusIn when (StartCPU = '1') else UARTAddress;
    WriteEnable <= WriteEnableIn when (StartCPU = '1') else UARTWriteEnable;

    CS_PM <= '1' when Address >= PMStart and Address <= PMEnd else '0';
    CS_DM <= '1' when (Address >= DMStart and Address <= DMEnd) else '0';
    CS_Stack <= '1' when (Address >= StackStart and Address <= StackEnd) else '0';
    CS_VR <= '1' when (Address >= VRStart and Address <= VREnd) else '0';
    CS_Sprite <= '1' when (Address >= SpriteStart and Address <= SpriteEnd) else '0';
    CS_KBD <= '1' when (Address = KBDAddress) else '0';

    ChipSelect <= CS_KBD & CS_Sprite & CS_VR & CS_Stack & CS_DM & CS_PM;

    PMWriteEnable <= '1' when (WriteEnable = '1' and StartCPU = '0') else '0';
    WriteEnableOut <= '1' when (WriteEnable = '1' and Address < KBDAddress) else '0'; -- Mindre än den sista skrivbara adressen.

    --ADRESS DECODING
    AddressOut <= (Address - PMStart) when (CS_PM = '1') else 
                  (Address - DMStart) when (CS_DM = '1') else
                  (Address - StackStart) when (CS_Stack = '1') else 
                  (Address - VRStart) when (CS_VR = '1') else
                  (Address - SpriteStart) when (CS_Sprite = '1') else
                  (others => '0');
                  

    -- DATA FROM MMU
    DataOut <= "000000000000" & DatabusIn when (StartCPU = '1') else UARTData;


    --DATA BUS ASSIGNMENT
    DatabusOut <= DataIn when (StartCPU = '1') else (others => '0');

end Behavioral;