----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:55:10 04/17/2020 
-- Design Name: 
-- Module Name:    Adder_Immed - Behavioral 
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

entity Adder_Immed is
    Port ( SE_PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_4 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Adder_out : out STD_LOGIC_VECTOR (31 downto 0));
end Adder_Immed;

architecture Behavioral of Adder_Immed is

begin

Adder_out <= STD_LOGIC_VECTOR(unsigned(SE_PC_Immed) + unsigned(PC_4));

end Behavioral;

