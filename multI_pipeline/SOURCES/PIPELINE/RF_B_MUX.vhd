----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:43:16 05/22/2020 
-- Design Name: 
-- Module Name:    RF_B_MUX - Behavioral 
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

entity RF_B_MUX is
    Port ( B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           outt : out  STD_LOGIC_VECTOR (31 downto 0));
end RF_B_MUX;

architecture Behavioral of RF_B_MUX is

begin

process(sel , Immed , B) begin

case (sel) is

when '0' => outt <= B;
when '1' => outt <= Immed;
when others => outt <= (others => 'X');
end case;
end process;
end Behavioral;

