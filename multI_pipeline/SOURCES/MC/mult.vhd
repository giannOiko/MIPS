----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:13:38 05/14/2020 
-- Design Name: 
-- Module Name:    mult - Behavioral 
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

entity mult is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           outt : out  STD_LOGIC_VECTOR (31 downto 0));
end mult;

architecture Behavioral of mult is

begin
process (sel , A , B) begin
case (sel) is

when '0' => outt <= A;
when '1' => outt <= B;
when others => outt <= (others =>'0');

end case;
end process;
end Behavioral;

