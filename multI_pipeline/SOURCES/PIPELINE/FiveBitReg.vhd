----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:03:50 05/22/2020 
-- Design Name: 
-- Module Name:    FiveBitReg - Behavioral 
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

entity FiveBitReg is
Port ( RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (4 downto 0);
           Dataout : out  STD_LOGIC_VECTOR (4 downto 0));
end FiveBitReg;

architecture Behavioral of FiveBitReg is

begin process
begin 

wait until CLK'event and CLK='1';

if(RST = '1') then
	Dataout <=(OTHERS => '0');
elsif (RST = '0') and (WE = '1') then
	Dataout <= Datain after 10 ns;
else 
	null;
end if;

end process;

end Behavioral;
