-- PmodKYPD_demo
-- Demo of PmodKYPD
-- Board: Nexys3 @ 100MHz
-- Description: Key value will be displayed on rightmost 7-segment indicator,
-- 	decimal point indicates strobe (while key is pressed).
-- Author: andni65
-- Date: 2022-05-27

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PmodKYPD_demo is
    Port ( 
        clk : in  std_logic;
        rst : in std_logic;
        JA : inout  std_logic_vector (7 downto 0); --
        key_out : out std_logic_vector (3 downto 0));
                                               
end PmodKYPD_demo;

architecture func of PmodKYPD_demo is

component PmodKYPD is
    Port (
        clk : in  std_logic;
        rst : in std_logic;
        row : in  std_logic_vector (3 downto 0);
        col : out  std_logic_vector (3 downto 0);
        key : out  std_logic_vector (3 downto 0)
    );
end component;

begin
        
    C0: PmodKYPD port map (clk=>clk, rst=>rst, row =>JA(7 downto 4), col=>JA(3 downto 0), key=>key_out);


end;

