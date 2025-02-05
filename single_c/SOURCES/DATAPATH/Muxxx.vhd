----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:55:10 04/22/2020 
-- Design Name: 
-- Module Name:    Muxxx - Behavioral 
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

entity Mulxxx is
    Port ( RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           outt : out  STD_LOGIC_VECTOR (31 downto 0));
end Mulxxx;

architecture Behavioral of Mulxxx is

begin
process (ALU_Bin_sel , RF_B , Immed) begin
case (ALU_Bin_sel) is

when '0' => outt <= RF_B;
when '1' => outt <= Immed;
when others => outt <= (others =>'0');

end case;
end process;
end Behavioral;

