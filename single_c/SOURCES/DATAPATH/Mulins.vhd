----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:38:43 04/22/2020 
-- Design Name: 
-- Module Name:    Mulins - Behavioral 
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

entity Mulins is
    Port ( InsAdrA : in  STD_LOGIC_VECTOR (4 downto 0);
           InsAdrB : in  STD_LOGIC_VECTOR (4 downto 0);
           RF_B_sel : in  STD_LOGIC;
           Adr : out  STD_LOGIC_VECTOR (4 downto 0));
end Mulins;

architecture Behavioral of Mulins is

begin
process (RF_B_sel , InsAdrA , InsAdrB) begin
case (RF_B_sel) is

when '0' => Adr <= InsAdrA;
when '1' => Adr <= InsAdrB;
when others => Adr <= (others =>'0');

end case;
end process;
end Behavioral;

