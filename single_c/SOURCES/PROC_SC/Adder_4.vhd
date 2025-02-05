----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:42:09 04/17/2020 
-- Design Name: 
-- Module Name:    Adder_4 - Behavioral 
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

entity Adder_4 is
    Port ( pc : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_4 : out  STD_LOGIC_VECTOR (31 downto 0));
end Adder_4;


architecture Behavioral of Adder_4 is



begin
	pc_4 <= std_logic_vector(unsigned(pc) + 4);

end Behavioral;

