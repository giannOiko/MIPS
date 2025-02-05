----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:53:28 05/21/2020 
-- Design Name: 
-- Module Name:    IF_Adder4 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IF_Adder4 is
PORT(   PC : in std_logic_vector(31 downto 0);
		  PC_4 : out std_logic_vector (31 downto 0));

end IF_Adder4;

architecture Behavioral of IF_Adder4 is

begin

PC_4 <= std_logic_vector(unsigned(PC) + 4);

end Behavioral;

