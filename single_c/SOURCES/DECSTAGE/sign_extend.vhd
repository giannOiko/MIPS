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
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end sign_extend;

architecture Behavioral of sign_extend is

signal Imm : std_logic_vector(31 downto 0);

begin process (ImmExt , Instr_im)
begin

case (ImmExt) is

when "00" => Imm <= std_logic_vector(resize(signed(Instr_im), 32)); -- just sign extend
when "01" => Imm <= std_logic_vector(resize(unsigned(Instr_im), 32)); --just zero fill
when "10" => Imm <= std_logic_vector(unsigned(std_logic_vector(resize(unsigned(Instr_im), 32))) sll 16); --lui
when "11" => Imm <= std_logic_vector(unsigned(std_logic_vector(resize(signed(Instr_im), 32))) sll 2); 
when others => Imm <= (others => '0');
end case;
end process;
Immed <= Imm;
end Behavioral;

