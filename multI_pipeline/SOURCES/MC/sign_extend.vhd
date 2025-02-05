----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:57:49 04/21/2020 
-- Design Name: 
-- Module Name:    sign_extend - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sign_extend is
    Port ( Instr_im : in  STD_LOGIC_VECTOR (15 downto 0);
           op : in  STD_LOGIC_VECTOR (5 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end sign_extend;

architecture Behavioral of sign_extend is

signal Imm : std_logic_vector(31 downto 0);

begin process (op , Instr_im)
begin


if (op = "111000" or op = "110000" or op = "000011" or op = "000111" or op = "001111" or op = "011111") then
	Imm <= std_logic_vector(resize(signed(Instr_im), 32)); -- just sign extend
elsif (op = "110010" or op = "110011") then
	Imm <= std_logic_vector(resize(unsigned(Instr_im), 32)); --just zero fill
elsif (op = "111001") then
	Imm <= std_logic_vector(unsigned(std_logic_vector(resize(unsigned(Instr_im), 32))) sll 16); --lui
elsif ( op = "111111" or op = "000000" or op = "000001") then
	Imm <= std_logic_vector(unsigned(std_logic_vector(resize(signed(Instr_im), 32))) sll 2); 
else
   Imm <= (others => '0');
end if;
end process;
Immed <= Imm;
end Behavioral;

