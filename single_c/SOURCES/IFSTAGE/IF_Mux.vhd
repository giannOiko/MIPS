----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:24:07 04/17/2020 
-- Design Name: 
-- Module Name:    IF_Mux - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IF_Mux is
    Port ( PC_4 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           Mux_outt : out  STD_LOGIC_VECTOR (31 downto 0));
end IF_Mux;

architecture Behavioral of IF_Mux is

begin
process (sel,PC_4,PC_Immed) 
begin
	case sel is 
		when '0' => Mux_outt <= PC_4;
		when '1' => Mux_outt <= PC_Immed;
		when others => null;		
end case;
end process;
end Behavioral;

