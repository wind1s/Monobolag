library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- register table interface
entity ALU is
    port(
        clk              : in std_logic;  
        rst              : in std_logic;
        A                : in unsigned(19 downto 0);
        B                : in unsigned(19 downto 0);
        Rx               : in unsigned(19 downto 0);
        IR_address       : in unsigned(15 downto 0);
        SR               : out std_logic_vector(3 downto 0);
        AR               : out unsigned(19 downto 0); 
        Operation        : in std_logic_vector(3 downto 0));
end entity;

architecture Behavioral of ALU is

  signal AR_s    : unsigned(19 downto 0);
  signal SR_s    : std_logic_vector(3 downto 0);
  --SR SIGNALS
  alias Z        : std_logic is SR_s(3);
  alias N        : std_logic is SR_s(2);
  alias C        : std_logic is SR_s(1);
  alias V        : std_logic is SR_s(0);

  -- SR CANDIDATES
  signal Zc, Nc, Cc, Vc : std_logic;
  signal Result         : unsigned(39 downto 0);

  alias A_sign_bit      : std_logic is A(19);
  alias B_sign_bit      : std_logic is B(19);
  alias Result_sign_bit : std_logic is Result(19);
  alias Carry_bit       : std_logic is Result(20);
  alias Mul_high_bit    : std_logic is Result(39);

  constant NOP            : std_logic_vector(3 downto 0) := "0000";
  constant ZERO_OP        : std_logic_vector(3 downto 0) := "0001";
  constant ADDRESS_CALC   : std_logic_vector(3 downto 0) := "0010";
  constant ADD_OP         : std_logic_vector(3 downto 0) := "0011";
  constant SUB_OP         : std_logic_vector(3 downto 0) := "0100";
  constant MUL_OP         : std_logic_vector(3 downto 0) := "0101";
  constant AND_OP         : std_logic_vector(3 downto 0) := "0110";
  constant OR_OP          : std_logic_vector(3 downto 0) := "0111";
  constant XOR_OP         : std_logic_vector(3 downto 0) := "1000";
  constant SHIFT_LEFT_OP  : std_logic_vector(3 downto 0) := "1001";
  constant SHIFT_RIGHT_OP : std_logic_vector(3 downto 0) := "1010";
  constant INC_OP         : std_logic_vector(3 downto 0) := "1011";
  constant DEC_OP         : std_logic_vector(3 downto 0) := "1100";
  constant SEND_A         : std_logic_vector(3 downto 0) := "1101";

begin  -- Behavioral

  --FLAG CALCULATION
  Zc <= '1' when (Operation = MUL_OP and Result = 0) else
        '1' when (Operation /= MUL_OP and Result(19 downto 0) = 0) else
        '0';

  Nc <= Mul_high_bit when Operation = MUL_OP else Result_sign_bit;
      
  Cc <= Mul_high_bit when Operation = MUL_OP else Carry_bit;

  Vc <= (not A_sign_bit and not B_sign_bit and Result_sign_bit) or 
        (A_sign_bit and B_sign_bit and not Result_sign_bit) when Operation = ADD_OP else 
        (not A_sign_bit and B_sign_bit and Result_sign_bit) or
        (A_sign_bit and not B_sign_bit and not Result_sign_bit) when Operation = SUB_OP else 
        (A_sign_bit xor Result_sign_bit) when Operation = SHIFT_LEFT_OP or Operation = SHIFT_RIGHT_OP else
        '0';

  -- ALU Operations
  with Operation select
      Result <= (others => '0') when ZERO_OP,
                to_unsigned(0, 20) & ((Rx) + ("0000" & IR_address)) when ADDRESS_CALC,
                to_unsigned(0, 19) & (('0' & B) + ('0' & A)) when ADD_OP,
                to_unsigned(0, 19) & (('0' & B) - ('0' & A)) when SUB_OP,
                (B * A) when MUL_OP,
                to_unsigned(0, 20) & (B and A) when AND_OP,
                to_unsigned(0, 20) & (B or A) when OR_OP,
                to_unsigned(0, 20) & (B xor A) when XOR_OP,
                to_unsigned(0, 19) & (B(19 downto 0) & '0') when SHIFT_LEFT_OP,
                to_unsigned(0, 19) & ("00" & B(19 downto 1)) when SHIFT_RIGHT_OP,
                to_unsigned(0, 19) & (('0' & B) + 1) when INC_OP,
                to_unsigned(0, 19) & (('0' & B) - 1) when DEC_OP,
                to_unsigned(0, 20) & A when SEND_A,
                (others => '0') when others;
                
  -- ALU registers              
  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        AR_s <= (others => '0');
        SR_s <= (others => '0');
      else
        case Operation is 
          when NOP => AR_s <= AR_s;
          when others => AR_s <= Result(19 downto 0);
        end case;

        case Operation is
          when ZERO_OP | AND_OP | OR_OP | XOR_OP =>
            Z <= Zc; N <= '0'; C <= '0'; V <= '0';
          when ADD_OP | SUB_OP | SHIFT_LEFT_OP | SHIFT_RIGHT_OP | INC_OP | DEC_OP =>
            Z <= Zc; N <= Nc; C <= Cc; V <= Vc;
          when MUL_OP => 
            Z <= Zc; N <= Nc; C <= Cc; V <= '0';
          when others =>
            SR_s <= SR_s;
        end case;
      end if;
    end if;
  end process;
  
  SR <= SR_s;
  AR <= AR_s;

end Behavioral;
