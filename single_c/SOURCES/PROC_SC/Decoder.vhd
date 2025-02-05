----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:42:27 04/12/2020 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

entity Decoder is
    Port ( awr : in  STD_LOGIC_VECTOR (4 downto 0);
           outt : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder;

architecture Behavioral of Decoder is

signal outt0 : STD_LOGIC_VECTOR (31 downto 0);

begin

process(awr)
begin
outt0(0) <= ((not awr(4)) and (not awr(3)) and (not awr(2)) and (not awr(1)) and (not awr(0)));
outt0(1) <= ((not awr(4)) and (not awr(3)) and (not awr(2)) and (not awr(1)) and awr(0));
outt0(2) <= ((not awr(4)) and (not awr(3)) and (not awr(2)) and awr(1) and (not awr(0)));
outt0(3) <= ((not awr(4)) and (not awr(3)) and (not awr(2)) and awr(1) and awr(0));
outt0(4) <= ((not awr(4)) and (not awr(3)) and awr(2) and (not awr(1)) and (not awr(0)));
outt0(5) <= ((not awr(4)) and (not awr(3)) and awr(2) and (not awr(1)) and awr(0));
outt0(6) <= ((not awr(4)) and (not awr(3)) and awr(2) and awr(1) and (not awr(0)));
outt0(7) <= ((not awr(4)) and (not awr(3)) and awr(2) and awr(1) and awr(0));
outt0(8) <= ((not awr(4)) and awr(3) and (not awr(2)) and (not awr(1)) and (not awr(0)));
outt0(9) <= ((not awr(4)) and awr(3) and (not awr(2)) and (not awr(1)) and awr(0));
outt0(10) <= ((not awr(4)) and awr(3) and (not awr(2)) and awr(1) and (not awr(0)));
outt0(11) <= ((not awr(4)) and awr(3) and (not awr(2)) and awr(1) and awr(0));
outt0(12) <= ((not awr(4)) and awr(3) and awr(2) and (not awr(1)) and (not awr(0)));
outt0(13) <= ((not awr(4)) and awr(3) and awr(2) and (not awr(1)) and awr(0));
outt0(14) <= ((not awr(4)) and awr(3) and awr(2) and awr(1) and (not awr(0)));
outt0(15) <= ((not awr(4)) and awr(3) and awr(2) and awr(1) and awr(0));
outt0(16) <= (awr(4) and (not awr(3)) and (not awr(2)) and (not awr(1)) and (not awr(0)));
outt0(17) <= (awr(4) and (not awr(3)) and (not awr(2)) and (not awr(1)) and awr(0));
outt0(18) <= (awr(4) and (not awr(3)) and (not awr(2)) and awr(1) and (not awr(0)));
outt0(19) <= (awr(4) and (not awr(3)) and (not awr(2)) and awr(1) and awr(0));
outt0(20) <= (awr(4) and (not awr(3)) and awr(2) and (not awr(1)) and (not awr(0)));
outt0(21) <= (awr(4) and (not awr(3)) and awr(2) and (not awr(1)) and awr(0));
outt0(22) <= (awr(4) and (not awr(3)) and awr(2) and awr(1) and (not awr(0)));
outt0(23) <= (awr(4) and (not awr(3)) and awr(2) and awr(1) and awr(0));
outt0(24) <= (awr(4) and awr(3) and (not awr(2)) and (not awr(1)) and (not awr(0)));
outt0(25) <= (awr(4) and awr(3) and (not awr(2)) and (not awr(1)) and awr(0));
outt0(26) <= (awr(4) and awr(3) and (not awr(2)) and awr(1) and (not awr(0)));
outt0(27) <= (awr(4) and awr(3) and (not awr(2)) and awr(1) and awr(0));
outt0(28) <= (awr(4) and awr(3) and awr(2) and (not awr(1)) and (not awr(0)));
outt0(29) <= (awr(4) and awr(3) and awr(2) and (not awr(1)) and awr(0));
outt0(30) <= (awr(4) and awr(3) and awr(2) and awr(1) and (not awr(0)));
outt0(31) <= (awr(4) and awr(3) and awr(2) and awr(1) and awr(0));
end process;

outt <= outt0 after 10 ns;

end Behavioral;

